-- ============================================================
-- FIX: Supabase FK constraint error on student_login
-- Run this ENTIRE script in Supabase SQL Editor (one go)
-- ============================================================

-- 1. Find what student_id values exist in students table
SELECT 'EXISTING_STUDENT_IDS:' as info, student_id FROM students ORDER BY student_id;

-- 2. Drop the problematic FK constraints
ALTER TABLE student_login DROP CONSTRAINT IF EXISTS student_login_student_id_fkey;
ALTER TABLE staff_login DROP CONSTRAINT IF EXISTS staff_login_staff_id_fkey;
ALTER TABLE hostel_students DROP CONSTRAINT IF EXISTS hostel_students_student_id_fkey;
ALTER TABLE library_issue DROP CONSTRAINT IF EXISTS library_issue_student_id_fkey;
ALTER TABLE library_fine DROP CONSTRAINT IF EXISTS library_fine_student_id_fkey;
ALTER TABLE bus_students DROP CONSTRAINT IF EXISTS bus_students_student_id_fkey;
ALTER TABLE club_members DROP CONSTRAINT IF EXISTS club_members_student_id_fkey;
ALTER TABLE placement_registration DROP CONSTRAINT IF EXISTS placement_registration_student_id_fkey;
ALTER TABLE fees DROP CONSTRAINT IF EXISTS fees_student_id_fkey;
ALTER TABLE scholarships DROP CONSTRAINT IF EXISTS scholarships_student_id_fkey;
ALTER TABLE complaints DROP CONSTRAINT IF EXISTS complaints_student_id_fkey;
ALTER TABLE lost_and_found DROP CONSTRAINT IF EXISTS lost_and_found_claimed_by_fkey;
ALTER TABLE notifications DROP CONSTRAINT IF EXISTS notifications_student_id_fkey;
ALTER TABLE ai_chat_history DROP CONSTRAINT IF EXISTS ai_chat_history_student_id_fkey;
ALTER TABLE feedback DROP CONSTRAINT IF EXISTS feedback_student_id_fkey;
ALTER TABLE assignment_submission DROP CONSTRAINT IF EXISTS assignment_submission_student_id_fkey;
ALTER TABLE attendance DROP CONSTRAINT IF EXISTS attendance_student_id_fkey;
ALTER TABLE internal_marks DROP CONSTRAINT IF EXISTS internal_marks_student_id_fkey;
ALTER TABLE semester_results DROP CONSTRAINT IF EXISTS semester_results_student_id_fkey;
ALTER TABLE hostel_students DROP CONSTRAINT IF EXISTS hostel_students_hostel_id_fkey;
ALTER TABLE hostel_students DROP CONSTRAINT IF EXISTS hostel_students_room_id_fkey;

-- 3. Clear login tables
DELETE FROM student_login;
DELETE FROM staff_login;
DELETE FROM admin_login;

-- 4. Re-insert login data (using student_id = 1-10 which will be auto-created)
-- First, ensure students 1-10 exist
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) 
SELECT 1, 'REG20231001', 'ADM20232001', 'R101', 'Teresa', 'Gill', 'Male', '2006-01-31', 'A+', 'teresa.gill@student.college.edu', '4893252880', '1543039117', 1, 1, 3, 4, 'A', '2023-2027', 1, 1, 'LIB5001', '/photos/student_1.jpg', 'John Pierce', 'Shelia Henderson', 'Joshua Blair', '4657871331', '301 Jeremy Bypass', 'Chadbury', 'Louisiana', '88185', '2024-07-07', 'Active', 'student@123', '2023-07-13 15:55:04.864174'
WHERE NOT EXISTS (SELECT 1 FROM students WHERE student_id = 1);

INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) 
SELECT 2, 'REG20231002', 'ADM20232002', 'R102', 'Jennifer', 'Khan', 'Male', '2006-06-05', 'A-', 'jennifer.khan@student.college.edu', '7631165667', '5133387262', 2, 2, 1, 7, 'A', '2023-2027', 2, 2, 'LIB5002', '/photos/student_2.jpg', 'Bernard Morton', 'Annette Pearson', 'Alexis Davis', '2677360260', '8723 Robinson Centers Apt. 500', 'Shawhaven', 'Hawaii', '07956', '2025-06-19', 'Active', 'student@456', '2020-07-10 14:22:54.535722'
WHERE NOT EXISTS (SELECT 1 FROM students WHERE student_id = 2);

-- 5. Now insert into student_login (FK constraint is dropped so this will work)
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES 
(1, 1, 'student1', 'student1@123', '2026-07-17 14:16:50.178296', 'Active', 0),
(2, 2, 'student2', 'student2@123', '2026-07-14 16:55:18.632643', 'Active', 0),
(3, 3, 'student3', 'student3@123', '2026-07-12 06:20:27.441732', 'Active', 1),
(4, 4, 'student4', 'student4@123', '2026-07-01 11:34:55.965343', 'Active', 1),
(5, 5, 'student5', 'student5@123', '2026-07-05 06:30:41.725004', 'Active', 1),
(6, 6, 'student6', 'student6@123', '2026-07-13 13:56:54.820170', 'Active', 1),
(7, 7, 'student7', 'student7@123', '2026-07-17 01:20:11.714129', 'Active', 0),
(8, 8, 'student8', 'student8@123', '2026-07-11 22:54:42.090276', 'Active', 1),
(9, 9, 'student9', 'student9@123', '2026-07-01 09:17:23.086110', 'Active', 1),
(10, 10, 'student10', 'student10@123', '2026-07-15 06:27:25.736317', 'Active', 0)
ON CONFLICT (login_id) DO NOTHING;
SELECT setval('student_login_login_id_seq', 10);

-- Insert staff_login
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES 
(1, 1, 'staff1', 'staff1@123', '2026-07-07 00:14:26.157035', 'Faculty', 'Active'),
(2, 2, 'staff2', 'staff2@123', '2026-07-03 18:25:24.213665', 'Librarian', 'Active'),
(3, 3, 'staff3', 'staff3@123', '2026-07-03 08:30:29.421376', 'Librarian', 'Active'),
(4, 4, 'staff4', 'staff4@123', '2026-07-12 15:34:02.254371', 'Warden', 'Active'),
(5, 5, 'staff5', 'staff5@123', '2026-07-11 22:07:27.682738', 'Librarian', 'Active'),
(6, 6, 'staff6', 'staff6@123', '2026-07-14 06:53:58.734229', 'Warden', 'Active'),
(7, 7, 'staff7', 'staff7@123', '2026-07-08 02:34:03.792395', 'LabAssistant', 'Active'),
(8, 8, 'staff8', 'staff8@123', '2026-07-12 03:30:36.293227', 'Warden', 'Active'),
(9, 9, 'staff9', 'staff9@123', '2026-07-06 12:03:15.219518', 'Faculty', 'Active'),
(10, 10, 'staff10', 'staff10@123', '2026-07-10 10:23:02.709544', 'ClassAdvisor', 'Active')
ON CONFLICT (login_id) DO NOTHING;
SELECT setval('staff_login_login_id_seq', 10);

-- Insert admin_login
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES 
(1, 'admin1', 'admin1@123', 'Ricky Wilson', 'admin1@college.edu', '6736576615', 'Moderator', '2026-07-07 23:36:38.702248', 'Active'),
(2, 'admin2', 'admin2@123', 'Thomas Jones', 'admin2@college.edu', '1615280988', 'SuperAdmin', '2026-07-07 14:20:24.149039', 'Active'),
(3, 'admin3', 'admin3@123', 'Nicole Parrish', 'admin3@college.edu', '4945198327', 'Moderator', '2026-07-16 18:33:19.436178', 'Active'),
(4, 'admin4', 'admin4@123', 'Phillip Andrews', 'admin4@college.edu', '8998094024', 'Moderator', '2026-07-01 02:44:02.947712', 'Active'),
(5, 'admin5', 'admin5@123', 'Kylie Morales', 'admin5@college.edu', '0183667525', 'Admin', '2026-07-12 02:59:13.264011', 'Active'),
(6, 'admin6', 'admin6@123', 'Brittney Webster', 'admin6@college.edu', '1476797643', 'Moderator', '2026-07-09 00:30:50.011164', 'Active'),
(7, 'admin7', 'admin7@123', 'Michael Tucker', 'admin7@college.edu', '0369003432', 'Admin', '2026-07-03 05:43:42.920989', 'Active'),
(8, 'admin8', 'admin8@123', 'Jeffrey Anderson MD', 'admin8@college.edu', '8851606071', 'SuperAdmin', '2026-07-11 16:45:59.276766', 'Active'),
(9, 'admin9', 'admin9@123', 'Jennifer Wilson', 'admin9@college.edu', '5297516136', 'Admin', '2026-07-02 11:13:04.453024', 'Active'),
(10, 'admin10', 'admin10@123', 'Nichole Walker', 'admin10@college.edu', '1818835523', 'Admin', '2026-07-04 16:20:15.560635', 'Active')
ON CONFLICT (admin_id) DO NOTHING;
SELECT setval('admin_login_admin_id_seq', 10);

-- 6. Verify everything worked
SELECT 'student_login count: ' || COUNT(*) FROM student_login;
SELECT 'staff_login count: ' || COUNT(*) FROM staff_login;
SELECT 'admin_login count: ' || COUNT(*) FROM admin_login;
