-- ============================================================
-- COMPLETE SUPABASE SETUP — 55 tables + 4 RPC functions
-- Run this ENTIRE script in one go in Supabase SQL Editor
-- ============================================================

-- Drop all tables in reverse dependency order
DROP TABLE IF EXISTS feedback CASCADE;
DROP TABLE IF EXISTS emergency_contacts CASCADE;
DROP TABLE IF EXISTS visitors CASCADE;
DROP TABLE IF EXISTS alumni CASCADE;
DROP TABLE IF EXISTS canteen_menu CASCADE;
DROP TABLE IF EXISTS classrooms CASCADE;
DROP TABLE IF EXISTS lab_equipment CASCADE;
DROP TABLE IF EXISTS labs CASCADE;
DROP TABLE IF EXISTS campus_navigation CASCADE;
DROP TABLE IF EXISTS buildings CASCADE;
DROP TABLE IF EXISTS ai_chat_history CASCADE;
DROP TABLE IF EXISTS notifications CASCADE;
DROP TABLE IF EXISTS announcements CASCADE;
DROP TABLE IF EXISTS lost_and_found CASCADE;
DROP TABLE IF EXISTS complaints CASCADE;
DROP TABLE IF EXISTS scholarships CASCADE;
DROP TABLE IF EXISTS fees CASCADE;
DROP TABLE IF EXISTS placement_registration CASCADE;
DROP TABLE IF EXISTS placements CASCADE;
DROP TABLE IF EXISTS club_members CASCADE;
DROP TABLE IF EXISTS clubs CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS previous_question_papers CASCADE;
DROP TABLE IF EXISTS notes CASCADE;
DROP TABLE IF EXISTS assignment_submission CASCADE;
DROP TABLE IF EXISTS assignments CASCADE;
DROP TABLE IF EXISTS semester_results CASCADE;
DROP TABLE IF EXISTS internal_marks CASCADE;
DROP TABLE IF EXISTS attendance CASCADE;
DROP TABLE IF EXISTS timetable CASCADE;
DROP TABLE IF EXISTS syllabus CASCADE;
DROP TABLE IF EXISTS subjects CASCADE;
DROP TABLE IF EXISTS bus_students CASCADE;
DROP TABLE IF EXISTS bus CASCADE;
DROP TABLE IF EXISTS bus_routes CASCADE;
DROP TABLE IF EXISTS hostel_students CASCADE;
DROP TABLE IF EXISTS hostel_rooms CASCADE;
DROP TABLE IF EXISTS hostel CASCADE;
DROP TABLE IF EXISTS library_fine CASCADE;
DROP TABLE IF EXISTS library_issue CASCADE;
DROP TABLE IF EXISTS library_books CASCADE;
DROP TABLE IF EXISTS librarian CASCADE;
DROP TABLE IF EXISTS library_staff CASCADE;
DROP TABLE IF EXISTS warden CASCADE;
DROP TABLE IF EXISTS lab_assistant CASCADE;
DROP TABLE IF EXISTS class_advisor CASCADE;
DROP TABLE IF EXISTS hod CASCADE;
DROP TABLE IF EXISTS faculty CASCADE;
DROP TABLE IF EXISTS admin_login CASCADE;
DROP TABLE IF EXISTS staff_login CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
DROP TABLE IF EXISTS student_login CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

-- ============================================================
-- 1. departments
-- ============================================================
CREATE TABLE departments (
department_id SERIAL PRIMARY KEY,
department_name VARCHAR(100) NOT NULL,
department_code VARCHAR(20) NOT NULL UNIQUE,
hod_id INT NULL,
office_location VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(20)
);
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (1, 'Computer Science', 'CSE', NULL, 'Block A, Room 101', 'cse@college.edu', '0433218196');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (2, 'Electronics & Communication', 'ECE', NULL, 'Block B, Room 102', 'ece@college.edu', '3890838637');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (3, 'Mechanical Engineering', 'MECH', NULL, 'Block C, Room 103', 'mech@college.edu', '6542351161');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (4, 'Civil Engineering', 'CIVIL', NULL, 'Block D, Room 104', 'civil@college.edu', '0781618495');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (5, 'Electrical Engineering', 'EEE', NULL, 'Block E, Room 105', 'eee@college.edu', '3413164752');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (6, 'Information Technology', 'IT', NULL, 'Block F, Room 106', 'it@college.edu', '1928327648');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (7, 'Biotechnology', 'BT', NULL, 'Block G, Room 107', 'bt@college.edu', '0564139537');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (8, 'Chemical Engineering', 'CHEM', NULL, 'Block H, Room 108', 'chem@college.edu', '2388496965');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (9, 'Mathematics', 'MATH', NULL, 'Block I, Room 109', 'math@college.edu', '1012269166');
INSERT INTO departments (department_id, department_name, department_code, hod_id, office_location, email, phone) VALUES (10, 'Physics', 'PHY', NULL, 'Block J, Room 110', 'phy@college.edu', '8018451462');

-- ============================================================
-- 2. courses
-- ============================================================
CREATE TABLE courses (
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(100) NOT NULL,
degree VARCHAR(50),
duration VARCHAR(20),
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (1, 'Computer Science Engineering', 'B.E./B.Tech', '4 Years', 1);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (2, 'Electronics & Communication Engineering', 'B.E./B.Tech', '4 Years', 2);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (3, 'Mechanical Engineering', 'B.E./B.Tech', '4 Years', 3);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (4, 'Civil Engineering', 'B.E./B.Tech', '4 Years', 4);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (5, 'Electrical Engineering', 'B.E./B.Tech', '4 Years', 5);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (6, 'Information Technology', 'B.E./B.Tech', '4 Years', 6);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (7, 'Biotechnology', 'B.E./B.Tech', '4 Years', 7);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (8, 'Chemical Engineering', 'B.E./B.Tech', '4 Years', 8);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (9, 'Applied Mathematics', 'B.E./B.Tech', '4 Years', 9);
INSERT INTO courses (course_id, course_name, degree, duration, department_id) VALUES (10, 'Applied Physics', 'B.E./B.Tech', '4 Years', 10);

-- ============================================================
-- 3. students
-- ============================================================
CREATE TABLE students (
student_id SERIAL PRIMARY KEY,
register_no VARCHAR(30) UNIQUE,
admission_no VARCHAR(30) UNIQUE,
roll_no VARCHAR(20),
first_name VARCHAR(50),
last_name VARCHAR(50),
gender VARCHAR(10),
dob DATE,
blood_group VARCHAR(5),
email VARCHAR(100),
phone VARCHAR(20),
alternate_phone VARCHAR(20),
department_id INT,
course_id INT,
year INT,
semester INT,
section VARCHAR(5),
batch VARCHAR(20),
hostel_id INT,
bus_route_id INT,
library_card_no VARCHAR(30),
profile_photo VARCHAR(255),
father_name VARCHAR(100),
mother_name VARCHAR(100),
guardian_name VARCHAR(100),
guardian_phone VARCHAR(20),
address VARCHAR(255),
city VARCHAR(50),
state VARCHAR(50),
pincode VARCHAR(10),
admission_date DATE,
status VARCHAR(20),
possword VARCHAR(255),
created_at TIMESTAMP,
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (1, 'REG20231001', 'ADM20232001', 'R101', 'Teresa', 'Gill', 'Male', '2006-01-31', 'A+', 'teresa.gill@student.college.edu', '4893252880', '1543039117', 1, 1, 3, 4, 'A', '2023-2027', 1, 1, 'LIB5001', '/photos/student_1.jpg', 'John Pierce', 'Shelia Henderson', 'Joshua Blair', '4657871331', '301 Jeremy Bypass', 'Chadbury', 'Louisiana', '88185', '2024-07-07', 'Active', 'student@123', '2023-07-13 15:55:04.864174');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (2, 'REG20231002', 'ADM20232002', 'R102', 'Jennifer', 'Khan', 'Male', '2006-06-05', 'A-', 'jennifer.khan@student.college.edu', '7631165667', '5133387262', 2, 2, 1, 7, 'A', '2023-2027', 2, 2, 'LIB5002', '/photos/student_2.jpg', 'Bernard Morton', 'Annette Pearson', 'Alexis Davis', '2677360260', '8723 Robinson Centers Apt. 500', 'Shawhaven', 'Hawaii', '07956', '2025-06-19', 'Active', 'student@456', '2020-07-10 14:22:54.535722');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (3, 'REG20231003', 'ADM20232003', 'R103', 'Jacob', 'Larson', 'Male', '2006-12-03', 'A-', 'jacob.larson@student.college.edu', '6193990916', '4353462475', 3, 3, 2, 4, 'C', '2023-2027', 3, 3, 'LIB5003', '/photos/student_3.jpg', 'Justin Garcia', 'Katie Anderson', 'Benjamin Sanchez', '2784980841', '824 Jacobs Stravenue', 'Jamesview', 'North Carolina', '64533', '2024-01-18', 'Active', 'student@789', '2025-12-12 00:08:40.538184');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (4, 'REG20231004', 'ADM20232004', 'R104', 'Brent', 'Walters', 'Male', '2007-09-11', 'B-', 'brent.walters@student.college.edu', '0524278680', '5982620450', 4, 4, 4, 4, 'B', '2023-2027', 4, 4, 'LIB5004', '/photos/student_4.jpg', 'Hector Castro', 'Valerie Brady', 'Cynthia Martin', '6025634216', '5433 Donna Locks', 'Joshualand', 'Wyoming', '37086', '2024-03-31', 'Active', 'student@101', '2023-05-03 07:46:55.906159');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (5, 'REG20231005', 'ADM20232005', 'R105', 'Erin', 'Anthony', 'Female', '2005-03-15', 'A+', 'erin.anthony@student.college.edu', '1429401965', '6934060883', 5, 5, 2, 7, 'B', '2023-2027', 5, 5, 'LIB5005', '/photos/student_5.jpg', 'Thomas Hanson', 'Belinda Mccullough', 'Mary Nguyen', '8236629946', '69957 Ramos Forest Suite 214', 'Clarencebury', 'Utah', '41188', '2023-12-29', 'Active', 'student@202', '2021-04-21 06:01:03.535509');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (6, 'REG20231006', 'ADM20232006', 'R106', 'Andrew', 'Sanchez', 'Female', '2005-12-03', 'B+', 'andrew.sanchez@student.college.edu', '7693676320', '8708317278', 6, 6, 2, 6, 'A', '2023-2027', 6, 6, 'LIB5006', '/photos/student_6.jpg', 'Steven Salazar', 'Kathy Rivas', 'Stephanie Manning', '7434873471', '8122 Patrick Drives Apt. 166', 'Amychester', 'Arkansas', '27611', '2025-03-18', 'Active', 'student@303', '2022-07-20 11:53:23.472470');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (7, 'REG20231007', 'ADM20232007', 'R107', 'Kayla', 'Shah', 'Male', '2003-08-23', 'AB+', 'kayla.shah@student.college.edu', '7054668893', '7065627298', 7, 7, 1, 6, 'B', '2023-2027', 7, 7, 'LIB5007', '/photos/student_7.jpg', 'Alexander Day', 'Julia Williams', 'Daniel Murphy', '4641708053', '09232 Caldwell Port', 'South Holly', 'Wyoming', '48852', '2023-11-18', 'Active', 'student@404', '2023-12-23 07:52:57.632457');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (8, 'REG20231008', 'ADM20232008', 'R108', 'Julie', 'Wilson', 'Female', '2007-08-23', 'A+', 'julie.wilson@student.college.edu', '1904966319', '9058651850', 8, 8, 4, 2, 'B', '2023-2027', 8, 8, 'LIB5008', '/photos/student_8.jpg', 'Jack Snow', 'Brittany Thompson', 'Marie Gilbert', '7694531473', '0752 Lewis Union Suite 549', 'Angelahaven', 'Illinois', '11722', '2024-01-11', 'Active', 'student@505', '2022-08-30 00:53:30.176529');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (9, 'REG20231009', 'ADM20232009', 'R109', 'Angela', 'Allen', 'Male', '2005-12-04', 'O+', 'angela.allen@student.college.edu', '7014363495', '6855744431', 9, 9, 3, 4, 'C', '2023-2027', 9, 9, 'LIB5009', '/photos/student_9.jpg', 'Trevor Vaughn', 'Nancy Hill', 'Paige Carlson', '3435240824', '271 Audrey Mountains Suite 752', 'West Shelleyfort', 'Delaware', '09065', '2024-05-06', 'Active', 'student@606', '2020-06-26 04:18:05.433477');
INSERT INTO students (student_id, register_no, admission_no, roll_no, first_name, last_name, gender, dob, blood_group, email, phone, alternate_phone, department_id, course_id, year, semester, section, batch, hostel_id, bus_route_id, library_card_no, profile_photo, father_name, mother_name, guardian_name, guardian_phone, address, city, state, pincode, admission_date, status, possword, created_at) VALUES (10, 'REG20231010', 'ADM20232010', 'R110', 'Crystal', 'Brown', 'Male', '2004-04-16', 'A+', 'crystal.brown@student.college.edu', '1318699938', '9649909133', 10, 10, 2, 5, 'A', '2023-2027', 10, 10, 'LIB5010', '/photos/student_10.jpg', 'Juan Moore', 'Melissa Harrison', 'Dwayne Campbell', '1349361832', '49947 Taylor Hollow', 'Benderhaven', 'Ohio', '65223', '2024-06-02', 'Active', 'student@707', '2023-12-01 07:10:58.081337');

-- ============================================================
-- 4. student_login
-- ============================================================
CREATE TABLE student_login (
login_id SERIAL PRIMARY KEY,
student_id INT,
username VARCHAR(50) UNIQUE,
possword VARCHAR(255),
last_login TIMESTAMP,
account_status VARCHAR(20),
otp_enabled INTEGER,
FOREIGN KEY (student_id) REFERENCES students(student_id)
);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (1, 1, 'student1', 'student1@123', '2026-07-17 14:16:50.178296', 'Active', 0);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (2, 2, 'student2', 'student2@123', '2026-07-14 16:55:18.632643', 'Active', 0);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (3, 3, 'student3', 'student3@123', '2026-07-12 06:20:27.441732', 'Active', 1);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (4, 4, 'student4', 'student4@123', '2026-07-01 11:34:55.965343', 'Active', 1);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (5, 5, 'student5', 'student5@123', '2026-07-05 06:30:41.725004', 'Active', 1);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (6, 6, 'student6', 'student6@123', '2026-07-13 13:56:54.820170', 'Active', 1);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (7, 7, 'student7', 'student7@123', '2026-07-17 01:20:11.714129', 'Active', 0);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (8, 8, 'student8', 'student8@123', '2026-07-11 22:54:42.090276', 'Active', 1);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (9, 9, 'student9', 'student9@123', '2026-07-01 09:17:23.086110', 'Active', 1);
INSERT INTO student_login (login_id, student_id, username, possword, last_login, account_status, otp_enabled) VALUES (10, 10, 'student10', 'student10@123', '2026-07-15 06:27:25.736317', 'Active', 0);

-- ============================================================
-- 5. staff
-- ============================================================
CREATE TABLE staff (
staff_id SERIAL PRIMARY KEY,
staff_code VARCHAR(30) UNIQUE,
name VARCHAR(100),
gender VARCHAR(10),
dob DATE,
designation VARCHAR(50),
department_id INT,
qualification VARCHAR(100),
experience INT,
email VARCHAR(100),
phone VARCHAR(20),
salary DECIMAL(10,2),
joining_date DATE,
address VARCHAR(255),
photo VARCHAR(255),
status VARCHAR(20),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (1, 'STF3001', 'Laura Hines', 'Female', '1971-04-30', 'Warden', 1, 'Ph.D', 20, 'lmoon@graham.info', '6551256746', 88973.15, '2012-10-11', '1680 Gutierrez Field Suite 977', '/photos/staff_1.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (2, 'STF3002', 'Christina Dunn', 'Male', '1996-02-28', 'Associate Professor', 2, 'M.Sc', 13, 'fgilmore@johnson.org', '2480861317', 57945.57, '2024-08-07', '467 Sanchez Plaza Apt. 639', '/photos/staff_2.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (3, 'STF3003', 'Sherry Shields', 'Male', '1974-08-30', 'Warden', 3, 'M.E', 25, 'ymorgan@adams.org', '2787558867', 100959.99, '2019-07-20', '0576 Mcneil Turnpike', '/photos/staff_3.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (4, 'STF3004', 'Veronica Simpson', 'Male', '1966-10-08', 'Professor', 4, 'M.E', 13, 'molly71@lozano.com', '7459615865', 57757.97, '2020-03-10', '431 Good Trace', '/photos/staff_4.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (5, 'STF3005', 'Shelia Wallace', 'Male', '1988-06-12', 'Librarian', 5, 'M.E', 7, 'williamslaura@howard-jordan.com', '9222196937', 90712.29, '2017-12-31', '4074 Charles Key Suite 647', '/photos/staff_5.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (6, 'STF3006', 'Christina Cruz', 'Female', '1981-06-29', 'Warden', 6, 'M.Sc', 5, 'patrickhoward@haney-phillips.biz', '0909743953', 57514.81, '2021-01-12', '104 Johnson Lakes', '/photos/staff_6.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (7, 'STF3007', 'Ann Phillips', 'Male', '1990-03-19', 'Warden', 7, 'MCA', 18, 'jamesbuchanan@schmidt-mcintyre.com', '7451712368', 57333.04, '2011-09-28', '5496 Rodriguez Fort', '/photos/staff_7.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (8, 'STF3008', 'Manuel Hahn', 'Female', '1976-05-15', 'Librarian', 8, 'M.Sc', 12, 'deborahreid@blankenship-turner.biz', '2004711382', 53642.26, '2020-12-06', '261 Gilbert Harbors Apt. 537', '/photos/staff_8.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (9, 'STF3009', 'David Cox', 'Male', '1997-12-01', 'Librarian', 9, 'M.Sc', 3, 'amy50@hill-donaldson.info', '3900532931', 99241.48, '2014-07-27', '2904 Vanessa Plains', '/photos/staff_9.jpg', 'Active');
INSERT INTO staff (staff_id, staff_code, name, gender, dob, designation, department_id, qualification, experience, email, phone, salary, joining_date, address, photo, status) VALUES (10, 'STF3010', 'Christopher Guerrero', 'Male', '1966-05-25', 'Associate Professor', 10, 'M.Tech', 22, 'howardkristina@morris.biz', '1775891783', 70883.6, '2015-10-08', '76617 Jones Common', '/photos/staff_10.jpg', 'Active');

-- ============================================================
-- 6. staff_login
-- ============================================================
CREATE TABLE staff_login (
login_id SERIAL PRIMARY KEY,
staff_id INT,
username VARCHAR(50) UNIQUE,
possword VARCHAR(255),
last_login TIMESTAMP,
role VARCHAR(30),
status VARCHAR(20),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (1, 1, 'staff1', 'staff1@123', '2026-07-07 00:14:26.157035', 'Faculty', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (2, 2, 'staff2', 'staff2@123', '2026-07-03 18:25:24.213665', 'Librarian', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (3, 3, 'staff3', 'staff3@123', '2026-07-03 08:30:29.421376', 'Librarian', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (4, 4, 'staff4', 'staff4@123', '2026-07-12 15:34:02.254371', 'Warden', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (5, 5, 'staff5', 'staff5@123', '2026-07-11 22:07:27.682738', 'Librarian', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (6, 6, 'staff6', 'staff6@123', '2026-07-14 06:53:58.734229', 'Warden', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (7, 7, 'staff7', 'staff7@123', '2026-07-08 02:34:03.792395', 'LabAssistant', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (8, 8, 'staff8', 'staff8@123', '2026-07-12 03:30:36.293227', 'Warden', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (9, 9, 'staff9', 'staff9@123', '2026-07-06 12:03:15.219518', 'Faculty', 'Active');
INSERT INTO staff_login (login_id, staff_id, username, possword, last_login, role, status) VALUES (10, 10, 'staff10', 'staff10@123', '2026-07-10 10:23:02.709544', 'ClassAdvisor', 'Active');

-- ============================================================
-- 7. admin_login
-- ============================================================
CREATE TABLE admin_login (
admin_id SERIAL PRIMARY KEY,
username VARCHAR(50) UNIQUE,
possword VARCHAR(255),
name VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(20),
role VARCHAR(30),
last_login TIMESTAMP,
status VARCHAR(20)
);
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (1, 'admin1', 'admin1@123', 'Ricky Wilson', 'admin1@college.edu', '6736576615', 'Moderator', '2026-07-07 23:36:38.702248', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (2, 'admin2', 'admin2@123', 'Thomas Jones', 'admin2@college.edu', '1615280988', 'SuperAdmin', '2026-07-07 14:20:24.149039', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (3, 'admin3', 'admin3@123', 'Nicole Parrish', 'admin3@college.edu', '4945198327', 'Moderator', '2026-07-16 18:33:19.436178', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (4, 'admin4', 'admin4@123', 'Phillip Andrews', 'admin4@college.edu', '8998094024', 'Moderator', '2026-07-01 02:44:02.947712', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (5, 'admin5', 'admin5@123', 'Kylie Morales', 'admin5@college.edu', '0183667525', 'Admin', '2026-07-12 02:59:13.264011', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (6, 'admin6', 'admin6@123', 'Brittney Webster', 'admin6@college.edu', '1476797643', 'Moderator', '2026-07-09 00:30:50.011164', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (7, 'admin7', 'admin7@123', 'Michael Tucker', 'admin7@college.edu', '0369003432', 'Admin', '2026-07-03 05:43:42.920989', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (8, 'admin8', 'admin8@123', 'Jeffrey Anderson MD', 'admin8@college.edu', '8851606071', 'SuperAdmin', '2026-07-11 16:45:59.276766', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (9, 'admin9', 'admin9@123', 'Jennifer Wilson', 'admin9@college.edu', '5297516136', 'Admin', '2026-07-02 11:13:04.453024', 'Active');
INSERT INTO admin_login (admin_id, username, possword, name, email, phone, role, last_login, status) VALUES (10, 'admin10', 'admin10@123', 'Nichole Walker', 'admin10@college.edu', '1818835523', 'Admin', '2026-07-04 16:20:15.560635', 'Active');

-- ============================================================
-- 8. faculty
-- ============================================================
CREATE TABLE faculty (
faculty_id SERIAL PRIMARY KEY,
staff_id INT,
department_id INT,
designation VARCHAR(50),
specialization VARCHAR(100),
cabin_no VARCHAR(20),
research_area VARCHAR(150),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (1, 1, 1, 'Associate Professor', 'Artificial Intelligence', 'C-101', 'Research in Artificial Intelligence');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (2, 2, 2, 'Lab Assistant', 'VLSI Design', 'C-102', 'Research in VLSI Design');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (3, 3, 3, 'Professor', 'Thermodynamics', 'C-103', 'Research in Thermodynamics');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (4, 4, 4, 'Warden', 'Structural Engineering', 'C-104', 'Research in Structural Engineering');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (5, 5, 5, 'Warden', 'Power Systems', 'C-105', 'Research in Power Systems');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (6, 6, 6, 'Assistant Professor', 'Cloud Computing', 'C-106', 'Research in Cloud Computing');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (7, 7, 7, 'Librarian', 'Genetic Engineering', 'C-107', 'Research in Genetic Engineering');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (8, 8, 8, 'Associate Professor', 'Process Control', 'C-108', 'Research in Process Control');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (9, 9, 9, 'Librarian', 'Algebra', 'C-109', 'Research in Algebra');
INSERT INTO faculty (faculty_id, staff_id, department_id, designation, specialization, cabin_no, research_area) VALUES (10, 10, 10, 'Professor', 'Quantum Mechanics', 'C-110', 'Research in Quantum Mechanics');

-- ============================================================
-- 9. hod
-- ============================================================
CREATE TABLE hod (
hod_id SERIAL PRIMARY KEY,
staff_id INT,
department_id INT,
start_date DATE,
end_date DATE,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (1, 1, 1, '2023-05-09', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (2, 2, 2, '2023-10-29', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (3, 3, 3, '2023-07-06', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (4, 4, 4, '2022-01-28', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (5, 5, 5, '2023-11-12', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (6, 6, 6, '2023-01-10', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (7, 7, 7, '2023-10-22', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (8, 8, 8, '2023-10-28', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (9, 9, 9, '2022-11-22', NULL);
INSERT INTO hod (hod_id, staff_id, department_id, start_date, end_date) VALUES (10, 10, 10, '2024-04-25', NULL);

-- ============================================================
-- 10. class_advisor
-- ============================================================
CREATE TABLE class_advisor (
advisor_id SERIAL PRIMARY KEY,
staff_id INT,
department_id INT,
year INT,
semester INT,
section VARCHAR(5),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (1, 1, 1, 3, 4, 'A');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (2, 2, 2, 3, 3, 'C');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (3, 3, 3, 1, 6, 'B');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (4, 4, 4, 1, 2, 'B');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (5, 5, 5, 3, 4, 'A');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (6, 6, 6, 2, 2, 'A');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (7, 7, 7, 4, 2, 'C');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (8, 8, 8, 2, 3, 'C');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (9, 9, 9, 4, 3, 'B');
INSERT INTO class_advisor (advisor_id, staff_id, department_id, year, semester, section) VALUES (10, 10, 10, 4, 4, 'C');

-- ============================================================
-- 11. lab_assistant
-- ============================================================
CREATE TABLE lab_assistant (
assistant_id SERIAL PRIMARY KEY,
staff_id INT,
department_id INT,
lab_id INT,
qualification VARCHAR(100),
experience INT,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (1, 1, 1, 1, 'M.Tech', 12);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (2, 2, 2, 2, 'M.E', 7);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (3, 3, 3, 3, 'M.E', 8);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (4, 4, 4, 4, 'MCA', 8);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (5, 5, 5, 5, 'Ph.D', 4);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (6, 6, 6, 6, 'M.Tech', 2);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (7, 7, 7, 7, 'M.E', 1);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (8, 8, 8, 8, 'MCA', 9);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (9, 9, 9, 9, 'M.Tech', 10);
INSERT INTO lab_assistant (assistant_id, staff_id, department_id, lab_id, qualification, experience) VALUES (10, 10, 10, 10, 'M.Tech', 1);

-- ============================================================
-- 12. warden
-- ============================================================
CREATE TABLE warden (
warden_id SERIAL PRIMARY KEY,
staff_id INT,
hostel_id INT,
phone VARCHAR(20),
email VARCHAR(100),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (1, 1, 1, '5271774490', 'warden1@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (2, 2, 2, '7700541199', 'warden2@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (3, 3, 3, '7935978207', 'warden3@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (4, 4, 4, '0377889255', 'warden4@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (5, 5, 5, '9051518644', 'warden5@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (6, 6, 6, '9254629148', 'warden6@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (7, 7, 7, '6850542357', 'warden7@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (8, 8, 8, '1418880592', 'warden8@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (9, 9, 9, '2927065379', 'warden9@college.edu');
INSERT INTO warden (warden_id, staff_id, hostel_id, phone, email) VALUES (10, 10, 10, '4735977468', 'warden10@college.edu');

-- ============================================================
-- 13. library_staff
-- ============================================================
CREATE TABLE library_staff (
library_staff_id SERIAL PRIMARY KEY,
staff_id INT,
designation VARCHAR(50),
shift VARCHAR(20),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (1, 1, 'Assistant Librarian', 'Morning');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (2, 2, 'Assistant Librarian', 'Morning');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (3, 3, 'Assistant Librarian', 'Evening');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (4, 4, 'Assistant Librarian', 'Morning');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (5, 5, 'Library Clerk', 'Evening');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (6, 6, 'Assistant Librarian', 'Morning');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (7, 7, 'Library Clerk', 'Morning');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (8, 8, 'Library Clerk', 'Evening');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (9, 9, 'Assistant Librarian', 'Morning');
INSERT INTO library_staff (library_staff_id, staff_id, designation, shift) VALUES (10, 10, 'Assistant Librarian', 'Evening');

-- ============================================================
-- 14. librarian
-- ============================================================
CREATE TABLE librarian (
librarian_id SERIAL PRIMARY KEY,
staff_id INT,
qualification VARCHAR(100),
experience INT,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (1, 1, 'B.Lib', 14);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (2, 2, 'B.Lib', 15);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (3, 3, 'MLISc', 2);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (4, 4, 'MLISc', 4);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (5, 5, 'M.Lib', 13);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (6, 6, 'MLISc', 11);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (7, 7, 'M.Lib', 8);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (8, 8, 'M.Lib', 7);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (9, 9, 'MLISc', 15);
INSERT INTO librarian (librarian_id, staff_id, qualification, experience) VALUES (10, 10, 'M.Lib', 14);

-- ============================================================
-- 15. library_books
-- ============================================================
CREATE TABLE library_books (
book_id SERIAL PRIMARY KEY,
isbn VARCHAR(20) UNIQUE,
title VARCHAR(200),
author VARCHAR(150),
publisher VARCHAR(100),
edition VARCHAR(20),
category VARCHAR(50),
rack_no VARCHAR(20),
floor_location VARCHAR(30),
shelf_location VARCHAR(20),
total_copies INT,
available_copies INT,
status VARCHAR(20)
);
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (1, '978-0486457741', '1800 Mechanical Movements, Devices and Appliances', 'Gardner D. Hiscox', 'Dover Publications', '1st Edition', 'Mechanical Engineering', 'Rack M-04', 'Floor 2', 'Shelf B', 5, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (2, '978-1556179426', '71 Best Control System Books Technical Reference', 'ISA Technical Reference', 'ISA Society', '1st Edition', 'Control Systems', 'Rack C-02', 'Floor 3', 'Shelf A', 4, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (3, '978-0201361186', 'Algorithms in C++ Part 5: Graph Algorithms', 'Robert Sedgewick', 'Addison-Wesley', '3rd Edition', 'Computer Science', 'Rack CS-01', 'Floor 1', 'Shelf C', 8, 6, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (4, '978-1590599914', 'Beginning Ubuntu Linux: From Novice to Professional', 'Keir Thomas & Andy Channelle', 'Apress', '5th Edition', 'Computer Science', 'Rack CS-05', 'Floor 1', 'Shelf A', 6, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (5, '978-0596002220', 'Building Embedded Linux Systems', 'Karim Yaghmour', 'O''Reilly Media', '2nd Edition', 'Embedded Systems', 'Rack EC-03', 'Floor 2', 'Shelf D', 4, 2, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (6, '978-1533612052', 'C Programming Language: Step by Step Guide', 'Darrell L. Graham', 'CreateSpace', '2nd Edition', 'Programming', 'Rack CS-01', 'Floor 1', 'Shelf A', 10, 8, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (7, '978-3030823405', 'Cognitive Dependability Engineering', 'Peter L. Jackson', 'Springer', '1st Edition', 'Cyber-Physical Systems', 'Rack AI-02', 'Floor 3', 'Shelf B', 3, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (8, '978-1780173641', 'Computational Thinking: A Beginner''s Guide', 'Karl Beecher', 'BCS Publishing', '1st Edition', 'Computer Science', 'Rack CS-02', 'Floor 1', 'Shelf B', 7, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (9, '978-0123944245', 'Computer Architecture: Digital Circuits to Systems', 'David Harris & Sarah Harris', 'Morgan Kaufmann', '2nd Edition', 'Hardware', 'Rack EC-01', 'Floor 2', 'Shelf C', 6, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (10, '978-1936007837', 'Control Systems Engineer Technical Reference Handbook', 'ISA Society', 'ISA Press', '2nd Edition', 'Control Systems', 'Rack C-01', 'Floor 3', 'Shelf D', 5, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (11, '978-1119534723', 'Control of Mechatronic Systems: Model-Driven Design', 'Patrick O. J. Kaltjob', 'Wiley', '1st Edition', 'Mechatronics', 'Rack M-05', 'Floor 3', 'Shelf A', 4, 2, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (12, '978-0241515907', 'Dominic Chinea Machines: A Visual History', 'Dominic Chinea', 'Penguin Books', '1st Edition', 'Mechanical Engineering', 'Rack M-02', 'Floor 2', 'Shelf C', 3, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (13, '978-0486497396', 'Modern Mathematics for the Engineer', 'Edwin F. Beckenbach', 'Dover Publications', '2nd Edition', 'Mathematics', 'Rack MA-01', 'Floor 1', 'Shelf B', 8, 7, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (14, '978-0071830805', 'Engineering Calculation Pocket Book', 'Tyler G. Hicks', 'McGraw-Hill', '6th Edition', 'Engineering Reference', 'Rack GEN-01', 'Floor 1', 'Shelf A', 12, 9, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (15, '978-8121923767', 'Engineering Physics Complete Notes & Handbook', 'Dr. A. S. Vasudeva', 'S. Chand Publishing', '1st Edition', 'Physics', 'Rack PH-01', 'Floor 1', 'Shelf D', 15, 11, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (16, '978-1491920947', 'Essential Cybersecurity Science', 'Josiah Dykstra', 'O''Reilly Media', '1st Edition', 'Cybersecurity', 'Rack SEC-01', 'Floor 3', 'Shelf A', 5, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (17, '978-0201615623', 'Exceptional C++: 47 Engineering Puzzles & Solutions', 'Herb Sutter', 'Addison-Wesley', '1st Edition', 'Programming', 'Rack CS-03', 'Floor 1', 'Shelf B', 6, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (18, '978-1499369069', 'Fundamentals of Aerospace Engineering', 'Manuel Soler', 'CreateSpace', '1st Edition', 'Aerospace', 'Rack AERO-01', 'Floor 2', 'Shelf C', 4, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (19, '978-1541019058', 'How To Train Your Thinking: Sharpen Your Mind', 'R. L. Adams', 'CreateSpace', '2nd Edition', 'General Reading', 'Rack GEN-03', 'Floor 1', 'Shelf A', 5, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (20, '978-0525537571', 'How to Build Impossible Things', 'Mark Miodownik', 'Viking Press', '1st Edition', 'Innovation & Design', 'Rack DES-01', 'Floor 1', 'Shelf B', 4, 2, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (21, '978-1848215160', 'Interdisciplinary Mechatronics & Systems', 'M. K. Habib', 'Wiley-ISTE', '1st Edition', 'Mechatronics', 'Rack M-04', 'Floor 3', 'Shelf C', 3, 2, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (22, '978-1605099255', 'Learning Systems Thinking', 'Diana Wright', 'Berrett-Koehler', '1st Edition', 'Systems Engineering', 'Rack SYS-01', 'Floor 3', 'Shelf A', 7, 6, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (23, '978-1119578888', 'Linux Bible: The Comprehensive Tutorial', 'Christopher Negus', 'Wiley', '10th Edition', 'Operating Systems', 'Rack OS-01', 'Floor 1', 'Shelf A', 9, 7, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (24, '978-1496145055', 'Linux for Beginners: Quick Command Line', 'Jason Cannon', 'CreateSpace', '1st Edition', 'Operating Systems', 'Rack OS-02', 'Floor 1', 'Shelf B', 12, 10, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (25, '978-0136156734', 'Modern Control Engineering 5th Edition', 'Katsuhiko Ogata', 'Pearson', '5th Edition', 'Control Systems', 'Rack C-03', 'Floor 3', 'Shelf D', 8, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (26, '978-1478639206', 'Air Pollution Control Engineering', 'Noel de Nevers', 'Waveland Press', '3rd Edition', 'Environmental', 'Rack ENV-01', 'Floor 2', 'Shelf B', 4, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (27, '978-1846286414', 'Robotics: Modelling, Planning and Control', 'Bruno Siciliano et al.', 'Springer', '2nd Edition', 'Robotics', 'Rack ROB-01', 'Floor 3', 'Shelf A', 6, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (28, '978-1259859786', 'Robots and Robotics: Principles and Applications', 'Mark R. Miller', 'McGraw-Hill', '1st Edition', 'Robotics', 'Rack ROB-02', 'Floor 3', 'Shelf C', 5, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (29, '978-1517300760', 'Shell Scripting: Automate Command Line Tasks', 'Jason Cannon', 'CreateSpace', '1st Edition', 'Operating Systems', 'Rack OS-03', 'Floor 1', 'Shelf A', 7, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (30, '978-3319297620', 'Structural Dynamics: Volume 50', 'Peretz P. Friedmann et al.', 'Springer', '1st Edition', 'Civil Engineering', 'Rack CIV-01', 'Floor 2', 'Shelf D', 3, 2, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (31, '978-1848000698', 'The Algorithm Design Manual', 'Steven S. Skiena', 'Springer', '2nd Edition', 'Algorithms', 'Rack CS-04', 'Floor 1', 'Shelf A', 10, 8, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (32, '978-0486217093', 'The Book of Basic Machines', 'U.S. Navy Bureau of Personnel', 'Dover Publications', '1st Edition', 'Mechanical Engineering', 'Rack M-01', 'Floor 2', 'Shelf B', 6, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (33, '978-0735216105', 'The Physics of Everyday Things', 'James Kakalios', 'Broadway Books', '1st Edition', 'Physics', 'Rack PH-02', 'Floor 1', 'Shelf C', 5, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (34, '978-1482824247', 'Think Like An Engineer', 'Mushtak Al-Atabi', 'CreateSpace', '1st Edition', 'General Engineering', 'Rack GEN-02', 'Floor 1', 'Shelf B', 8, 6, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (35, '978-1794501234', 'Thinking in Algorithms', 'Rutherford Birchard', 'CreateSpace', '1st Edition', 'Algorithms', 'Rack CS-04', 'Floor 1', 'Shelf B', 7, 6, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (36, '978-0750686273', 'Analog Circuits (World Class Designs)', 'Robert A. Pease', 'Newnes', '1st Edition', 'Electronics', 'Rack EC-04', 'Floor 2', 'Shelf A', 5, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (37, '978-1441917492', 'Theory of Applied Robotics: Kinematics & Control', 'Reza N. Jazar', 'Springer', '2nd Edition', 'Robotics', 'Rack ROB-03', 'Floor 3', 'Shelf B', 4, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (38, '978-0872638525', 'Manufacturing Engineering Special Edition', 'SME Society', 'SME Press', '1st Edition', 'Manufacturing', 'Rack M-03', 'Floor 2', 'Shelf A', 4, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (39, '978-0001122334', 'Vintage Engineering Book Cover Reference', 'Classic Archive', 'Archive Press', '1st Edition', 'Design', 'Rack ART-01', 'Floor 1', 'Shelf C', 2, 2, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (40, '978-3030112234', 'Advanced Sensor Networks & Facility Management', 'Industrial IoT Group', 'Springer', '1st Edition', 'IoT & Sensors', 'Rack AI-03', 'Floor 3', 'Shelf C', 6, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (41, '978-0785123456', 'Stark Tech Advanced System Architecture', 'Anthony E. Stark', 'Marvel Tech Press', '1st Edition', 'Artificial Intelligence', 'Rack AI-01', 'Floor 3', 'Shelf A', 5, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (42, '978-9995012345', 'Keep Your Spirit: Mindset & Resilience', 'Muth Boravy', 'Inspire Books', '1st Edition', 'General Reading', 'Rack GEN-04', 'Floor 1', 'Shelf D', 4, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (43, '978-1234567890', 'Christmas System UI & App Icon Engineering', 'Creative Tech Guild', 'Tech Press', '1st Edition', 'UI/UX Design', 'Rack DES-02', 'Floor 1', 'Shelf A', 3, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (44, '978-0262035613', 'Deep Learning Foundations', 'Ian Goodfellow et al.', 'MIT Press', '1st Edition', 'Artificial Intelligence', 'Rack AI-02', 'Floor 3', 'Shelf D', 6, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (45, '978-1107002173', 'Quantum Computing for Engineers', 'Nielsen & Chuang', 'Cambridge Press', '1st Edition', 'Computer Science', 'Rack CS-06', 'Floor 1', 'Shelf A', 5, 3, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (46, '978-1118876138', 'Data Science & Big Data Analytics', 'EMC Education Services', 'Wiley', '1st Edition', 'Data Science', 'Rack DS-01', 'Floor 1', 'Shelf B', 8, 6, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (47, '978-0072460704', 'VLSI Circuit Design Fundamentals', 'Sung-Mo Kang', 'McGraw-Hill', '2nd Edition', 'Electronics', 'Rack EC-02', 'Floor 2', 'Shelf C', 7, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (48, '978-0138147570', 'Signals and Systems 2nd Edition', 'Alan V. Oppenheim', 'Pearson', '2nd Edition', 'Electronics', 'Rack EC-01', 'Floor 2', 'Shelf B', 10, 8, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (49, '978-0078022159', 'Database System Concepts 7th Edition', 'Silberschatz, Korth & Sudarshan', 'McGraw-Hill', '7th Edition', 'Computer Science', 'Rack CS-02', 'Floor 1', 'Shelf D', 12, 9, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (50, '978-0123850591', 'Computer Networks: System Approach', 'Larry L. Peterson', 'Morgan Kaufmann', '5th Edition', 'Networking', 'Rack NET-01', 'Floor 1', 'Shelf A', 9, 7, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (51, '978-0133356724', 'Digital Image Processing 4th Edition', 'Rafael C. Gonzalez', 'Pearson', '4th Edition', 'Computer Science', 'Rack AI-04', 'Floor 3', 'Shelf B', 6, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (52, '978-1118063330', 'Operating System Concepts 10th Edition', 'Silberschatz & Galvin', 'Wiley', '10th Edition', 'Operating Systems', 'Rack OS-01', 'Floor 1', 'Shelf C', 14, 11, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (53, '978-8131808047', 'Thermal Engineering & Thermodynamics', 'R. K. Rajput', 'Laxmi Publications', '1st Edition', 'Mechanical Engineering', 'Rack M-01', 'Floor 2', 'Shelf D', 8, 6, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (54, '978-0199545339', 'Renewable Energy Technology & Power', 'Godfrey Boyle', 'Oxford Press', '2nd Edition', 'Electrical Engineering', 'Rack EE-02', 'Floor 2', 'Shelf A', 5, 4, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (55, '978-0133125900', 'Power Electronics: Circuits & Devices', 'Muhammad H. Rashid', 'Pearson', '4th Edition', 'Electrical Engineering', 'Rack EE-01', 'Floor 2', 'Shelf C', 7, 5, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (56, '978-0134610992', 'Artificial Intelligence: Modern Approach', 'Stuart Russell & Peter Norvig', 'Pearson', '4th Edition', 'Artificial Intelligence', 'Rack AI-01', 'Floor 3', 'Shelf A', 15, 12, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (57, '978-0262035614', 'Deep Learning Foundations & Applications', 'Ian Goodfellow & Yoshua Bengio', 'MIT Press', '1st Edition', 'Artificial Intelligence', 'Rack AI-02', 'Floor 3', 'Shelf B', 11, 9, 'Available');
INSERT INTO library_books (book_id, isbn, title, author, publisher, edition, category, rack_no, floor_location, shelf_location, total_copies, available_copies, status) VALUES (58, '978-0000001122', 'Special Collections Reference', 'Saranathan Central Library', 'College Press', '1st Edition', 'General Engineering', 'Rack REF-01', 'Floor 1', 'Shelf A', 4, 3, 'Available');

-- ============================================================
-- 16. library_issue
-- ============================================================
CREATE TABLE library_issue (
issue_id SERIAL PRIMARY KEY,
book_id INT,
student_id INT,
issue_date DATE,
due_date DATE,
return_date DATE,
fine DECIMAL(8,2),
status VARCHAR(20),
FOREIGN KEY (book_id) REFERENCES library_books(book_id),
FOREIGN KEY (student_id) REFERENCES students(student_id)
);
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (1, 1, 1, '2026-06-26', '2026-07-10', '2026-07-07', 0.0, 'Returned');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (2, 2, 2, '2026-05-23', '2026-06-06', '2026-06-05', 0.0, 'Returned');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (3, 3, 3, '2026-06-14', '2026-06-28', '2026-06-26', 0.0, 'Returned');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (4, 4, 4, '2026-06-03', '2026-06-17', '2026-06-20', 5.99, 'Returned');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (5, 5, 5, '2026-06-21', '2026-07-05', '2026-07-02', 0.0, 'Returned');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (6, 6, 6, '2026-06-16', '2026-06-30', '2026-07-03', 32.87, 'Returned');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (7, 7, 7, '2026-06-27', '2026-07-11', NULL, 0.0, 'Issued');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (8, 8, 8, '2026-05-25', '2026-06-08', NULL, 0.0, 'Issued');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (9, 9, 9, '2026-06-13', '2026-06-27', '2026-06-29', 11.93, 'Returned');
INSERT INTO library_issue (issue_id, book_id, student_id, issue_date, due_date, return_date, fine, status) VALUES (10, 10, 10, '2026-06-20', '2026-07-04', NULL, 0.0, 'Issued');

-- ============================================================
-- 17. library_fine
-- ============================================================
CREATE TABLE library_fine (
fine_id SERIAL PRIMARY KEY,
student_id INT,
issue_id INT,
amount DECIMAL(8,2),
paid_status VARCHAR(20),
paid_date DATE,
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (issue_id) REFERENCES library_issue(issue_id)
);
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (1, 1, 1, 35.23, 'Paid', '2026-01-07');
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (2, 2, 2, 25.58, 'Unpaid', NULL);
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (3, 3, 3, 5.42, 'Paid', '2026-01-14');
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (4, 4, 4, 8.3, 'Paid', '2026-06-04');
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (5, 5, 5, 27.76, 'Paid', '2026-03-14');
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (6, 6, 6, 47.0, 'Paid', '2026-03-18');
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (7, 7, 7, 44.57, 'Paid', '2026-04-23');
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (8, 8, 8, 17.82, 'Unpaid', NULL);
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (9, 9, 9, 42.52, 'Unpaid', NULL);
INSERT INTO library_fine (fine_id, student_id, issue_id, amount, paid_status, paid_date) VALUES (10, 10, 10, 32.53, 'Unpaid', NULL);

-- ============================================================
-- 18. hostel
-- ============================================================
CREATE TABLE hostel (
hostel_id SERIAL PRIMARY KEY,
hostel_name VARCHAR(100),
type VARCHAR(20),
capacity INT,
address VARCHAR(255),
warden_id INT
);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (1, 'Girls Hostel 1', 'Girls', 267, '755 Hines Ports', 1);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (2, 'Boys Hostel 2', 'Bo
