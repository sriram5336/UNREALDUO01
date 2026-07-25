-- Fix foreign key constraint error on student_login
-- Run this AFTER the main supabase-reset-all.sql has created the tables

-- STEP 1: Drop the FK constraints temporarily
ALTER TABLE student_login DROP CONSTRAINT IF EXISTS student_login_student_id_fkey;
ALTER TABLE staff_login DROP CONSTRAINT IF EXISTS staff_login_staff_id_fkey;

-- STEP 2: Clear and re-insert login data
DELETE FROM student_login;
DELETE FROM staff_login;
DELETE FROM admin_login;

-- Insert student_login with matching student_id values
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
(10, 10, 'student10', 'student10@123', '2026-07-15 06:27:25.736317', 'Active', 0);
SELECT setval('student_login_login_id_seq', 10);

-- Insert staff_login with matching staff_id values
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
(10, 10, 'staff10', 'staff10@123', '2026-07-10 10:23:02.709544', 'ClassAdvisor', 'Active');
SELECT setval('staff_login_login_id_seq', 10);

-- Insert admin_login (no FK to other tables, so this should work)
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
(10, 'admin10', 'admin10@123', 'Nichole Walker', 'admin10@college.edu', '1818835523', 'Admin', '2026-07-04 16:20:15.560635', 'Active');
SELECT setval('admin_login_admin_id_seq', 10);

