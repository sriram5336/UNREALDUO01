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

    const responseText = await generateGeminiResponse({
      apiKey,
      model,
      message,
      systemInstruction
    });

    if (!responseText) {
      return res.status(200).json({ success: false, message: 'Gemini returned empty response', response: '' });
    }

    return res.status(200).json({ success: true, response: responseText });
  } catch (err) {
    console.error('Gemini error:', err);
    return res.status(500).json({ success: false, message: 'Gemini query failed', response: '' });
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


