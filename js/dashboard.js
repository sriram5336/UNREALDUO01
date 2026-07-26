// Student, Staff, and Admin dashboard rendering, sidebar navigations, and database APIs interaction
// Supports client-side LocalStorage DB fallback if server API connection fails

import { supabase } from './supabaseClient.js';

// Helper for XSS prevention
function escapeHTML(str) {
  if (str === null || str === undefined) return '';
  if (typeof str !== 'string') return String(str);
  return str.replace(/[&<>'"]/g, 
    tag => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', "'": '&#39;', '"': '&quot;' }[tag] || tag)
  );
}

// Wrapper for fetch API with JWT authentication header
async function fetchWithAuth(url, options = {}) {
  const token = sessionStorage.getItem('portalToken');
  if (token) {
    if (!options.headers) {
      options.headers = {};
    }
    options.headers['Authorization'] = `Bearer ${token}`;
  }
  return fetch(url, options);
}

document.addEventListener('DOMContentLoaded', () => {
  const user = checkUserSession();
  if (!user) return;
  
  initDashboardSidebar();
  
  if (window.location.pathname.includes('student-dashboard.html')) {
    loadStudentDashboard(user);
  } else if (window.location.pathname.includes('staff-dashboard.html')) {
    loadStaffDashboard(user);
  } else if (window.location.pathname.includes('admin-dashboard.html')) {
    loadAdminDashboard();
  }
});

// Verify session
function checkUserSession() {
  const userJson = sessionStorage.getItem('portalUser');
  if (!userJson) {
    window.location.href = 'login.html';
    return null;
  }
  const user = JSON.parse(userJson);
  
  const nameElems = document.querySelectorAll('.user-session-name');
  nameElems.forEach(el => el.textContent = user.name);
  
  const roleTags = document.querySelectorAll('.user-session-role');
  roleTags.forEach(el => el.textContent = user.role);

  const rollOrEmail = document.querySelectorAll('.user-session-detail');
  rollOrEmail.forEach(el => {
    el.textContent = user.role === 'student' ? user.roll : user.email;
  });

  return user;
}

// Sidebar Navigation Tab toggles
function initDashboardSidebar() {
  const links = document.querySelectorAll('.sidebar-link');
  const panels = document.querySelectorAll('.dashboard-tab-panel');
  
  links.forEach(link => {
    if (link.classList.contains('logout-btn')) {
      link.addEventListener('click', () => {
        sessionStorage.clear();
        window.location.href = 'login.html';
      });
      return;
    }
    
    link.addEventListener('click', () => {
      const targetPanelId = link.getAttribute('data-tab');
      if (!targetPanelId) return;
      
      links.forEach(l => l.classList.remove('active'));
      link.classList.add('active');
      
      panels.forEach(panel => {
        if (panel.id === targetPanelId) {
          panel.classList.add('active');
        } else {
          panel.classList.remove('active');
        }
      });
      
      const sidebar = document.querySelector('.dashboard-sidebar');
      const backdrop = document.querySelector('.sidebar-backdrop');
      if (sidebar) sidebar.classList.remove('active');
      if (backdrop) backdrop.classList.remove('active');
    });
  });
  
  const menuBtn = document.querySelector('.menu-btn');
  const sidebar = document.querySelector('.dashboard-sidebar');
  if (menuBtn && sidebar) {
    let backdrop = document.querySelector('.sidebar-backdrop');
    if (!backdrop) {
      backdrop = document.createElement('div');
      backdrop.className = 'sidebar-backdrop';
      document.body.appendChild(backdrop);
    }
    
    const toggleSidebar = () => {
      const active = sidebar.classList.toggle('active');
      if (active) {
        backdrop.classList.add('active');
      } else {
        backdrop.classList.remove('active');
      }
    };
    
    menuBtn.addEventListener('click', toggleSidebar);
    backdrop.addEventListener('click', () => {
      sidebar.classList.remove('active');
      backdrop.classList.remove('active');
    });
  }
}

// ----------------------------------------------------
// 1. STUDENT DASHBOARD
// ----------------------------------------------------

async function loadStudentDashboard(user, selectedBatch = null) {
  const batchQuery = selectedBatch ? `&batch=${selectedBatch}` : '';
  try {
    const response = await fetchWithAuth(`/api/student/dashboard?rollNumber=${user.roll}${batchQuery}`);
    const data = await response.json();
    
    if (response.ok && data.success) {
      renderStudentOverview(data);
      renderStudentAttendance(data.attendance);
      renderStudentMarks(data.marks);
      renderStudentHostel(data.hostel);
      renderStudentResources(data);
      initStudentFeePayment(data.student);
      initDashboardLibrarySearch(user.roll);
      initDashboardChatbot();
      return;
    }
  } catch (err) {
    console.warn('Student API call failed, falling back to local simulation database...');
    loadLocalStudentDashboard(user, selectedBatch);
  }
}

function loadLocalStudentDashboard(user, selectedBatch = null) {
  const students = JSON.parse(localStorage.getItem('mock_students') || '[]');
  const student = students.find(s => s.RollNumber.toUpperCase() === user.roll.toUpperCase());
  
  if (!student) {
    alert('Student profile not found in local database.');
    return;
  }
  
  const activeBatch = selectedBatch || student.BatchNumber;
  
  // Filter attendance and marks
  const allAtt = JSON.parse(localStorage.getItem('mock_attendance') || '[]');
  const attendance = allAtt.filter(a => a.StudentID === student.RollNumber);
  
  const allMarks = JSON.parse(localStorage.getItem('mock_marks') || '[]');
  const marks = allMarks.filter(m => m.StudentID === student.RollNumber);
  
  const allEvents = JSON.parse(localStorage.getItem('mock_events') || '[]');
  const events = allEvents.filter(e => e.BatchNumber === activeBatch || e.BatchNumber === 'all');
  
  // Dummy records for notes/syllabus/papers
  const notes = [
    { Title: 'CPU Scheduling Algorithms', Subject: 'Operating Systems', Unit: 1, PDFPath: '#' },
    { Title: 'Normalization & Schema Refinement', Subject: 'Database Management Systems', Unit: 3, PDFPath: '#' }
  ];
  const syllabus = [
    { Subject: 'Operating Systems Syllabus', Department: student.Department, PDFPath: '#' },
    { Subject: 'Database Management Systems Syllabus', Department: student.Department, PDFPath: '#' }
  ];
  const questionPapers = [
    { Subject: 'Operating Systems', Year: 2025, Regulation: 'R-2021', PDFPath: '#' }
  ];
  
  const data = {
    student,
    attendance,
    marks,
    hostel: { Room: 'Room 203', Block: 'Kaveri Boys Hostel', Warden: 'Mr. S. Pandian', MessFeeStatus: student.PendingFees > 0 ? 'Unpaid' : 'Paid' },
    events,
    notes,
    syllabus,
    questionPapers
  };
  
  renderStudentOverview(data);
  renderStudentAttendance(data.attendance);
  renderStudentMarks(data.marks);
  renderStudentHostel(data.hostel);
  renderStudentResources(data);
  initStudentFeePayment(data.student);
  initDashboardLibrarySearch(user.roll);
  initDashboardChatbot();
}

function renderStudentOverview(data) {
  const stud = data.student;
  document.getElementById('overview-name').textContent = stud.Name;
  document.getElementById('overview-roll').textContent = stud.RollNumber;
  document.getElementById('overview-dept').textContent = stud.Department;
  document.getElementById('overview-semester').textContent = `Semester ${stud.Semester}`;
  document.getElementById('overview-cgpa').textContent = stud.CGPA ? stud.CGPA.toFixed(2) : '0.00';
  document.getElementById('overview-batch').textContent = stud.BatchNumber;
  
  const warningBanner = document.getElementById('fee-warning-banner');
  const warningAmount = document.getElementById('warning-fee-amount');
  
  if (warningBanner && warningAmount) {
    if (stud.PendingFees > 0) {
      warningAmount.textContent = stud.PendingFees.toLocaleString('en-IN');
      warningBanner.style.display = 'flex';
    } else {
      warningBanner.style.display = 'none';
    }
  }
  
  const eventList = document.getElementById('dashboard-events-list');
  if (eventList) {
    if (data.events.length === 0) {
      eventList.innerHTML = '<p class="text-muted">No upcoming events listed for your batch.</p>';
    } else {
      eventList.innerHTML = data.events.map(ev => `
        <div class="glass-card metric-card" style="margin-bottom: 15px; padding: 20px;">
          <div class="metric-info">
            <h3 style="color: var(--color-primary); font-size: 15px; font-weight: 700;">${escapeHTML(ev.Title)}</h3>
            <p style="font-size: 13px; color: var(--text-secondary); font-weight: normal; margin-top: 4px;">
              ${escapeHTML(ev.Description)}
            </p>
            <div style="font-size: 12px; color: var(--text-muted); margin-top: 8px;">
              <i class="bx bx-map"></i> ${escapeHTML(ev.Venue)} &nbsp;|&nbsp; <i class="bx bx-calendar"></i> ${escapeHTML(ev.Date)} &nbsp;|&nbsp; <i class="bx bx-time"></i> ${escapeHTML(ev.Time)}
            </div>
          </div>
          <button class="form-submit-btn" style="padding: 6px 14px; font-size: 12px;" onclick="alert('Registered successfully!')">Register</button>
        </div>
      `).join('');
    }
  }
  
  const batchSelect = document.getElementById('dashboard-batch-filter');
  if (batchSelect && !batchSelect.dataset.listenerSet) {
    batchSelect.dataset.listenerSet = "true";
    batchSelect.value = stud.BatchNumber;
    batchSelect.addEventListener('change', () => {
      if (window.location.protocol === 'file:') {
        loadLocalStudentDashboard(stud, batchSelect.value);
      } else {
        loadStudentDashboard(stud, batchSelect.value);
      }
    });
  }
}

function renderStudentAttendance(attendance) {
  const container = document.getElementById('attendance-grid-container');
  if (!container) return;
  
  if (attendance.length === 0) {
    container.innerHTML = '<p class="text-muted">No attendance details found.</p>';
    return;
  }
  
  container.innerHTML = attendance.map(att => {
    const percentage = att.Percentage;
    const strokeDash = 2 * Math.PI * 40;
    const offset = strokeDash - (percentage / 100) * strokeDash;
    const color = percentage >= 75 ? 'var(--color-secondary)' : 'var(--color-danger)';
    
    return `
      <div class="glass-card attendance-card">
        <div class="progress-ring-container">
          <svg width="100" height="100">
            <circle cx="50" cy="50" r="40" stroke="var(--border-glass)" stroke-width="8" fill="transparent"></circle>
            <circle class="progress-ring-circle" cx="50" cy="50" r="40" stroke="${color}" stroke-width="8" fill="transparent" 
              stroke-dasharray="${strokeDash}" stroke-dashoffset="${offset}"></circle>
          </svg>
          <span class="progress-text">${percentage}%</span>
        </div>
        <h4 style="font-size: 13px; font-weight: 600; color: var(--text-primary);">${escapeHTML(att.Subject)}</h4>
      </div>
    `;
  }).join('');
}

function renderStudentMarks(marks) {
  const tbody = document.getElementById('marks-table-body');
  if (!tbody) return;
  
  if (marks.length === 0) {
    tbody.innerHTML = '<tr><td colspan="4" class="text-muted" style="text-align:center;">No grading data found.</td></tr>';
    return;
  }
  
  tbody.innerHTML = marks.map(mk => `
    <tr>
      <td><strong>${escapeHTML(mk.Subject)}</strong></td>
      <td>${mk.Internal} / 50</td>
      <td><span style="font-weight:700; color: var(--color-primary);">${escapeHTML(mk.SemesterGrade)}</span></td>
      <td>${mk.Internal >= 25 ? '<span style="color:var(--color-secondary);">Pass</span>' : '<span style="color:var(--color-danger);">Low Attendance/Internal</span>'}</td>
    </tr>
  `).join('');
}

function renderStudentHostel(hostel) {
  const detailsBox = document.getElementById('hostel-details-box');
  if (!detailsBox) return;
  
  detailsBox.innerHTML = `
    <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
      <div>
        <p class="text-muted" style="font-size:12px;">Allocated Room</p>
        <h4 style="font-family:var(--font-title); font-size:18px; margin-top:4px;">${escapeHTML(hostel.Room)}</h4>
      </div>
      <div>
        <p class="text-muted" style="font-size:12px;">Hostel Block</p>
        <h4 style="font-family:var(--font-title); font-size:18px; margin-top:4px;">${escapeHTML(hostel.Block)}</h4>
      </div>
      <div>
        <p class="text-muted" style="font-size:12px;">Residential Warden</p>
        <h4 style="font-family:var(--font-title); font-size:18px; margin-top:4px;">${escapeHTML(hostel.Warden)}</h4>
      </div>
      <div>
        <p class="text-muted" style="font-size:12px;">Mess Bill Payment</p>
        <span class="profile-role-tag" style="background: ${hostel.MessFeeStatus === 'Paid' ? 'rgba(16,185,129,0.2)' : 'rgba(239,68,68,0.2)'}; color: ${hostel.MessFeeStatus === 'Paid' ? 'var(--color-secondary)' : 'var(--color-danger)'};">
          ${escapeHTML(hostel.MessFeeStatus)}
        </span>
      </div>
    </div>
  `;
}

function renderStudentResources(data) {
  const notesContainer = document.getElementById('dashboard-notes-list');
  if (notesContainer) {
    notesContainer.innerHTML = data.notes.map(n => `
      <div class="glass-card" style="padding: 15px 20px; display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
        <div>
          <h5 style="font-weight:600; color:var(--text-primary); font-size:14px;">${escapeHTML(n.Title)}</h5>
          <span style="font-size:11px; color:var(--text-muted);">${escapeHTML(n.Subject)} | Unit ${n.Unit}</span>
        </div>
        <a href="${n.PDFPath}" class="form-submit-btn" style="padding: 5px 12px; font-size:11px; text-decoration:none;" onclick="alert('Downloading simulated document...')">Download PDF</a>
      </div>
    `).join('');
  }

  const syllabusContainer = document.getElementById('dashboard-syllabus-list');
  if (syllabusContainer) {
    syllabusContainer.innerHTML = data.syllabus.map(s => `
      <div class="glass-card" style="padding: 15px 20px; display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
        <div>
          <h5 style="font-weight:600; color:var(--text-primary); font-size:14px;">${escapeHTML(s.Subject)}</h5>
          <span style="font-size:11px; color:var(--text-muted);">Department: ${escapeHTML(s.Department)}</span>
        </div>
        <a href="${s.PDFPath}" class="form-submit-btn" style="padding: 5px 12px; font-size:11px; text-decoration:none;" onclick="alert('Downloading simulated document...')">Download Syllabus</a>
      </div>
    `).join('');
  }

  const papersContainer = document.getElementById('dashboard-papers-list');
  if (papersContainer) {
    papersContainer.innerHTML = data.questionPapers.map(qp => `
      <div class="glass-card" style="padding: 15px 20px; display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
        <div>
          <h5 style="font-weight:600; color:var(--text-primary); font-size:14px;">${escapeHTML(qp.Subject)} (PYQ)</h5>
          <span style="font-size:11px; color:var(--text-muted);">Year: ${qp.Year} | Regulation: ${escapeHTML(qp.Regulation)}</span>
        </div>
        <a href="${qp.PDFPath}" class="form-submit-btn" style="padding: 5px 12px; font-size:11px; text-decoration:none;" onclick="alert('Downloading simulated document...')">Download Paper</a>
      </div>
    `).join('');
  }
}

function initStudentFeePayment(student) {
  const payBtn = document.getElementById('pay-warning-btn');
  const formPayBtn = document.getElementById('submit-fee-btn');
  const detailsAmount = document.getElementById('fee-total-dues');
  
  if (detailsAmount) {
    detailsAmount.textContent = student.PendingFees;
  }
  
  const triggerAction = async (amountToPay) => {
    if (amountToPay <= 0) return;
    try {
      const response = await fetchWithAuth('/api/student/pay-fees', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ rollNumber: student.RollNumber, amount: amountToPay })
      });
      const data = await response.json();
      if (response.ok && data.success) {
        alert(data.message);
        window.location.reload();
        return;
      }
    } catch (err) {
      // Local fallback
      const students = JSON.parse(localStorage.getItem('mock_students') || '[]');
      const match = students.find(s => s.RollNumber.toUpperCase() === student.RollNumber.toUpperCase());
      if (match) {
        match.PendingFees = Math.max(0, match.PendingFees - amountToPay);
        localStorage.setItem('mock_students', JSON.stringify(students));
        
        // Update session user fees as well
        const sessionUser = JSON.parse(sessionStorage.getItem('portalUser'));
        sessionUser.pendingFees = match.PendingFees;
        sessionStorage.setItem('portalUser', JSON.stringify(sessionUser));
        
        alert(`Payment of ₹${amountToPay} successful in offline sandbox. Remaining: ₹${match.PendingFees}`);
        window.location.reload();
      }
    }
  };

  if (payBtn) {
    payBtn.addEventListener('click', () => {
      const val = prompt(`Pending Dues: ₹${student.PendingFees.toLocaleString('en-IN')}\nEnter amount to pay:`, student.PendingFees);
      if (val) {
        const amt = parseFloat(val);
        if (!isNaN(amt)) triggerAction(amt);
      }
    });
  }

  if (formPayBtn) {
    formPayBtn.addEventListener('click', (e) => {
      e.preventDefault();
      const valInput = document.getElementById('fee-pay-amount');
      if (valInput) {
        const amt = parseFloat(valInput.value);
        if (!isNaN(amt)) triggerAction(amt);
      }
    });
  }
}

function initDashboardLibrarySearch(studentRoll) {
  const searchInput = document.getElementById('lib-search-input');
  const searchBtn = document.getElementById('lib-search-btn');
  const resultsBox = document.getElementById('lib-search-results');
  
  if (!searchInput || !resultsBox) return;
  
  const performSearch = async () => {
    const q = searchInput.value.trim();
    try {
      const res = await fetchWithAuth(`/api/library/search?q=${q}`);
      const data = await res.json();
      if (res.ok && data.success) {
        renderBooks(data.books);
        return;
      }
    } catch (err) {
      // Local search fallback
      const books = JSON.parse(localStorage.getItem('mock_books') || '[]');
      const filtered = books.filter(b => b.Title.toLowerCase().includes(q.toLowerCase()) || b.Author.toLowerCase().includes(q.toLowerCase()));
      renderBooks(filtered);
    }
  };

  const renderBooks = (booksList) => {
    if (booksList.length === 0) {
      resultsBox.innerHTML = '<p class="text-muted" style="grid-column: 1/-1; text-align:center; padding:20px;">No books found matching this query.</p>';
      return;
    }
    
    resultsBox.innerHTML = booksList.map(bk => `
      <div class="glass-card" style="padding: 20px; display:flex; flex-direction:column; gap:12px; justify-content:space-between;">
        <div style="width:100%; height:160px; background:linear-gradient(135deg, #1d4ed8, #6d28d9); border-radius:8px; display:flex; flex-direction:column; justify-content:center; align-items:center; padding:15px; text-align:center; box-shadow: 0 4px 10px rgba(0,0,0,0.25);">
          <i class="bx bx-book" style="font-size:32px; color:white; margin-bottom:8px;"></i>
          <h5 style="color:white; font-size:12px; font-weight:700; font-family:var(--font-title); overflow:hidden; display:-webkit-box; -webkit-line-clamp:3; -webkit-box-orient:vertical;">${escapeHTML(bk.Title)}</h5>
        </div>
        <div>
          <h4 style="font-size:14px; font-weight:700; color:var(--text-primary); margin-top:5px;">${escapeHTML(bk.Title)}</h4>
          <p style="font-size:12px; color:var(--text-secondary); margin-top:2px;">by ${escapeHTML(bk.Author)}</p>
          <div style="font-size:11px; color:var(--text-muted); margin-top:8px; display:grid; grid-template-columns:1fr 1fr; gap:6px;">
            <span>Floor: ${escapeHTML(bk.Floor)}</span>
            <span>Rack: ${escapeHTML(bk.Rack)}</span>
            <span>Shelf: ${escapeHTML(bk.Shelf)}</span>
            <span>Available: <strong style="color:var(--color-secondary);">${bk.AvailableCopies} / ${bk.Copies}</strong></span>
          </div>
        </div>
        <button class="form-submit-btn" style="width:100%; padding:8px; font-size:12px; margin-top:10px;" onclick="reserveBook('${studentRoll}', ${bk.BookID})">Reserve Book</button>
      </div>
    `).join('');
  };

  searchBtn.addEventListener('click', performSearch);
  searchInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') performSearch();
  });
  
  performSearch();
}

window.reserveBook = async (roll, bookId) => {
  try {
    const res = await fetchWithAuth('/api/library/reserve', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ studentRoll: roll, bookId })
    });
    const data = await res.json();
    alert(data.message);
    if (res.ok && data.success) {
      window.location.reload();
      return;
    }
  } catch (err) {
    // Local reservation fallback
    const books = JSON.parse(localStorage.getItem('mock_books') || '[]');
    const book = books.find(b => b.BookID === bookId);
    if (book) {
      if (book.AvailableCopies > 0) {
        book.AvailableCopies--;
        localStorage.setItem('mock_books', JSON.stringify(books));
        alert(`Book reserved successfully in local database! Rack: ${book.Rack}, Shelf: ${book.Shelf}, Floor: ${book.Floor}. Pick it up at the library counter.`);
        window.location.reload();
      } else {
        alert('No copies available.');
      }
    }
  }
};

// ----------------------------------------------------
// 2. STAFF DASHBOARD
// ----------------------------------------------------
async function loadStaffDashboard(user) {
  loadApprovalQueue();
  loadStaffInfo();
  initMarksUpload();
}

async function loadApprovalQueue() {
  const tbody = document.getElementById('approval-queue-body');
  if (!tbody) return;
  
  try {
    const res = await fetchWithAuth('/api/staff/registrations');
    const data = await res.json();
    if (res.ok && data.success) {
      renderApprovals(data.students);
      return;
    }
  } catch (err) {
    // Local fallback
    const students = JSON.parse(localStorage.getItem('mock_students') || '[]');
    const pendings = students.filter(s => s.Status === 'Pending');
    renderApprovals(pendings);
  }

  function renderApprovals(list) {
    if (list.length === 0) {
      tbody.innerHTML = '<tr><td colspan="6" class="text-muted" style="text-align:center; padding: 20px;">No pending student registrations in the queue.</td></tr>';
      return;
    }
    
    tbody.innerHTML = list.map(s => `
      <tr>
        <td><strong>${escapeHTML(s.RollNumber)}</strong></td>
        <td>${escapeHTML(s.Name)}</td>
        <td>${escapeHTML(s.Department)}</td>
        <td>Semester ${s.Semester}</td>
        <td>${escapeHTML(s.Email)}</td>
        <td>
          <div style="display:flex; gap:8px;">
            <button class="form-submit-btn" style="background:var(--color-secondary); padding: 5px 12px; font-size:11px;" onclick="approveStudent(${s.StudentID || 0}, '${s.RollNumber}')">Approve</button>
            <button class="form-submit-btn" style="background:var(--color-danger); padding: 5px 12px; font-size:11px; box-shadow:none;" onclick="rejectStudent(${s.StudentID || 0}, '${s.RollNumber}')">Reject</button>
          </div>
        </td>
      </tr>
    `).join('');
  }
}

window.approveStudent = async (studentId, roll) => {
  try {
    const res = await fetchWithAuth('/api/staff/approve-student', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ studentId })
    });
    const data = await res.json();
    alert(data.message);
    loadApprovalQueue();
  } catch (err) {
    // Local approval fallback
    const students = JSON.parse(localStorage.getItem('mock_students') || '[]');
    const match = students.find(s => s.RollNumber.toUpperCase() === roll.toUpperCase());
    if (match) {
      match.Status = 'Approved';
      localStorage.setItem('mock_students', JSON.stringify(students));
      alert('Student registration approved in local database queue!');
      loadApprovalQueue();
    }
  }
};

window.rejectStudent = async (studentId, roll) => {
  if (!confirm('Are you sure you want to REJECT and DELETE this student registration?')) return;
  try {
    const res = await fetchWithAuth('/api/staff/reject-student', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ studentId })
    });
    const data = await res.json();
    alert(data.message);
    loadApprovalQueue();
  } catch (err) {
    // Local rejection fallback
    let students = JSON.parse(localStorage.getItem('mock_students') || '[]');
    students = students.filter(s => s.RollNumber.toUpperCase() !== roll.toUpperCase());
    localStorage.setItem('mock_students', JSON.stringify(students));
    alert('Student registration rejected & deleted from local queue.');
    loadApprovalQueue();
  }
};

async function loadStaffInfo() {
  const staffList = document.getElementById('staff-directory-list');
  if (!staffList) return;
  
  try {
    const res = await fetchWithAuth('/api/staff/info');
    const data = await res.json();
    if (res.ok && data.success) {
      renderStaff(data.staff);
      return;
    }
  } catch (err) {
    const staff = JSON.parse(localStorage.getItem('mock_staff') || '[]');
    renderStaff(staff);
  }

  function renderStaff(list) {
    staffList.innerHTML = list.map(st => `
      <div class="glass-card" style="padding: 20px; display:flex; flex-direction:column; gap:8px;">
        <h4 style="font-family:var(--font-title); font-size:16px; font-weight:700;">${escapeHTML(st.Name)}</h4>
        <span class="profile-role-tag" style="align-self:flex-start; margin-top:2px;">${escapeHTML(st.CabinNumber || 'Cabin')}</span>
        <p style="font-size:12px; color:var(--text-secondary); margin-top:5px;">Department: ${escapeHTML(st.Department)}</p>
        <p style="font-size:11px; color:var(--text-muted);"><i class="bx bx-envelope"></i> ${escapeHTML(st.Email)}</p>
      </div>
    `).join('');
  }
}

function initMarksUpload() {
  const form = document.getElementById('upload-marks-form');
  if (!form) return;
  
  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const rollNumber = document.getElementById('marks-student-roll').value.trim();
    const subject = document.getElementById('marks-subject').value.trim();
    const internal = document.getElementById('marks-internal').value;
    const grade = document.getElementById('marks-grade').value;
    
    try {
      const res = await fetchWithAuth('/api/staff/upload-marks', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ rollNumber, subject, internal, grade })
      });
      const data = await res.json();
      alert(data.message);
      if (res.ok && data.success) {
        form.reset();
      }
    } catch (err) {
      // Local fallback
      const marks = JSON.parse(localStorage.getItem('mock_marks') || '[]');
      marks.push({ StudentID: rollNumber.toUpperCase(), Subject: subject, Internal: parseFloat(internal), SemesterGrade: grade });
      localStorage.setItem('mock_marks', JSON.stringify(marks));
      alert('Marks uploaded successfully into local database!');
      form.reset();
    }
  });
}

// ----------------------------------------------------
// 3. ADMIN DASHBOARD
// ----------------------------------------------------
async function loadAdminDashboard() {
  const studentsTable = document.getElementById('admin-students-tbody');
  const staffTable = document.getElementById('admin-staff-tbody');
  
  try {
    const resMetrics = await fetchWithAuth('/api/admin/dashboard');
    const dataMetrics = await resMetrics.json();
    if (resMetrics.ok && dataMetrics.success) {
      const m = dataMetrics.metrics;
      document.getElementById('admin-metric-students').textContent = m.students;
      document.getElementById('admin-metric-staff').textContent = m.staff;
      document.getElementById('admin-metric-books').textContent = m.books;
      document.getElementById('admin-metric-notices').textContent = m.notices;
      initAdminChart(m);
    }
  } catch (err) {
    // Local fallback
    const stCount = JSON.parse(localStorage.getItem('mock_students') || '[]').length;
    const stfCount = JSON.parse(localStorage.getItem('mock_staff') || '[]').length;
    const bkCount = JSON.parse(localStorage.getItem('mock_books') || '[]').length;
    const ntCount = JSON.parse(localStorage.getItem('mock_notices') || '[]').length;
    
    document.getElementById('admin-metric-students').textContent = stCount;
    document.getElementById('admin-metric-staff').textContent = stfCount;
    document.getElementById('admin-metric-books').textContent = bkCount;
    document.getElementById('admin-metric-notices').textContent = ntCount;
    
    initAdminChart({ students: stCount, staff: stfCount, books: bkCount, notices: ntCount, pendingApprovals: 1 });
  }

  try {
    const resUsers = await fetchWithAuth('/api/admin/users');
    const dataUsers = await resUsers.json();
    if (resUsers.ok && dataUsers.success) {
      renderGrids(dataUsers.students, dataUsers.staff);
      return;
    }
  } catch (err) {
    const students = JSON.parse(localStorage.getItem('mock_students') || '[]');
    const staff = JSON.parse(localStorage.getItem('mock_staff') || '[]');
    renderGrids(students, staff);
  }

  function renderGrids(studentsList, staffList) {
    if (studentsTable) {
      studentsTable.innerHTML = studentsList.map(s => `
        <tr>
          <td><strong>${escapeHTML(s.RollNumber)}</strong></td>
          <td>${escapeHTML(s.Name)}</td>
          <td>${escapeHTML(s.Department)}</td>
          <td>${escapeHTML(s.BatchNumber)}</td>
          <td>${escapeHTML(s.Email)}</td>
          <td><span class="profile-role-tag" style="background:${s.Status === 'Approved' ? 'rgba(16,185,129,0.15)' : 'rgba(239,68,68,0.15)'}; color:${s.Status === 'Approved' ? 'var(--color-secondary)' : 'var(--color-danger)'};">${escapeHTML(s.Status)}</span></td>
        </tr>
      `).join('');
    }
    
    if (staffTable) {
      staffTable.innerHTML = staffList.map(t => `
        <tr>
          <td><strong>${escapeHTML(t.Name)}</strong></td>
          <td>${escapeHTML(t.Department)}</td>
          <td>${escapeHTML(t.CabinNumber || 'Cabin')}</td>
          <td>${escapeHTML(t.Email)}</td>
        </tr>
      `).join('');
    }
  }
}

function initAdminChart(metrics) {
  const ctx = document.getElementById('admin-analytics-chart');
  if (!ctx) return;
  
  if (typeof Chart === 'undefined') {
    setTimeout(() => initAdminChart(metrics), 500);
    return;
  }
  
  new Chart(ctx.getContext('2d'), {
    type: 'bar',
    data: {
      labels: ['Students Count', 'Staff Count', 'Library Books', 'System Bulletins', 'Pending Registrations'],
      datasets: [{
        label: 'Saranathan Campus Data Metrics',
        data: [metrics.students, metrics.staff, metrics.books, metrics.notices, metrics.pendingApprovals],
        backgroundColor: [
          'rgba(59, 130, 246, 0.45)',
          'rgba(139, 92, 246, 0.45)',
          'rgba(16, 185, 129, 0.45)',
          'rgba(245, 158, 11, 0.45)',
          'rgba(239, 68, 68, 0.45)'
        ],
        borderColor: [
          '#3b82f6',
          '#8b5cf6',
          '#10b981',
          '#f59e0b',
          '#ef4444'
        ],
        borderWidth: 1.5,
        borderRadius: 6
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        y: {
          beginAtZero: true,
          grid: { color: 'rgba(255,255,255,0.06)' },
          ticks: { color: 'var(--text-secondary)' }
        },
        x: {
          grid: { display: false },
          ticks: { color: 'var(--text-secondary)' }
        }
      },
      plugins: {
        legend: { display: false }
      }
    }
  });
}

// ----------------------------------------------------
// 4. CHATBOT INTERFACE WITHIN DASHBOARDS
// ----------------------------------------------------
function initDashboardChatbot() {
  const chatInput = document.getElementById('dash-chat-input');
  const sendBtn = document.getElementById('dash-chat-send');
  const history = document.getElementById('dash-chat-history');
  
  if (!chatInput || !history) return;

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

  // Markdown-to-HTML parser to render bold text, lists, and tables inside chat bubbles
  function parseMarkdown(text) {
    if (!text) return '';
    
    const lines = text.split(/\r?\n/);
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
  
  const GEMINI_API_KEY = 'AQ.Ab8RN6JBUtxqcZvs06x9A1OonFmiCw7BRCmCsGVBs5i6h79R_w';

  async function queryGeminiClientSide(text) {
    const credentials = extractCredentials(text);
    let systemInstruction = 'You are Saranathan College AI assistant. Answer concisely and help the student locate relevant campus resources (library, DBMS lab, OS books, cabins, timings, placements eligibility, fee/payment guidance) without inventing facts. If unsure, suggest checking the relevant portal section.';

    if (credentials) {
      console.log("Client-side Chatbot: Verifying student login...");
      const { data: userData, error: loginErr } = await supabase.rpc('verify_student_login', {
        p_username: credentials.username,
        p_password: credentials.password
      });
      
      const user = userData && userData[0];
      if (loginErr || !user || !user.success) {
        throw new Error('⚠️ **Authentication Failed.** I was unable to verify your student login credentials. Please check your username and password.');
      }

      // Fetch marks
      const { data: marksData, error: marksErr } = await supabase
        .from('internal_marks')
        .select('*')
        .eq('student_id', user.student_id);

      if (marksErr) {
        throw new Error('⚠️ Failed to fetch student marks from the database.');
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
      'gemini-3.1-flash-lite',
      'gemini-flash-lite-latest',
      'gemini-2.5-flash',
      'gemini-2.0-flash',
      'gemini-1.5-flash',
      'gemini-pro'
    ];

    let lastError = null;
    for (const model of modelsToTry) {
      try {
        console.log(`Chatbot: Trying model ${model}...`);
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
            return responseText;
          }
        } else {
          const errorData = await response.json().catch(() => ({}));
          lastError = new Error(errorData?.error?.message || `API error (${model}): ${response.status}`);
        }
      } catch (err) {
        lastError = err;
      }
    }
    throw lastError || new Error("Failed to connect to any Gemini model");
  }
  
  const sendMessage = async () => {
    const text = chatInput.value.trim();
    if (!text) return;
    
    appendBubble(text, 'user');
    chatInput.value = '';
    
    const typing = document.createElement('div');
    typing.className = 'chat-bubble bot typing-indicator';
    typing.innerHTML = '<span style="display:inline-block; animation:bounce 1.4s infinite; font-size:16px;">...</span>';
    history.appendChild(typing);
    history.scrollTop = history.scrollHeight;
    
    try {
      const responseText = await queryGeminiClientSide(text);
      typing.remove();
      if (responseText) {
        appendBubble(responseText, 'bot');
        return;
      }
      throw new Error('Gemini returned empty response');
    } catch (err) {
      // Local fallback search chatbot KB
      typing.remove();
      console.error("Chatbot error details:", err);

      // If it is a clean authentication error thrown by Supabase, show it directly
      if (err.message && err.message.includes('Authentication Failed')) {
        appendBubble(err.message, 'bot');
        return;
      }

      // Check if credentials are in the message for offline marks retrieval
      const credentials = extractCredentials(text);
      if (credentials) {
        const studentData = getLocalStudentMarks(credentials.username, credentials.password);
        if (studentData) {
          let tableText = `📊 **Offline Database Results for ${studentData.name} (${studentData.roll})**<br><br>`;
          if (studentData.marks.length === 0) {
            tableText += "No marks records found for this student in the local database.";
          } else {
            tableText += "| Subject | Internal Score | Grade |<br>|---|---|---|<br>";
            studentData.marks.forEach(m => {
              tableText += `| ${m.Subject} | ${m.Internal} | ${m.SemesterGrade || '—'} |<br>`;
            });
            tableText += "<br>*Note: Displayed from offline database sandbox simulation.*";
          }
          appendBubble(tableText, 'bot');
          return;
        } else {
          appendBubble(`⚠️ **Database Connection Error.**<br>Details: ${err.message || err}`, 'bot');
          return;
        }
      }

      const kb = JSON.parse(localStorage.getItem('mock_chatbotKB') || '[]');
      let matchedAns = null;
      
      for (const entry of kb) {
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
        // Fallback simulation text
        let fallbackMsg = "I am the Saranathan AI Offline Assistant. ";
        const q = text.toLowerCase();
        if (q.includes('hi') || q.includes('hello')) {
          fallbackMsg = "Hello student! How can I assist you with catalog racks, syllabus downloads, or exam timetables today?";
        } else if (q.includes('fees') || q.includes('pending')) {
          fallbackMsg = "You can verify your pending tuition/mess fees on your Student Dashboard Home Overview page where you can also make sandbox card payments.";
        } else if (q.includes('library') || q.includes('book')) {
          fallbackMsg = "The Central Library is open from 8:00 AM to 8:00 PM. Shelf coordinates: Operating System and DBMS concepts books are on the 2nd Floor, Rack R-12.";
        } else if (q.includes('bus') || q.includes('timings')) {
          fallbackMsg = "Saranathan College runs routes 08, 15, 22 busses daily starting at 07:15 - 07:30 AM. Review driver contacts in the Hostel & Transport tab.";
        } else if (q.includes('mark')) {
          fallbackMsg = "To check your marks, please query using your username and password, e.g.: 'What is my mark with username <your_name> and password <your_pass>'";
        } else {
          fallbackMsg += "Please query about OS books, DBMS lab, or placements criteria details.";
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
    history.appendChild(bubble);
    history.scrollTop = history.scrollHeight;
  };

  sendBtn.addEventListener('click', sendMessage);
  chatInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') sendMessage();
  });
  
  const chatbotTabs = document.querySelectorAll('.chatbot-tab');
  chatbotTabs.forEach(tab => {
    tab.addEventListener('click', () => {
      chatbotTabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      const helper = tab.getAttribute('data-helper');
      triggerAIHelper(helper);
    });
  });
}

function triggerAIHelper(helperType) {
  const chatInput = document.getElementById('dash-chat-input');
  if (!chatInput) return;
  
  let promptText = "";
  if (helperType === 'study') {
    promptText = "Create a study plan for my Operating System and DBMS courses.";
  } else if (helperType === 'career') {
    promptText = "Placement preparation steps for Zoho and TCS campus recruitments.";
  } else if (helperType === 'faq') {
    promptText = "What are the hostel rules, curfew timings, and mess timings?";
  } else if (helperType === 'summary') {
    promptText = "Summarize the key CPU Scheduling Algorithms covered in Unit 1.";
  }
  
  chatInput.value = promptText;
  chatInput.focus();
}
