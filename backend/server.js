// Minimal backend runtime required by the AI chatbot.
// Serves static files and exposes POST /api/chatbot/query
// Gemini API calls are done server-side using GEMINI_API_KEY.

const express = require('express');
const path = require('path');
const https = require('https');
const fs = require('fs');

// Simple dependency-free environment loader
const envPaths = [path.join(__dirname, '.env'), path.join(__dirname, '..', '.env')];
for (const envPath of envPaths) {
  if (fs.existsSync(envPath)) {
    const envContent = fs.readFileSync(envPath, 'utf8');
    envContent.split(/\r?\n/).forEach(line => {
      const parts = line.split('=');
      if (parts.length >= 2) {
        const key = parts[0].trim();
        const val = parts.slice(1).join('=').trim().replace(/^['"]|['"]$/g, '');
        if (key && !key.startsWith('#')) {
          process.env[key] = val;
        }
      }
    });
  }
}

const { generateGeminiResponse } = require('./geminiClient');

const SUPABASE_URL = 'https://jkblwihozkqorberantm.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImprYmx3aWhvemtxb3JiZXJhbnRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQ1NTU5MTcsImV4cCI6MjEwMDEzMTkxN30.iDwjs2fKpcL4eRLoXiRYvr3hFG7M3uwWJMuC4vPadwk';

// Helper to support native Node fetch or fallback to https module on older Node runtimes
async function safeFetch(url, options = {}) {
  if (typeof globalThis.fetch === 'function') {
    return globalThis.fetch(url, options);
  }
  return new Promise((resolve, reject) => {
    const urlObj = new URL(url);
    const reqOptions = {
      method: options.method || 'GET',
      headers: options.headers || {},
      hostname: urlObj.hostname,
      path: urlObj.pathname + urlObj.search,
      port: urlObj.port || 443
    };

    const req = https.request(reqOptions, (res) => {
      let data = '';
      res.on('data', (chunk) => { data += chunk; });
      res.on('end', () => {
        resolve({
          ok: res.statusCode >= 200 && res.statusCode < 300,
          status: res.statusCode,
          json: async () => JSON.parse(data),
          text: async () => data
        });
      });
    });

    req.on('error', (err) => { reject(err); });

    if (options.body) {
      req.write(options.body);
    }
    req.end();
  });
}

// Clean and extract student username and password from chat query
function extractCredentials(message) {
  const clean = message.replace(/possword/i, 'password');
  let username = '';
  let password = '';

  const userIndex = clean.toLowerCase().indexOf('username');
  const passIndex = clean.toLowerCase().indexOf('password');
  
  if (userIndex !== -1 && passIndex !== -1) {
    if (userIndex < passIndex) {
      const userPart = clean.slice(userIndex + 8, passIndex);
      const passPart = clean.slice(passIndex + 8);
      username = userPart;
      password = passPart;
    } else {
      const passPart = clean.slice(passIndex + 8, userIndex);
      const userPart = clean.slice(userIndex + 8);
      username = userPart;
      password = passPart;
    }
  } else {
    const uIdx = clean.toLowerCase().indexOf('user');
    const pIdx = clean.toLowerCase().indexOf('pass');
    if (uIdx !== -1 && pIdx !== -1) {
      if (uIdx < pIdx) {
        username = clean.slice(uIdx + 4, pIdx);
        password = clean.slice(pIdx + 4);
      } else {
        password = clean.slice(pIdx + 4, uIdx);
        username = clean.slice(uIdx + 4);
      }
    }
  }

  // Clean trailing conjunctions and punctuations
  const cleanPart = (part) => part
    .replace(/^[:\s,;]+|[:\s,;]+$/g, '')
    .replace(/\s+and\s*$/i, '')
    .replace(/\s+with\s*$/i, '')
    .replace(/[.,;]+$/, '')
    .trim();

  username = cleanPart(username);
  password = cleanPart(password);

  if (username && password) {
    return { username, password };
  }
  return null;
}

// Authenticates student and fetches marks from Supabase
async function getStudentMarks(username, password) {
  try {
    // 1. Authenticate via verify_student_login RPC
    const loginRes = await safeFetch(`${SUPABASE_URL}/rest/v1/rpc/verify_student_login`, {
      method: 'POST',
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ p_username: username, p_password: password })
    });

    if (!loginRes.ok) return null;
    const loginData = await loginRes.json();
    const user = loginData && loginData[0];
    if (!user || !user.success) return null;

    // 2. Fetch internal marks for the student
    const marksRes = await safeFetch(`${SUPABASE_URL}/rest/v1/internal_marks?student_id=eq.${user.student_id}`, {
      method: 'GET',
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      }
    });
    if (!marksRes.ok) return null;
    const marks = await marksRes.json();

    // 3. Fetch subjects to resolve subject names
    const subRes = await safeFetch(`${SUPABASE_URL}/rest/v1/subjects`, {
      method: 'GET',
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      }
    });
    const subjects = subRes.ok ? await subRes.json() : [];

    // Map marks to subjects
    const resolvedMarks = marks.map(m => {
      const sub = subjects.find(s => s.subject_id === m.subject_id);
      return {
        subjectCode: sub ? sub.subject_code : `SUB${m.subject_id}`,
        subjectName: sub ? sub.subject_name : 'Unknown Subject',
        ia1: m.ia1,
        ia2: m.ia2,
        modelExam: m.model_exam,
        assignment: m.assignment,
        attendanceMark: m.attendance_mark
      };
    });

    return {
      studentName: user.name || user.username,
      studentId: user.student_id,
      marks: resolvedMarks
    };
  } catch (err) {
    console.error('Error fetching student marks from Supabase:', err);
    return null;
  }
}

const app = express();

app.use(express.json({ limit: '256kb' }));
app.use(express.urlencoded({ extended: true }));

// CORS for local/static usage
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  if (req.method === 'OPTIONS') return res.status(204).end();
  next();
});

app.use('/edit', express.static(path.join(__dirname, '..', '..', 'edit')));
app.use(express.static(path.join(__dirname, '..')));

function getSmartFallbackResponse(text) {
  const q = (text || '').toLowerCase();
  if (q.includes('hi') || q.includes('hello') || q.includes('hey')) {
    return "Hello! Welcome to Saranathan College of Engineering AI Portal. How can I assist you with book stacks, classroom locations, faculty cabins, exam timetables, or placements eligibility today?";
  } else if (q.includes('ai') || q.includes('artificial intelligence')) {
    return "🤖 **Artificial Intelligence (AI)** is the simulation of human intelligence in machines programmed to think, learn, and solve problems. Key subfields include Machine Learning, Deep Learning, Natural Language Processing, and Computer Vision.";
  } else if (q.includes('dbms') || q.includes('database lab')) {
    return "💻 **DBMS Lab Location**: Located on the **2nd Floor of the CSE Block (Room CSE-204)**. Equipped with Oracle Database, MySQL, and PostgreSQL workstations.";
  } else if (q.includes('os book') || q.includes('operating system book') || q.includes('locate os')) {
    return "📚 **Operating System Books**: Located in the Central Library, **2nd Floor, Rack R-12, Shelf B**. Books by Silberschatz, Galvin, and Tanenbaum are available.";
  } else if (q.includes('kumar') || q.includes('dr. kumar') || q.includes('cabin')) {
    return "🚪 **Dr. Kumar's Cabin**: Located on the **1st Floor, Admin Block (Cabin A-108)**. Office hours for student consultation: 11:30 AM - 1:00 PM and 3:30 PM - 4:30 PM.";
  } else if (q.includes('placement') || q.includes('job') || q.includes('eligibility')) {
    return "🎯 **Placement Eligibility Rules**:\n- Minimum **60% (6.0 CGPA)** aggregate without standing arrears.\n- Minimum 75% attendance across all semesters.\n- Mandatory completion of Campus Recruitment Training (CRT) modules.";
  } else if (q.includes('bus') || q.includes('timings') || q.includes('transport')) {
    return "🚌 **Bus Timings**: Routes 08, 15, 22, and 31 start from major city stops at **7:15 AM - 7:30 AM** and arrive at campus by 8:15 AM. Return buses leave at 4:45 PM.";
  } else if (q.includes('hour') || q.includes('timing') || q.includes('working')) {
    return "⏰ **College Hours**:\n- Campus Hours: 8:30 AM - 4:30 PM (Monday to Saturday)\n- Central Library: 8:00 AM - 8:00 PM\n- Lunch Break: 12:30 PM - 1:20 PM";
  } else if (q.includes('cse') || q.includes('computer science')) {
    return "🖥️ **Computer Science & Engineering Department**:\n- Department Head: Dr. S. Rajkumar\n- Labs: DBMS Lab, AI & ML Lab, Cloud Computing Lab, Network Security Lab\n- Location: CSE Block, 1st & 2nd Floors.";
  } else if (q.includes('poem')) {
    return "✨ *Amidst green trees and bustling halls,*\n*Where knowledge echoes through classroom walls,*\n*We code, we learn, we dream so bright,*\n*Saranathan guides our future's light.* 🎓";
  } else if (q.includes('fees') || q.includes('pending')) {
    return "💳 You can verify and pay tuition or hostel fees on your **Student Dashboard Home Overview** section using the sandbox payment portal.";
  }
  return "I am the Saranathan AI Assistant. I can help you find campus locations, DBMS lab, library book racks, faculty cabins, placement eligibility, or student internal marks!";
}

app.post('/api/chatbot/query', async (req, res) => {
  try {
    const message = req?.body?.message;
    if (!message || typeof message !== 'string') {
      return res.status(400).json({ success: false, message: 'Missing message' });
    }

    const apiKey = process.env.GEMINI_API_KEY;
    const model = process.env.GEMINI_MODEL || 'gemini-1.5-flash';
    let systemInstruction =
      'You are Saranathan College AI assistant. Answer concisely and help the student locate relevant campus resources (library, DBMS lab, OS books, cabins, timings, placements eligibility, fee/payment guidance) without inventing facts. If unsure, suggest checking the relevant portal section.';

    // Check for student username & password credentials in the chat prompt
    const credentials = extractCredentials(message);
    if (credentials) {
      console.log(`AI Chatbot: Authenticating credentials for username "${credentials.username}"...`);
      const studentData = await getStudentMarks(credentials.username, credentials.password);
      
      if (studentData) {
        // Feed the student marks data context to the system prompt
        systemInstruction += `\n\n[STUDENT DATA CONTEXT]\nStudent Name: ${studentData.studentName}\nStudent ID: ${studentData.studentId}\nInternal Marks:\n${JSON.stringify(studentData.marks, null, 2)}\n\nPlease summarize the marks for this student. Present them in a neat text table format with columns for Subject Code, Subject Name, IA1, IA2, Model Exam, Assignment, and Attendance Mark. Conclude with a helpful, encouraging remark.`;
      } else {
        // Terminate and return authentication failure message
        return res.status(200).json({ 
          success: true, 
          response: "⚠️ **Authentication Failed.** I was unable to verify your student login credentials. Please ensure your username and password are correct." 
        });
      }
    }

    try {
      const geminiResult = await generateGeminiResponse({
        apiKey,
        model,
        message,
        systemInstruction
      });

      if (geminiResult && geminiResult.text) {
        return res.status(200).json({ success: true, response: geminiResult.text, model: geminiResult.model });
      }
    } catch (geminiErr) {
      console.warn('Gemini API call failed, trying live free AI engine:', geminiErr.message);
    }

    // Try live AI generation engine if Gemini API fails
    try {
      const fullPrompt = systemInstruction ? `${systemInstruction}\n\nUser Question: ${message}` : message;
      const liveAiRes = await safeFetch(`https://text.pollinations.ai/${encodeURIComponent(fullPrompt)}`);
      if (liveAiRes.ok) {
        const textOut = await liveAiRes.text();
        if (textOut && textOut.trim() && !textOut.includes('"error":')) {
          return res.status(200).json({ success: true, response: textOut.trim(), model: 'Saranathan AI Engine' });
        }
      }
    } catch (e) {
      console.warn('Live AI engine error:', e.message);
    }

    // Fallback to intelligent local AI assistant response
    const fallbackResponse = getSmartFallbackResponse(message);
    return res.status(200).json({ success: true, response: fallbackResponse, fallback: true });
  } catch (err) {
    console.error('Server error:', err);
    return res.status(500).json({ success: false, message: 'Chatbot query failed', response: '' });
  }
});

// Fallback
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '..', 'index.html'));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Backend running at http://localhost:${PORT}`);
});


