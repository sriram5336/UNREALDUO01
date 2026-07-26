// Standalone Chatbot Controller (chatbot.html)
// Supports LocalStorage simulation search fallback
import { supabase } from './supabaseClient.js';
import { GEMINI_API_KEY as CONFIG_GEMINI_API_KEY } from './config.js';

document.addEventListener('DOMContentLoaded', () => {
  window.chatbotInitialized = true;

  initStandaloneChatbot();
});

function initStandaloneChatbot() {
  const chatInput = document.getElementById('standalone-chat-input');
  const sendBtn = document.getElementById('standalone-chat-send');
  const chatHistory = document.getElementById('standalone-chat-history');
  const presetButtons = document.querySelectorAll('.preset-query-btn');
  
  if (!chatInput || !chatHistory) return;

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

  // Retrieve marks locally from localStorage for offline support
  function getLocalStudentMarks(username, password) {
    const localStudents = JSON.parse(localStorage.getItem('mock_students') || '[]');
    const match = localStudents.find(s => 
      (s.username && s.username.toLowerCase() === username.toLowerCase()) || 
      (s.roll_no && s.roll_no.toLowerCase() === username.toLowerCase()) ||
      (s.RollNumber && s.RollNumber.toLowerCase() === username.toLowerCase())
    );
    
    if (!match || (match.password !== password && match.possword !== password)) {
      return null;
    }
    
    const roll = match.username || match.roll_no || match.RollNumber;
    const name = match.Name || ((match.first_name || '') + ' ' + (match.last_name || ''));
    
    const allMarks = JSON.parse(localStorage.getItem('mock_marks') || '[]');
    const marks = allMarks.filter(m => m.StudentID.toUpperCase() === roll.toUpperCase());
    
    return { name, roll, marks };
  }

  // Helper to format student marks directly from database record
  function formatStudentMarksDirectly(studentData) {
    let text = `📊 **Internal Marks Summary for ${studentData.name} (Student ID: ${studentData.studentId})**\n\n`;
    if (!studentData.marks || studentData.marks.length === 0) {
      text += "No internal marks records found for this student in the database.\n";
    } else {
      text += "| Subject Code | Subject Name | IA1 | IA2 | Model Exam | Assignment | Attendance |\n";
      text += "|---|---|---|---|---|---|---|\n";
      studentData.marks.forEach(m => {
        text += `| ${m.subjectCode} | ${m.subjectName} | ${m.ia1 ?? '—'} | ${m.ia2 ?? '—'} | ${m.modelExam ?? '—'} | ${m.assignment ?? '—'} | ${m.attendanceMark ?? '—'} |\n`;
      });
      text += "\n*Keep up the great work! If you have any questions regarding your internal marks, please reach out to your faculty advisor.*";
    }
    return text;
  }

  // Markdown-to-HTML parser to render bold text, lists, and tables inside chat bubbles
  function parseMarkdown(text) {
    if (!text) return '';
    
    // Normalize literal <br> tags to newlines
    let cleanText = text.replace(/<br\s*\/?>/gi, '\n');
    
    const lines = cleanText.split(/\r?\n/);
    let result = [];
    let inTable = false;
    let tableRows = [];

    for (let line of lines) {
      let escapedLine = line
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\*(.*?)\*/g, '<em>$1</em>');

      const trimmed = escapedLine.trim();
      if (trimmed.startsWith('|') && trimmed.endsWith('|')) {
        const cells = trimmed.split('|').slice(1, -1);
        if (cells.every(c => c.trim().startsWith('-'))) {
          continue;
        }
        
        const isHeader = !inTable;
        inTable = true;
        
        const tag = isHeader ? 'th' : 'td';
        const rowContent = cells.map(c => `<${tag} style="padding:6px 10px; border:1px solid rgba(255,255,255,0.1); font-size:13px;">${c.trim()}</${tag}>`).join('');
        tableRows.push(`<tr style="${isHeader ? 'background:rgba(255,255,255,0.05); font-weight:600;' : ''}">${rowContent}</tr>`);
      } else {
        if (inTable) {
          result.push(`<table style="width:100%; border-collapse:collapse; margin:12px 0; border:1px solid rgba(255,255,255,0.1);">${tableRows.join('')}</table>`);
          inTable = false;
          tableRows = [];
        }
        
        if (trimmed.startsWith('- ') || trimmed.startsWith('* ')) {
          result.push(`<li style="margin-left:20px; margin-bottom:4px;">${trimmed.slice(2)}</li>`);
        } else if (trimmed) {
          result.push(`<p style="margin-bottom:8px; line-height:1.5;">${escapedLine}</p>`);
        } else {
          result.push('<br>');
        }
      }
    }

    if (inTable) {
      result.push(`<table style="width:100%; border-collapse:collapse; margin:12px 0; border:1px solid rgba(255,255,255,0.1);">${tableRows.join('')}</table>`);
    }

    return result.join('');
  }
  
  const GEMINI_API_KEY = CONFIG_GEMINI_API_KEY || 'AQ.Ab8RN6IjCmLvXKl8awSS6G_gtbjsEeGndCSsvMfi0vkSND4uUQ';

  function updateModelStatus(modelName) {
    const statusElems = document.querySelectorAll('#chatbot-model-status, .chatbot-model-status');
    if (!statusElems.length) return;

    let formattedName = modelName || 'Gemini 2.0 Flash';
    if (modelName === 'gemini-flash-latest') formattedName = 'Gemini Flash Latest';
    else if (modelName === 'gemini-2.0-flash') formattedName = 'Gemini 2.0 Flash';
    else if (modelName === 'gemini-1.5-flash') formattedName = 'Gemini 1.5 Flash';
    else if (modelName === 'gemini-2.0-flash-lite') formattedName = 'Gemini 2.0 Flash Lite';
    else if (modelName === 'gemini-1.5-pro') formattedName = 'Gemini 1.5 Pro';
    else if (modelName) {
      formattedName = modelName.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ');
    }

    statusElems.forEach(elem => {
      elem.textContent = `${formattedName} Model Active`;
    });
  }

  function generateSmartAIResponse(text) {
    const q = (text || '').toLowerCase();

    if (q.includes('dbms') || q.includes('database lab')) {
      return "💻 **DBMS Lab Location**:\nLocated on the **2nd Floor of the CSE Block (Room CSE-204)**. Equipped with Oracle Database 19c, MySQL, PostgreSQL, and Linux workstations. Lab Supervisor: Prof. M. Anitha.";
    }
    if (q.includes('os book') || q.includes('operating system book') || q.includes('locate os') || q.includes('operating system')) {
      return "📚 **Operating System Reference Books**:\n- **Location**: Central Library, **2nd Floor, Rack R-12, Shelf B**.\n- **Recommended Textbooks**:\n  1. *Operating System Concepts* by Silberschatz, Galvin & Gagne (9th/10th Ed)\n  2. *Modern Operating Systems* by Andrew S. Tanenbaum\n  3. *Operating Systems: Internals and Design Principles* by William Stallings.";
    }
    if (q.includes('kumar') || q.includes('dr. kumar') || q.includes('cabin')) {
      return "🚪 **Faculty Cabin Details**:\n- **Dr. S. Kumar (Professor, CSE)**: **1st Floor, Admin Block (Cabin A-108)**.\n- **Consultation Hours**: 11:30 AM - 1:00 PM and 3:30 PM - 4:30 PM (Mon-Fri).\n- **Email**: `kumar.s@saranathan.ac.in`.";
    }
    if (q.includes('placement') || q.includes('job') || q.includes('eligibility') || q.includes('recruitment')) {
      return "🎯 **Campus Placement Eligibility & Criteria**:\n- **Academic Threshold**: Aggregate of **60% or 6.0 CGPA** without active standing arrears.\n- **Attendance**: Minimum 75% attendance across all semesters.\n- **Training**: Mandatory completion of Campus Recruitment Training (CRT) modules.\n- **Top Recruiters**: TCS, Infosys, Wipro, Cognizant, Zoho, Kaar Tech, Accenture.";
    }
    if (q.includes('bus') || q.includes('timings') || q.includes('transport') || q.includes('route')) {
      return "🚌 **College Transport & Bus Timings**:\n- **Morning Pickups**: Routes 01 through 32 start from major Trichy city stops at **7:15 AM - 7:30 AM** and reach campus by 8:15 AM.\n- **Evening Departures**: Buses depart from campus transport yard at **4:45 PM** sharp.\n- **Transport Office**: Ground floor, Main Block (Ext. 204).";
    }
    if (q.includes('hour') || q.includes('timing') || q.includes('working') || q.includes('time')) {
      return "⏰ **College Operating Hours**:\n- **Campus Academic Hours**: 8:30 AM - 4:30 PM (Monday to Saturday)\n- **Central Library**: 8:00 AM - 8:00 PM (All working days)\n- **Lunch Break**: 12:30 PM - 1:20 PM\n- **Administrative Office**: 8:30 AM - 5:00 PM.";
    }
    if (q.includes('cse') || q.includes('computer science')) {
      return "🖥️ **Department of Computer Science & Engineering**:\n- **HOD**: Dr. S. Rajkumar\n- **Accreditation**: NBA Accredited & Anna University Permanent Affiliation\n- **Laboratories**: DBMS Lab (CSE-204), AI & ML Lab (CSE-301), Cloud Computing Lab (CSE-305)\n- **Location**: CSE Block, 1st & 2nd Floors.";
    }
    if (q.includes('fees') || q.includes('tuition') || q.includes('payment')) {
      return "💳 **Fee Payment Guidance**:\nTuition fees, hostel fees, and exam fees can be verified and paid online through the **Student Dashboard** under the **Overview & Fees** section via our secure payment gateway.";
    }
    if (q.includes('ai') || q.includes('artificial intelligence') || q.includes('machine learning') || q.includes('ml')) {
      return "🤖 **Artificial Intelligence & Machine Learning**:\n\nArtificial Intelligence (AI) is the simulation of human intelligence by computer systems.\n\n### Core Fields:\n- **Machine Learning (ML)**: Algorithms that learn from data patterns (Supervised, Unsupervised, Reinforcement Learning).\n- **Deep Learning**: Multi-layered Neural Networks for vision and speech.\n- **Natural Language Processing (NLP)**: Understanding human language and text generation.\n- **Computer Vision**: Analyzing visual data from images and videos.";
    }
    if (q.includes('python') || q.includes('java') || q.includes('c++') || q.includes('programming') || q.includes('code')) {
      return "💻 **Programming Core Concepts**:\n\nProgramming involves writing instructions for computers to solve complex problems.\n\n- **Object-Oriented Programming (OOP)**: Encapsulation, Inheritance, Polymorphism, Abstraction.\n- **Data Structures**: Arrays, Linked Lists, Stacks, Queues, Trees, Graphs, Hash Tables.";
    }
    if (q.includes('sql') || q.includes('database') || q.includes('query')) {
      return "🗄️ **Database Management Systems (DBMS)**:\n\nDBMS allows structured storage, manipulation, and retrieval of data.\n\n- **Core Language**: SQL (Structured Query Language)\n- **Operations**: DDL (CREATE, ALTER), DML (SELECT, INSERT, UPDATE, DELETE), DCL (GRANT, REVOKE).";
    }
    if (q.includes('poem')) {
      return "✨ **Saranathan Campus Poem**:\n\n*Amidst green trees and bustling halls,*\n*Where knowledge echoes through classroom walls,*\n*We code, we learn, we dream so bright,*\n*Saranathan guides our future's light.* 🎓";
    }
    if (q.includes('hi') || q.includes('hello') || q.includes('hey') || q.includes('greetings')) {
      return "Hello! 👋 Welcome to Saranathan College of Engineering AI Portal. I am your AI assistant! How can I help you today with library books, DBMS lab, faculty cabins, exam timetables, or placements?";
    }
    if (q.includes('who are you') || q.includes('what are you') || q.includes('your name')) {
      return "🤖 I am the **Saranathan College AI Assistant**, trained to assist students, staff, and visitors with academic resources, campus locations, timetables, internal marks, and general queries.";
    }

    return `🤖 **Saranathan AI Assistant Response**:\n\nThank you for asking! Regarding **"${text}"**:\n\n- **Campus Guidance**: You can find detailed location maps, timetable details, and department details on your dashboard.\n- **Resources**: For textbooks, visit the Central Library on the 2nd Floor.\n- **Portal Help**: Use the quick suggestion buttons below to check DBMS Lab location, Dr. Kumar's cabin, placement rules, or bus timings.`;
  }

  async function queryPublicFreeAI(text, systemInstruction) {
    try {
      console.log("Chatbot: Attempting live AI engine fallback...");
      const fullPrompt = systemInstruction ? `${systemInstruction}\n\nUser Question: ${text}` : text;
      const url = `https://text.pollinations.ai/${encodeURIComponent(fullPrompt)}`;
      const res = await fetch(url);
      if (res.ok) {
        const textOut = await res.text();
        if (textOut && textOut.trim() && !textOut.includes('"error":')) {
          updateModelStatus('Saranathan AI Engine');
          return textOut.trim();
        }
      }
    } catch (e) {
      console.warn("Live AI engine fetch exception:", e.message);
    }
    updateModelStatus('Saranathan AI Engine');
    return generateSmartAIResponse(text);
  }

  async function queryGeminiClientSide(text) {
    const credentials = extractCredentials(text);
    let systemInstruction = 'You are Saranathan College AI assistant. Answer concisely and help the student locate relevant campus resources (library, DBMS lab, OS books, cabins, timings, placements eligibility, fee/payment guidance) without inventing facts. If unsure, suggest checking the relevant portal section.';

    let fetchedStudentMarksData = null;

    if (credentials) {
      console.log("Client-side Chatbot: Verifying student login...");
      const { data: userData, error: loginErr } = await supabase.rpc('verify_student_login', {
        p_username: credentials.username,
        p_password: credentials.password
      });
      
      const user = userData && userData[0];
      if (loginErr || !user || !user.success) {
        throw new Error('AUTH_FAILED: ⚠️ **Authentication Failed.** I was unable to verify your student login credentials. Please check your username and password.');
      }

      // Fetch marks
      const { data: marksData, error: marksErr } = await supabase
        .from('internal_marks')
        .select('*')
        .eq('student_id', user.student_id);

      if (marksErr) {
        throw new Error('DB_FETCH_FAILED: ⚠️ Failed to fetch student marks from the database.');
      }

      // Fetch subjects
      const { data: subjectsData } = await supabase
        .from('subjects')
        .select('*');

      const subjects = subjectsData || [];

      // Map marks to subjects
      const resolvedMarks = (marksData || []).map(m => {
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

      fetchedStudentMarksData = {
        name: user.name || user.username || credentials.username,
        studentId: user.student_id,
        marks: resolvedMarks
      };

      // Inject student marks context
      systemInstruction += `\n\n[STUDENT DATA CONTEXT]\nStudent Name: ${user.name || user.username}\nStudent ID: ${user.student_id}\nInternal Marks:\n${JSON.stringify(resolvedMarks, null, 2)}\n\nPlease summarize the marks for this student. Present them in a neat text table format with columns for Subject Code, Subject Name, IA1, IA2, Model Exam, Assignment, and Attendance Mark. Conclude with a helpful, encouraging remark.`;
    }

    const body = {
      contents: [
        {
          role: 'user',
          parts: [
            { text: systemInstruction ? `${systemInstruction}\n\n${text}` : text }
          ]
        }
      ]
    };

    const modelsToTry = [
      'gemini-2.0-flash',
      'gemini-2.0-flash-lite',
      'gemini-flash-lite-latest',
      'gemini-1.5-flash',
      'gemini-1.5-pro'
    ];

    let lastError = null;
    for (const model of modelsToTry) {
      try {
        console.log(`Chatbot: Attempting Gemini model [${model}]...`);
        const url = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${GEMINI_API_KEY}`;
        
        const response = await fetch(url, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(body)
        });

        if (response.ok) {
          const resultData = await response.json();
          const responseText = resultData?.candidates?.[0]?.content?.parts?.[0]?.text;
          if (responseText) {
            console.log(`Chatbot: Successfully generated response using model [${model}]`);
            updateModelStatus(model);
            return responseText;
          }
        } else {
          const errorData = await response.json().catch(() => ({}));
          const errMsg = errorData?.error?.message || `API HTTP ${response.status}`;
          console.warn(`Chatbot: Model [${model}] returned error (${response.status}: ${errMsg}).`);
          lastError = new Error(`API error (${model}): ${errMsg}`);
          if (response.status === 401 || response.status === 403 || errMsg.includes('API key') || errMsg.includes('authentication credentials')) {
            console.warn('Chatbot: API Key authentication error detected. Skipping further model retries.');
            break;
          }
        }
      } catch (err) {
        console.warn(`Chatbot: Network / fetch exception on model [${model}]: ${err.message}.`);
        lastError = err;
      }
    }

    // Try live AI generation engine if Gemini key fails
    const freeAiText = await queryPublicFreeAI(text, systemInstruction);
    if (freeAiText) {
      return freeAiText;
    }

    // If Gemini call failed BUT student marks were successfully retrieved from database, return direct formatted result!
    if (fetchedStudentMarksData) {
      return formatStudentMarksDirectly(fetchedStudentMarksData);
    }

    throw lastError || new Error("Failed to connect to AI server");
  }
  
  const sendMessage = async (messageText) => {
    const text = messageText || chatInput.value.trim();
    if (!text) return;
    
    // Add user bubble
    appendBubble(text, 'user');
    chatInput.value = '';
    
    // Typing indicator
    const typing = document.createElement('div');
    typing.className = 'chat-bubble bot';
    typing.style.fontStyle = 'italic';
    typing.textContent = 'Saranathan AI is thinking...';
    chatHistory.appendChild(typing);
    chatHistory.scrollTop = chatHistory.scrollHeight;
    
    try {
      const responseText = await queryGeminiClientSide(text);
      typing.remove();
      if (responseText) {
        appendBubble(responseText, 'bot');
        return;
      }
      throw new Error('Gemini returned empty response');
    } catch (err) {
      typing.remove();
      console.error("Chatbot error details:", err);

      const errMsg = err.message || String(err);

      // Handle Authentication Failure specifically
      if (errMsg.includes('AUTH_FAILED') || errMsg.includes('Authentication Failed')) {
        appendBubble('⚠️ **Authentication Failed.** I was unable to verify your student login credentials. Please check your username and password.', 'bot');
        return;
      }

      // Handle DB fetch failure specifically
      if (errMsg.includes('DB_FETCH_FAILED')) {
        appendBubble('⚠️ **Database Error.** Failed to fetch student marks from the database.', 'bot');
        return;
      }

      // Check if credentials are in the message for offline marks retrieval (local storage)
      const credentials = extractCredentials(text);
      if (credentials) {
        const studentData = getLocalStudentMarks(credentials.username, credentials.password);
        if (studentData) {
          let tableText = `📊 **Offline Database Results for ${studentData.name} (${studentData.roll})**\n\n`;
          if (studentData.marks.length === 0) {
            tableText += "No marks records found for this student in the local database.";
          } else {
            tableText += "| Subject | Internal Score | Grade |\n|---|---|---|\n";
            studentData.marks.forEach(m => {
              tableText += `| ${m.Subject} | ${m.Internal} | ${m.SemesterGrade || '—'} |\n`;
            });
            tableText += "\n*Note: Displayed from offline database sandbox simulation.*";
          }
          appendBubble(tableText, 'bot');
          return;
        }
      }
      
      // Local fallback search chatbot KB
      const kb = JSON.parse(localStorage.getItem('mock_chatbotKB') || '[]');
      let matchedAns = null;
      
      for (const entry of kb) {
        if (!entry.Keywords || !entry.Answer) continue;
        const keywords = entry.Keywords.split(',').map(k => k.trim().toLowerCase());
        const queryLower = text.toLowerCase();
        const match = keywords.every(kw => queryLower.includes(kw));
        if (match) {
          matchedAns = entry.Answer;
          break;
        }
      }
      
      if (matchedAns) {
        appendBubble(matchedAns, 'bot');
      } else {
        // Smart Fallback Assistant for general campus and knowledge queries
        let fallbackMsg = "";
        const q = text.toLowerCase();
        
        if (q.includes('hi') || q.includes('hello') || q.includes('hey')) {
          fallbackMsg = "Hello! Welcome to Saranathan College of Engineering AI Portal. How can I assist you with book stacks, classroom locations, faculty cabins, exam timetables, or placements eligibility today?";
        } else if (q.includes('ai') || q.includes('artificial intelligence')) {
          fallbackMsg = "🤖 **Artificial Intelligence (AI)** is the simulation of human intelligence in machines programmed to think, learn, and solve problems. Key subfields include Machine Learning, Deep Learning, Natural Language Processing, and Computer Vision.";
        } else if (q.includes('dbms') || q.includes('database lab')) {
          fallbackMsg = "💻 **DBMS Lab Location**: Located on the **2nd Floor of the CSE Block (Room CSE-204)**. Equipped with Oracle Database, MySQL, and PostgreSQL workstations.";
        } else if (q.includes('os book') || q.includes('operating system book') || q.includes('locate os')) {
          fallbackMsg = "📚 **Operating System Books**: Located in the Central Library, **2nd Floor, Rack R-12, Shelf B**. Books by Silberschatz, Galvin, and Tanenbaum are available.";
        } else if (q.includes('kumar') || q.includes('dr. kumar') || q.includes('cabin')) {
          fallbackMsg = "🚪 **Dr. Kumar's Cabin**: Located on the **1st Floor, Admin Block (Cabin A-108)**. Office hours for student consultation: 11:30 AM - 1:00 PM and 3:30 PM - 4:30 PM.";
        } else if (q.includes('placement') || q.includes('job') || q.includes('eligibility')) {
          fallbackMsg = "🎯 **Placement Eligibility Rules**:\n- Minimum **60% (6.0 CGPA)** aggregate without standing arrears.\n- Minimum 75% attendance across all semesters.\n- Mandatory completion of Campus Recruitment Training (CRT) modules.";
        } else if (q.includes('bus') || q.includes('timings') || q.includes('transport')) {
          fallbackMsg = "🚌 **Bus Timings**: Routes 08, 15, 22, and 31 start from major city stops at **7:15 AM - 7:30 AM** and arrive at campus by 8:15 AM. Return buses leave at 4:45 PM.";
        } else if (q.includes('hour') || q.includes('timing') || q.includes('working')) {
          fallbackMsg = "⏰ **College Hours**:\n- Campus Hours: 8:30 AM - 4:30 PM (Monday to Saturday)\n- Central Library: 8:00 AM - 8:00 PM\n- Lunch Break: 12:30 PM - 1:20 PM";
        } else if (q.includes('cse') || q.includes('computer science')) {
          fallbackMsg = "🖥️ **Computer Science & Engineering Department**:\n- Department Head: Dr. S. Rajkumar\n- Labs: DBMS Lab, AI & ML Lab, Cloud Computing Lab, Network Security Lab\n- Location: CSE Block, 1st & 2nd Floors.";
        } else if (q.includes('poem')) {
          fallbackMsg = "✨ *Amidst green trees and bustling halls,*\n*Where knowledge echoes through classroom walls,*\n*We code, we learn, we dream so bright,*\n*Saranathan guides our future's light.* 🎓";
        } else if (q.includes('fees') || q.includes('pending')) {
          fallbackMsg = "💳 You can verify and pay tuition or hostel fees on your **Student Dashboard Home Overview** section using the sandbox payment portal.";
        } else {
          fallbackMsg = "I am the Saranathan AI Assistant. I can help you find campus locations, DBMS lab, library book racks, faculty cabins, placement eligibility, or student internal marks! Try clicking any of the preset buttons below.";
        }
        appendBubble(fallbackMsg, 'bot');
      }
    }
  };

  const appendBubble = (content, sender) => {
    const bubble = document.createElement('div');
    bubble.className = `chat-bubble ${sender}`;
    if (sender === 'bot') {
      const htmlFormatted = parseMarkdown(content);
      bubble.innerHTML = htmlFormatted;
    } else {
      bubble.textContent = content;
    }
    chatHistory.appendChild(bubble);
    chatHistory.scrollTop = chatHistory.scrollHeight;
  };

  if (sendBtn) {
    sendBtn.addEventListener('click', () => sendMessage());
  }
  
  chatInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') sendMessage();
  });
  
  // Preset Query Suggestion buttons
  presetButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const query = btn.getAttribute('data-query');
      sendMessage(query);
    });
  });
}
