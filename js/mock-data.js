// js/mock-data.js
// Seeds all localStorage keys used by dashboard.js offline fallback
// Run once by calling seedMockData() — idempotent (checks before seeding)

function seedMockData() {

  // ─────────────────────────────────────────────────────────
  //  STUDENTS
  // ─────────────────────────────────────────────────────────
  if (!localStorage.getItem('mock_students')) {
    const students = [
      {
        StudentID: 1, RollNumber: 'student1', username: 'student1', password: 'student123',
        Name: 'Arun Kumar S', Department: 'Computer Science and Engineering',
        Semester: 5, BatchNumber: '2024-2028', Email: 'arun.kumar@saranathan.ac.in',
        Mobile: '+91 98765 43210', PendingFees: 12500, CGPA: 8.75, Status: 'Approved'
      },
      {
        StudentID: 2, RollNumber: 'student2', username: 'student2', password: 'student123',
        Name: 'Priya Devi R', Department: 'Electronics and Communication Engineering',
        Semester: 3, BatchNumber: '2024-2028', Email: 'priya.devi@saranathan.ac.in',
        Mobile: '+91 98765 43211', PendingFees: 0, CGPA: 9.12, Status: 'Approved'
      },
      {
        StudentID: 3, RollNumber: 'student3', username: 'student3', password: 'student123',
        Name: 'Karthik Rajan M', Department: 'Mechanical Engineering',
        Semester: 7, BatchNumber: '2022-2026', Email: 'karthik.rajan@saranathan.ac.in',
        Mobile: '+91 98765 43212', PendingFees: 8000, CGPA: 7.89, Status: 'Approved'
      },
      {
        StudentID: 4, RollNumber: 'student4', username: 'student4', password: 'student123',
        Name: 'Meena Kumari T', Department: 'Information Technology',
        Semester: 5, BatchNumber: '2024-2028', Email: 'meena.kumari@saranathan.ac.in',
        Mobile: '+91 98765 43213', PendingFees: 0, CGPA: 8.34, Status: 'Approved'
      },
      {
        StudentID: 5, RollNumber: 'student5', username: 'student5', password: 'student123',
        Name: 'Vijay Shankar P', Department: 'Electrical and Electronics Engineering',
        Semester: 1, BatchNumber: '2026-2030', Email: 'vijay.shankar@saranathan.ac.in',
        Mobile: '+91 98765 43214', PendingFees: 25000, CGPA: 0, Status: 'Approved'
      },
      {
        StudentID: 6, RollNumber: 'student6', username: 'student6', password: 'student123',
        Name: 'Anitha Lakshmi B', Department: 'Civil Engineering',
        Semester: 5, BatchNumber: '2024-2028', Email: 'anitha.lakshmi@saranathan.ac.in',
        Mobile: '+91 98765 43215', PendingFees: 5000, CGPA: 8.55, Status: 'Approved'
      },
      {
        StudentID: 7, RollNumber: 'newstudent', username: 'newstudent', password: 'new123',
        Name: 'Deepak Nathan V', Department: 'Computer Science and Engineering',
        Semester: 1, BatchNumber: '2026-2030', Email: 'deepak.nathan@saranathan.ac.in',
        Mobile: '+91 98765 43216', PendingFees: 25000, CGPA: 0, Status: 'Pending'
      },
      {
        StudentID: 8, RollNumber: 'student8', username: 'student8', password: 'student123',
        Name: 'Roshini Pradeep K', Department: 'Bio-Technology',
        Semester: 3, BatchNumber: '2024-2028', Email: 'roshini.pradeep@saranathan.ac.in',
        Mobile: '+91 98765 43217', PendingFees: 0, CGPA: 9.05, Status: 'Approved'
      }
    ];
    localStorage.setItem('mock_students', JSON.stringify(students));
  }

  // ─────────────────────────────────────────────────────────
  //  STAFF
  // ─────────────────────────────────────────────────────────
  if (!localStorage.getItem('mock_staff')) {
    const staff = [
      {
        StaffID: 1, username: 'staff1', password: 'staff123',
        Name: 'Dr. S. Ramachandran', Department: 'Computer Science and Engineering',
        Designation: 'Professor & HoD', CabinNumber: 'Cabin A-301',
        Email: 'ramachandran@saranathan.ac.in', Mobile: '+91 94432 11001',
        Subjects: ['Operating Systems', 'Advanced Algorithms'], Experience: '18 years'
      },
      {
        StaffID: 2, username: 'staff2', password: 'staff123',
        Name: 'Mrs. K. Priya Dharshini', Department: 'Computer Science and Engineering',
        Designation: 'Assistant Professor', CabinNumber: 'Cabin A-305',
        Email: 'priya.dharshini@saranathan.ac.in', Mobile: '+91 94432 11002',
        Subjects: ['Database Management Systems', 'Data Structures'], Experience: '9 years'
      },
      {
        StaffID: 3, username: 'staff3', password: 'staff123',
        Name: 'Mr. V. Rajendran', Department: 'Electronics and Communication Engineering',
        Designation: 'Associate Professor', CabinNumber: 'Cabin B-204',
        Email: 'rajendran.v@saranathan.ac.in', Mobile: '+91 94432 11003',
        Subjects: ['Digital Signal Processing', 'Communication Systems'], Experience: '12 years'
      },
      {
        StaffID: 4, username: 'staff4', password: 'staff123',
        Name: 'Dr. A. Muthu Kumar', Department: 'Mechanical Engineering',
        Designation: 'Professor', CabinNumber: 'Cabin C-102',
        Email: 'muthu.kumar@saranathan.ac.in', Mobile: '+91 94432 11004',
        Subjects: ['Thermodynamics', 'Fluid Mechanics', 'Heat Transfer'], Experience: '20 years'
      },
      {
        StaffID: 5, username: 'staff5', password: 'staff123',
        Name: 'Ms. R. Bhavani', Department: 'Information Technology',
        Designation: 'Assistant Professor', CabinNumber: 'Cabin A-308',
        Email: 'bhavani.r@saranathan.ac.in', Mobile: '+91 94432 11005',
        Subjects: ['Software Engineering', 'Web Technologies'], Experience: '6 years'
      },
      {
        StaffID: 6, username: 'staff6', password: 'staff123',
        Name: 'Mr. P. Sivasubramanian', Department: 'Mathematics',
        Designation: 'Associate Professor', CabinNumber: 'Cabin D-101',
        Email: 'siva.sub@saranathan.ac.in', Mobile: '+91 94432 11006',
        Subjects: ['Calculus', 'Probability & Statistics', 'Discrete Maths'], Experience: '14 years'
      }
    ];
    localStorage.setItem('mock_staff', JSON.stringify(staff));
  }

  // ─────────────────────────────────────────────────────────
  //  ATTENDANCE
  // ─────────────────────────────────────────────────────────
  if (!localStorage.getItem('mock_attendance')) {
    const attendance = [
      // student1
      { StudentID: 'student1', Subject: 'Operating Systems',        Percentage: 82 },
      { StudentID: 'student1', Subject: 'Database Mgmt Systems',     Percentage: 78 },
      { StudentID: 'student1', Subject: 'Computer Networks',         Percentage: 88 },
      { StudentID: 'student1', Subject: 'Software Engineering',      Percentage: 74 },
      { StudentID: 'student1', Subject: 'Algorithm Design',          Percentage: 91 },
      { StudentID: 'student1', Subject: 'Professional Elective I',   Percentage: 80 },
      // student2
      { StudentID: 'student2', Subject: 'Signals & Systems',         Percentage: 95 },
      { StudentID: 'student2', Subject: 'Digital Communication',     Percentage: 89 },
      { StudentID: 'student2', Subject: 'Microprocessors',           Percentage: 91 },
      // student3
      { StudentID: 'student3', Subject: 'Thermodynamics',            Percentage: 76 },
      { StudentID: 'student3', Subject: 'Fluid Mechanics',           Percentage: 70 },
      { StudentID: 'student3', Subject: 'Machine Design',            Percentage: 83 },
      // student4
      { StudentID: 'student4', Subject: 'Operating Systems',         Percentage: 80 },
      { StudentID: 'student4', Subject: 'Web Technologies',          Percentage: 93 },
      { StudentID: 'student4', Subject: 'Data Warehousing',          Percentage: 87 },
    ];
    localStorage.setItem('mock_attendance', JSON.stringify(attendance));
  }

  // ─────────────────────────────────────────────────────────
  //  MARKS
  // ─────────────────────────────────────────────────────────
  if (!localStorage.getItem('mock_marks')) {
    const marks = [
      // student1
      { StudentID: 'student1', Subject: 'Operating Systems',       Internal: 43, SemesterGrade: 'A+' },
      { StudentID: 'student1', Subject: 'Database Mgmt Systems',   Internal: 41, SemesterGrade: 'A'  },
      { StudentID: 'student1', Subject: 'Computer Networks',       Internal: 46, SemesterGrade: 'A+' },
      { StudentID: 'student1', Subject: 'Software Engineering',    Internal: 38, SemesterGrade: 'B+' },
      { StudentID: 'student1', Subject: 'Algorithm Design',        Internal: 47, SemesterGrade: 'O'  },
      { StudentID: 'student1', Subject: 'Professional Elective I', Internal: 39, SemesterGrade: 'A'  },
      // student2
      { StudentID: 'student2', Subject: 'Signals & Systems',       Internal: 48, SemesterGrade: 'O'  },
      { StudentID: 'student2', Subject: 'Digital Communication',   Internal: 46, SemesterGrade: 'A+' },
      { StudentID: 'student2', Subject: 'Microprocessors',         Internal: 44, SemesterGrade: 'A+' },
      // student3
      { StudentID: 'student3', Subject: 'Thermodynamics',          Internal: 37, SemesterGrade: 'B+' },
      { StudentID: 'student3', Subject: 'Fluid Mechanics',         Internal: 34, SemesterGrade: 'B'  },
      { StudentID: 'student3', Subject: 'Machine Design',          Internal: 40, SemesterGrade: 'A'  },
      // student4
      { StudentID: 'student4', Subject: 'Operating Systems',       Internal: 41, SemesterGrade: 'A'  },
      { StudentID: 'student4', Subject: 'Web Technologies',        Internal: 49, SemesterGrade: 'O'  },
      { StudentID: 'student4', Subject: 'Data Warehousing',        Internal: 43, SemesterGrade: 'A+' },
    ];
    localStorage.setItem('mock_marks', JSON.stringify(marks));
  }

  // ─────────────────────────────────────────────────────────
  //  EVENTS
  // ─────────────────────────────────────────────────────────
  if (!localStorage.getItem('mock_events')) {
    const events = [
      {
        EventID: 1, Title: 'UNMAAD 2026 – National Tech Fest',
        Description: 'Saranathan\'s flagship 3-day national technical symposium. Compete in hackathons, paper presentations, robotics, and more. Cash prizes worth ₹5 Lakhs.',
        Venue: 'Main Auditorium & Sports Ground', Date: '2026-08-15', Time: '09:00 AM', BatchNumber: 'all', Category: 'Technical'
      },
      {
        EventID: 2, Title: 'TCS NQT 2026 Campus Drive',
        Description: 'TCS National Qualifier Test on-campus drive for final-year students. Eligibility: CGPA ≥ 6.0, No Active Backlogs. Register via the placement portal.',
        Venue: 'Exam Hall A & B', Date: '2026-08-05', Time: '09:30 AM', BatchNumber: '2022-2026', Category: 'Placement'
      },
      {
        EventID: 3, Title: 'CODEATHON 2026 – Competitive Programming',
        Description: '6-hour competitive programming challenge. Individual and team (3 members max) categories. Platform: HackerRank. Registration: Free for all Saranathan students.',
        Venue: 'CSE Computer Lab 2', Date: '2026-07-28', Time: '10:00 AM', BatchNumber: 'all', Category: 'Technical'
      },
      {
        EventID: 4, Title: 'Alumni Meet 2026 – Reconnect & Network',
        Description: 'Annual alumni meet where former graduates share career insights, startup experiences, and industry knowledge. Open to all students for networking.',
        Venue: 'Narayanan Auditorium', Date: '2026-09-10', Time: '11:00 AM', BatchNumber: 'all', Category: 'Cultural'
      },
      {
        EventID: 5, Title: 'Zoho On-Campus Recruitment Drive',
        Description: 'Zoho Corporation campus hiring for Software Developer roles. 5-8.2 LPA package. Eligibility: CGPA ≥ 7.5, CSE/IT/ECE departments only.',
        Venue: 'Admin Block Seminar Hall', Date: '2026-08-20', Time: '09:00 AM', BatchNumber: '2022-2026', Category: 'Placement'
      },
      {
        EventID: 6, Title: 'SPOORTHY 2026 – Cultural & Arts Fest',
        Description: '2-day cultural extravaganza featuring dance, music, drama, fashion show, and fun games. Open for all departments. Register your team now!',
        Venue: 'Open Air Theatre & Main Ground', Date: '2026-09-20', Time: '10:00 AM', BatchNumber: 'all', Category: 'Cultural'
      }
    ];
    localStorage.setItem('mock_events', JSON.stringify(events));
  }

  // ─────────────────────────────────────────────────────────
  //  NOTICES
  // ─────────────────────────────────────────────────────────
  if (!localStorage.getItem('mock_notices')) {
    const notices = [
      { NoticeID: 1, Title: 'IA-II Examination Schedule', Content: 'Semester 5 IA-II exams: 28 July – 2 August 2026.', Priority: 'urgent', Date: '2026-07-20', Department: 'All' },
      { NoticeID: 2, Title: 'Anti-Ragging Awareness Workshop', Content: 'Mandatory workshop on 25 July 2026, Main Auditorium, 10:00 AM.', Priority: 'academic', Date: '2026-07-18', Department: 'All' },
      { NoticeID: 3, Title: 'TCS NQT Registration Open', Content: 'Deadline: 31 July 2026. Contact T&P Cell.', Priority: 'placement', Date: '2026-07-15', Department: 'All' },
      { NoticeID: 4, Title: 'Annual Sports Day Registrations', Content: 'Open until 22 July 2026. Contact Physical Education Dept.', Priority: 'campus', Date: '2026-07-12', Department: 'All' },
      { NoticeID: 5, Title: 'New Library Books Added – July 2026', Content: '50+ new engineering books added. Browse via Library tab.', Priority: 'library', Date: '2026-07-10', Department: 'All' }
    ];
    localStorage.setItem('mock_notices', JSON.stringify(notices));
  }

  // ─────────────────────────────────────────────────────────
  //  LIBRARY BOOKS — sourced from library-catalog.js BOOKS_CATALOG
  // ─────────────────────────────────────────────────────────
  if (!localStorage.getItem('mock_books')) {
    // Convert BOOKS_CATALOG (from library-catalog.js) to dashboard.js format
    let books = [];
    if (typeof BOOKS_CATALOG !== 'undefined' && Array.isArray(BOOKS_CATALOG)) {
      books = BOOKS_CATALOG.map(b => ({
        BookID: b.id,
        Title: b.title,
        Author: b.author,
        Category: b.category,
        Floor: b.floor,
        Rack: b.rack,
        Shelf: b.shelf,
        Copies: b.copies,
        AvailableCopies: b.availableCopies,
        ISBN: b.isbn || '',
        ImagePath: b.image || ''
      }));
    } else {
      // Inline 58-book fallback in case library-catalog.js is not loaded
      books = [
        { BookID:1,  Title:'1800 Mechanical Movements, Devices and Appliances', Author:'Gardner D. Hiscox', Category:'Mechanical Engineering', Floor:'Floor 2', Rack:'Rack M-04', Shelf:'Shelf B', Copies:5, AvailableCopies:4, ISBN:'978-0486457741', ImagePath:'1800 Mechanical Movements, Devices and Appliances (Dover Science Books).jpg' },
        { BookID:2,  Title:'71 Best Control System Books Technical Reference', Author:'ISA Technical Reference', Category:'Control Systems', Floor:'Floor 3', Rack:'Rack C-02', Shelf:'Shelf A', Copies:4, AvailableCopies:3, ISBN:'978-1556179426', ImagePath:'71 Best Control System Books of All Time (Updated___.jpg' },
        { BookID:3,  Title:'Algorithms in C++ Part 5: Graph Algorithms', Author:'Robert Sedgewick', Category:'Computer Science', Floor:'Floor 1', Rack:'Rack CS-01', Shelf:'Shelf C', Copies:8, AvailableCopies:6, ISBN:'978-0201361186', ImagePath:'Algorithms in C++ Part 5_ Graph Algorithms.jpg' },
        { BookID:4,  Title:'Beginning Ubuntu Linux: From Novice to Professional', Author:'Keir Thomas & Andy Channelle', Category:'Computer Science', Floor:'Floor 1', Rack:'Rack CS-05', Shelf:'Shelf A', Copies:6, AvailableCopies:4, ISBN:'978-1590599914', ImagePath:'Beginning Ubuntu Linux_ From Novice to Professional (Beginning Series_ Open Source).jpg' },
        { BookID:5,  Title:'Building Embedded Linux Systems', Author:'Karim Yaghmour', Category:'Embedded Systems', Floor:'Floor 2', Rack:'Rack EC-03', Shelf:'Shelf D', Copies:4, AvailableCopies:2, ISBN:'978-0596002220', ImagePath:'Building Embedded Linux Systems_ Concepts, Techniques, Tricks, and Traps.jpg' },
        { BookID:6,  Title:'C Programming Language: Step by Step Beginner\'s Guide', Author:'Darrell L. Graham', Category:'Programming', Floor:'Floor 1', Rack:'Rack CS-01', Shelf:'Shelf A', Copies:10, AvailableCopies:8, ISBN:'978-1533612052', ImagePath:'C Programming_ Language_ A Step by Step Beginner\'s Guide to Learn C Programming in 7 Days.jpg' },
        { BookID:7,  Title:'Cognitive Dependability Engineering', Author:'Peter L. Jackson', Category:'Cyber-Physical Systems', Floor:'Floor 3', Rack:'Rack AI-02', Shelf:'Shelf B', Copies:3, AvailableCopies:3, ISBN:'978-3030823405', ImagePath:'Cognitive Dependability Engineering_ Managing Risks In Cyber-Physical-Social Systems Under Deep Uncertainty.jpg' },
        { BookID:8,  Title:'Computational Thinking: A Beginner\'s Guide', Author:'Karl Beecher', Category:'Computer Science', Floor:'Floor 1', Rack:'Rack CS-02', Shelf:'Shelf B', Copies:7, AvailableCopies:5, ISBN:'978-1780173641', ImagePath:'Computational Thinking_ A Beginner\'S Guide To Problem-Solving And Programming.jpg' },
        { BookID:9,  Title:'Computer Architecture: Digital Circuits to Computer Systems', Author:'David Harris & Sarah Harris', Category:'Hardware', Floor:'Floor 2', Rack:'Rack EC-01', Shelf:'Shelf C', Copies:6, AvailableCopies:4, ISBN:'978-0123944245', ImagePath:'Computer Architecture_ Digital Circuits to….jpg' },
        { BookID:10, Title:'Control Systems Engineer Technical Reference Handbook', Author:'ISA Society', Category:'Control Systems', Floor:'Floor 3', Rack:'Rack C-01', Shelf:'Shelf D', Copies:5, AvailableCopies:3, ISBN:'978-1936007837', ImagePath:'Control Systems Engineer Technical Reference Handbook - ISA.jpg' },
        { BookID:11, Title:'Control of Mechatronic Systems: Model-Driven Design', Author:'Patrick O. J. Kaltjob', Category:'Mechatronics', Floor:'Floor 3', Rack:'Rack M-05', Shelf:'Shelf A', Copies:4, AvailableCopies:2, ISBN:'978-1119534723', ImagePath:'Control of Mechatronic Systems_ Model-Driven Design and Implementation Guidelines.jpg' },
        { BookID:12, Title:'Dominic Chinea Machines: A Visual History', Author:'Dominic Chinea', Category:'Mechanical Engineering', Floor:'Floor 2', Rack:'Rack M-02', Shelf:'Shelf C', Copies:3, AvailableCopies:3, ISBN:'978-0241515907', ImagePath:'Dominic Chinea Machines A Visual History (hardback) (uk Import).jpg' },
        { BookID:13, Title:'Modern Mathematics for the Engineer', Author:'Edwin F. Beckenbach', Category:'Mathematics', Floor:'Floor 1', Rack:'Rack MA-01', Shelf:'Shelf B', Copies:8, AvailableCopies:7, ISBN:'978-0486497396', ImagePath:'Dover Books on Engineering_ Modern Mathematics for the Engineer_ Second Series (Paperback) - Walmart_com.jpg' },
        { BookID:14, Title:'Engineering Calculation Pocket Book', Author:'Tyler G. Hicks', Category:'Engineering Reference', Floor:'Floor 1', Rack:'Rack GEN-01', Shelf:'Shelf A', Copies:12, AvailableCopies:9, ISBN:'978-0071830805', ImagePath:'Engineering Calculation Pocket Book_ Easy to Use Handbook for Engineers - Formulas, Equations and Mathematics.jpg' },
        { BookID:15, Title:'Engineering Physics Complete Notes & Handbook', Author:'Dr. A. S. Vasudeva', Category:'Physics', Floor:'Floor 1', Rack:'Rack PH-01', Shelf:'Shelf D', Copies:15, AvailableCopies:11, ISBN:'978-8121923767', ImagePath:'Engineering physics note.jpg' },
        { BookID:16, Title:'Essential Cybersecurity Science', Author:'Josiah Dykstra', Category:'Cybersecurity', Floor:'Floor 3', Rack:'Rack SEC-01', Shelf:'Shelf A', Copies:5, AvailableCopies:4, ISBN:'978-1491920947', ImagePath:'Essential Cybersecurity Science_ Build, Test, And Evaluate Secure Systems.jpg' },
        { BookID:17, Title:'Exceptional C++: 47 Engineering Puzzles & Solutions', Author:'Herb Sutter', Category:'Programming', Floor:'Floor 1', Rack:'Rack CS-03', Shelf:'Shelf B', Copies:6, AvailableCopies:5, ISBN:'978-0201615623', ImagePath:'Exceptional C++_ 47 Engineering Puzzles, Programming Problems, and Solutions.jpg' },
        { BookID:18, Title:'Fundamentals of Aerospace Engineering', Author:'Manuel Soler', Category:'Aerospace', Floor:'Floor 2', Rack:'Rack AERO-01', Shelf:'Shelf C', Copies:4, AvailableCopies:3, ISBN:'978-1499369069', ImagePath:'Fundamentals of Aerospace Engineering_ (Beginner\'s Guide).jpg' },
        { BookID:19, Title:'How To Train Your Thinking: Sharpen Your Mind', Author:'R. L. Adams', Category:'General Reading', Floor:'Floor 1', Rack:'Rack GEN-03', Shelf:'Shelf A', Copies:5, AvailableCopies:4, ISBN:'978-1541019058', ImagePath:'How To Train Your Thinking_ Sharpen Your Mind To Think Bigger And Materialize Your Dreams.webp' },
        { BookID:20, Title:'How to Build Impossible Things', Author:'Mark Miodownik', Category:'Innovation & Design', Floor:'Floor 1', Rack:'Rack DES-01', Shelf:'Shelf B', Copies:4, AvailableCopies:2, ISBN:'978-0525537571', ImagePath:'How to Build Impossible Things.jpg' },
        { BookID:21, Title:'Interdisciplinary Mechatronics & Systems', Author:'M. K. Habib', Category:'Mechatronics', Floor:'Floor 3', Rack:'Rack M-04', Shelf:'Shelf C', Copies:3, AvailableCopies:2, ISBN:'978-1848215160', ImagePath:'Interdisciplinary Mechatronics - 19_99.jpg' },
        { BookID:22, Title:'Learning Systems Thinking', Author:'Diana Wright', Category:'Systems Engineering', Floor:'Floor 3', Rack:'Rack SYS-01', Shelf:'Shelf A', Copies:7, AvailableCopies:6, ISBN:'978-1605099255', ImagePath:'Learning Systems Thinking.jpg' },
        { BookID:23, Title:'Linux Bible: The Comprehensive Tutorial', Author:'Christopher Negus', Category:'Operating Systems', Floor:'Floor 1', Rack:'Rack OS-01', Shelf:'Shelf A', Copies:9, AvailableCopies:7, ISBN:'978-1119578888', ImagePath:'Linux Bible.jpg' },
        { BookID:24, Title:'Linux for Beginners: Quick Command Line', Author:'Jason Cannon', Category:'Operating Systems', Floor:'Floor 1', Rack:'Rack OS-02', Shelf:'Shelf B', Copies:12, AvailableCopies:10, ISBN:'978-1496145055', ImagePath:'Linux for Beginners_ An Introduction to the Linux….jpg' },
        { BookID:25, Title:'Modern Control Engineering 5th Edition', Author:'Katsuhiko Ogata', Category:'Control Systems', Floor:'Floor 3', Rack:'Rack C-03', Shelf:'Shelf D', Copies:8, AvailableCopies:5, ISBN:'978-0136156734', ImagePath:'Modern Control Engineering 5th Edition By Katsuhiko Ogata (PDF-Summary-Review-Online Reading-Download) - Toevolution.jpg' },
        { BookID:26, Title:'Air Pollution Control Engineering', Author:'Noel de Nevers', Category:'Environmental', Floor:'Floor 2', Rack:'Rack ENV-01', Shelf:'Shelf B', Copies:4, AvailableCopies:3, ISBN:'978-1478639206', ImagePath:'NEVERS, Noel de_ Air pollution control….jpg' },
        { BookID:27, Title:'Robotics: Modelling, Planning and Control', Author:'Bruno Siciliano et al.', Category:'Robotics', Floor:'Floor 3', Rack:'Rack ROB-01', Shelf:'Shelf A', Copies:6, AvailableCopies:4, ISBN:'978-1846286414', ImagePath:'Robotics_ Modelling, Planning and Control….jpg' },
        { BookID:28, Title:'Robots and Robotics: Principles and Applications', Author:'Mark R. Miller', Category:'Robotics', Floor:'Floor 3', Rack:'Rack ROB-02', Shelf:'Shelf C', Copies:5, AvailableCopies:4, ISBN:'978-1259859786', ImagePath:'Robots and Robotics_ Principles, Systems, and Industrial Applications.jpg' },
        { BookID:29, Title:'Shell Scripting: Automate Command Line Tasks', Author:'Jason Cannon', Category:'Operating Systems', Floor:'Floor 1', Rack:'Rack OS-03', Shelf:'Shelf A', Copies:7, AvailableCopies:5, ISBN:'978-1517300760', ImagePath:'Shell Scripting_ How to Automate Command Line….jpg' },
        { BookID:30, Title:'Structural Dynamics: Volume 50', Author:'Peretz P. Friedmann et al.', Category:'Civil Engineering', Floor:'Floor 2', Rack:'Rack CIV-01', Shelf:'Shelf D', Copies:3, AvailableCopies:2, ISBN:'978-3319297620', ImagePath:'Structural Dynamics_ Volume 50 _ Peretz P_ Friedmann,George A. Lesieutre,Daning Huang' },
        { BookID:31, Title:'The Algorithm Design Manual', Author:'Steven S. Skiena', Category:'Algorithms', Floor:'Floor 1', Rack:'Rack CS-04', Shelf:'Shelf A', Copies:10, AvailableCopies:8, ISBN:'978-1848000698', ImagePath:'The Algorithm Design Manual by Steve S_ Skiena.jpg' },
        { BookID:32, Title:'The Book of Basic Machines', Author:'U.S. Navy Bureau of Naval Personnel', Category:'Mechanical Engineering', Floor:'Floor 2', Rack:'Rack M-01', Shelf:'Shelf B', Copies:6, AvailableCopies:5, ISBN:'978-0486217093', ImagePath:'The Book of Basic Machines ebook by U_S. Navy - Rakuten Kobo' },
        { BookID:33, Title:'The Physics of Everyday Things', Author:'James Kakalios', Category:'Physics', Floor:'Floor 1', Rack:'Rack PH-02', Shelf:'Shelf C', Copies:5, AvailableCopies:4, ISBN:'978-0735216105', ImagePath:'The Physics of Everyday Things_ The Extraordinary Science Behind an Ordinary Day.jpg' },
        { BookID:34, Title:'Think Like An Engineer', Author:'Mushtak Al-Atabi', Category:'General Engineering', Floor:'Floor 1', Rack:'Rack GEN-02', Shelf:'Shelf B', Copies:8, AvailableCopies:6, ISBN:'978-1482824247', ImagePath:'Think Like An Engineer_ Inside the Minds that are Changing our Lives.jpg' },
        { BookID:35, Title:'Thinking in Algorithms', Author:'Rutherford Birchard', Category:'Algorithms', Floor:'Floor 1', Rack:'Rack CS-04', Shelf:'Shelf B', Copies:7, AvailableCopies:6, ISBN:'978-1794501234', ImagePath:'Thinking in Algorithms_ How to Combine Computer Analysis and Human Creativity for Better Problem-Solving and Decision-Making.jpg' },
        { BookID:36, Title:'Analog Circuits (World Class Designs)', Author:'Robert A. Pease', Category:'Electronics', Floor:'Floor 2', Rack:'Rack EC-04', Shelf:'Shelf A', Copies:5, AvailableCopies:3, ISBN:'978-0750686273', ImagePath:'[PDF] Analog Circuits (World Class Designs).jpg' },
        { BookID:37, Title:'Theory of Applied Robotics: Kinematics & Control', Author:'Reza N. Jazar', Category:'Robotics', Floor:'Floor 3', Rack:'Rack ROB-03', Shelf:'Shelf B', Copies:4, AvailableCopies:3, ISBN:'978-1441917492', ImagePath:'كتاب Theory of Applied Robotics - Kinematics, Dynamics, and Control.webp' },
        { BookID:38, Title:'Manufacturing Engineering Special Edition', Author:'SME Society of Manufacturing', Category:'Manufacturing', Floor:'Floor 2', Rack:'Rack M-03', Shelf:'Shelf A', Copies:4, AvailableCopies:4, ISBN:'978-0872638525', ImagePath:'September 2012 issue_ www.MfgEngMedia.com' },
        { BookID:39, Title:'Vintage Engineering Book Cover Reference', Author:'Classic Archive', Category:'Design', Floor:'Floor 1', Rack:'Rack ART-01', Shelf:'Shelf C', Copies:2, AvailableCopies:2, ISBN:'978-0001122334', ImagePath:'old Book Cover Design for Authors & Self‑Publishers.jpg' },
        { BookID:40, Title:'Advanced Sensor Networks & Facility Management', Author:'Industrial IoT Group', Category:'IoT & Sensors', Floor:'Floor 3', Rack:'Rack AI-03', Shelf:'Shelf C', Copies:6, AvailableCopies:5, ISBN:'978-3030112234', ImagePath:'🛠️ Facility managers_ Use sensors to detect….jpg' },
        { BookID:41, Title:'Stark Tech Advanced System Architecture', Author:'Anthony E. Stark', Category:'Artificial Intelligence', Floor:'Floor 3', Rack:'Rack AI-01', Shelf:'Shelf A', Copies:5, AvailableCopies:5, ISBN:'978-0785123456', ImagePath:'tony stark.webp' },
        { BookID:42, Title:'Keep Your Spirit: Mindset & Resilience', Author:'Muth Boravy', Category:'General Reading', Floor:'Floor 1', Rack:'Rack GEN-04', Shelf:'Shelf D', Copies:4, AvailableCopies:4, ISBN:'978-9995012345', ImagePath:'Muth Boravy, Keep Your Spirit_.webp' },
        { BookID:43, Title:'Christmas System UI & App Icon Engineering', Author:'Creative Tech Guild', Category:'UI/UX Design', Floor:'Floor 1', Rack:'Rack DES-02', Shelf:'Shelf A', Copies:3, AvailableCopies:3, ISBN:'978-1234567890', ImagePath:'Christmas Ios 14 Homescreen - Christmas App Icon - Christmas App Icons.jpg' },
        { BookID:44, Title:'Advanced Machine Learning Foundations', Author:'Deep Learning Research Unit', Category:'Artificial Intelligence', Floor:'Floor 3', Rack:'Rack AI-02', Shelf:'Shelf D', Copies:6, AvailableCopies:4, ISBN:'978-0262035613', ImagePath:'15833036179123253.jpg' },
        { BookID:45, Title:'Quantum Computing for Engineers', Author:'Nielsen & Chuang', Category:'Computer Science', Floor:'Floor 1', Rack:'Rack CS-06', Shelf:'Shelf A', Copies:5, AvailableCopies:3, ISBN:'978-1107002173', ImagePath:'16395986135270484.jpg' },
        { BookID:46, Title:'Data Science & Big Data Analytics', Author:'EMC Education Services', Category:'Data Science', Floor:'Floor 1', Rack:'Rack DS-01', Shelf:'Shelf B', Copies:8, AvailableCopies:6, ISBN:'978-1118876138', ImagePath:'17662623526792877.jpg' },
        { BookID:47, Title:'VLSI Circuit Design Fundamentals', Author:'Sung-Mo Kang', Category:'Electronics', Floor:'Floor 2', Rack:'Rack EC-02', Shelf:'Shelf C', Copies:7, AvailableCopies:5, ISBN:'978-0072460704', ImagePath:'19140367162786879.webp' },
        { BookID:48, Title:'Signals and Systems 2nd Edition', Author:'Alan V. Oppenheim', Category:'Electronics', Floor:'Floor 2', Rack:'Rack EC-01', Shelf:'Shelf B', Copies:10, AvailableCopies:8, ISBN:'978-0138147570', ImagePath:'227854062384195688.jpg' },
        { BookID:49, Title:'Database System Concepts 7th Edition', Author:'Silberschatz, Korth & Sudarshan', Category:'Computer Science', Floor:'Floor 1', Rack:'Rack CS-02', Shelf:'Shelf D', Copies:12, AvailableCopies:9, ISBN:'978-0078022159', ImagePath:'269582727689726415.jpg' },
        { BookID:50, Title:'Computer Networks: System Approach', Author:'Larry L. Peterson', Category:'Networking', Floor:'Floor 1', Rack:'Rack NET-01', Shelf:'Shelf A', Copies:9, AvailableCopies:7, ISBN:'978-0123850591', ImagePath:'2744449769437942.jpg' },
        { BookID:51, Title:'Digital Image Processing 4th Edition', Author:'Rafael C. Gonzalez', Category:'Computer Science', Floor:'Floor 3', Rack:'Rack AI-04', Shelf:'Shelf B', Copies:6, AvailableCopies:4, ISBN:'978-0133356724', ImagePath:'339669996917645733.jpg' },
        { BookID:52, Title:'Operating System Concepts 10th Edition', Author:'Silberschatz & Galvin', Category:'Operating Systems', Floor:'Floor 1', Rack:'Rack OS-01', Shelf:'Shelf C', Copies:14, AvailableCopies:11, ISBN:'978-1118063330', ImagePath:'703617141800061904.jpg' },
        { BookID:53, Title:'Thermal Engineering & Thermodynamics', Author:'R. K. Rajput', Category:'Mechanical Engineering', Floor:'Floor 2', Rack:'Rack M-01', Shelf:'Shelf D', Copies:8, AvailableCopies:6, ISBN:'978-8131808047', ImagePath:'711639178668335549.webp' },
        { BookID:54, Title:'Renewable Energy Technology & Power', Author:'Godfrey Boyle', Category:'Electrical Engineering', Floor:'Floor 2', Rack:'Rack EE-02', Shelf:'Shelf A', Copies:5, AvailableCopies:4, ISBN:'978-0199545339', ImagePath:'727120302347428706.jpg' },
        { BookID:55, Title:'Power Electronics: Circuits & Devices', Author:'Muhammad H. Rashid', Category:'Electrical Engineering', Floor:'Floor 2', Rack:'Rack EE-01', Shelf:'Shelf C', Copies:7, AvailableCopies:5, ISBN:'978-0133125900', ImagePath:'791366965808943978.jpg' },
        { BookID:56, Title:'Artificial Intelligence: Modern Approach', Author:'Stuart Russell & Peter Norvig', Category:'Artificial Intelligence', Floor:'Floor 3', Rack:'Rack AI-01', Shelf:'Shelf A', Copies:15, AvailableCopies:12, ISBN:'978-0134610992', ImagePath:'92605336081364053.jpg' },
        { BookID:57, Title:'Deep Learning Foundations & Applications', Author:'Ian Goodfellow & Yoshua Bengio', Category:'Artificial Intelligence', Floor:'Floor 3', Rack:'Rack AI-02', Shelf:'Shelf B', Copies:11, AvailableCopies:9, ISBN:'978-0262035614', ImagePath:'939493172276013197.jpg' },
        { BookID:58, Title:'Special Collections Reference', Author:'Saranathan Central Library', Category:'General Engineering', Floor:'Floor 1', Rack:'Rack REF-01', Shelf:'Shelf A', Copies:4, AvailableCopies:3, ISBN:'978-0000001122', ImagePath:'Only 8 left and in 6 carts.jpg' }
      ];
    }
    localStorage.setItem('mock_books', JSON.stringify(books));
  }

  // ─────────────────────────────────────────────────────────
  //  CHATBOT KNOWLEDGE BASE
  // ─────────────────────────────────────────────────────────
  if (!localStorage.getItem('mock_chatbotKB')) {
    const chatbotKB = [
      { Keywords: 'library,timing,hours',   Answer: 'The Central Library is open Monday–Saturday: 8:00 AM – 8:00 PM. Sundays: 10:00 AM – 5:00 PM.' },
      { Keywords: 'canteen,mess,food',       Answer: 'Mess timings: Breakfast 7:00–8:30 AM, Lunch 12:15–1:15 PM, Dinner 7:30–9:00 PM. Special menu on weekends.' },
      { Keywords: 'hostel,curfew',           Answer: 'Hostel curfew is 10:00 PM on weekdays and 11:00 PM on weekends. WiFi available 6 AM – 11 PM.' },
      { Keywords: 'placement,eligibility',   Answer: 'General placement eligibility: CGPA ≥ 6.0, No active backlogs, 75% throughout academics. Top firms like Zoho require ≥ 7.5 CGPA.' },
      { Keywords: 'bus,route',               Answer: 'Saranathan College operates 6 bus routes. Routes 01–06 depart from 7:10–7:35 AM daily. Check the Hostel & Transport tab for full details.' },
      { Keywords: 'fees,payment',            Answer: 'You can pay your pending tuition and mess fees directly from the Home Overview tab of your student dashboard using the Fee Dues card.' },
      { Keywords: 'exam,schedule,timetable', Answer: 'Semester 5 exams run from 10–21 November 2026. Check the Class Timetable tab for subject-wise exam dates and hall allotments.' },
      { Keywords: 'os,operating systems,book,rack', Answer: 'Operating System Concepts (Silberschatz) is located on Floor 1, Rack CS-02, Shelf A. 9 copies available, currently 6 in stock.' },
      { Keywords: 'dbms,database,book,rack', Answer: 'Database System Concepts (Silberschatz) is on Floor 1, Rack CS-02, Shelf B. Search the Library Shelf tab for more details.' }
    ];
    localStorage.setItem('mock_chatbotKB', JSON.stringify(chatbotKB));
  }

  console.log('[mock-data.js] ✅ All mock data seeded into localStorage successfully.');
}

// Auto-seed on load
seedMockData();
