-- ============================================================
-- College Management System - PostgreSQL Schema + Sample Data
-- 55 tables, 10 sample records each (550 rows total)
-- Compatible with Supabase / any PostgreSQL 14+
-- ============================================================

-- ============================================================
-- College Management System - SQLite Schema + Sample Data
-- 55 tables, 10 sample records each (550 rows total)
-- Compatible with better-sqlite3 / sqlite3 (Node.js/Express)
-- ============================================================
DROP TABLE IF EXISTS departments CASCADE;
CREATE TABLE departments (
department_id SERIAL PRIMARY KEY,
department_name VARCHAR(100) NOT NULL,
department_code VARCHAR(20) NOT NULL UNIQUE,
hod_id INT NULL,
office_location VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(20)
);

-- Data for departments
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

DROP TABLE IF EXISTS courses CASCADE;
CREATE TABLE courses (
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(100) NOT NULL,
degree VARCHAR(50),
duration VARCHAR(20),
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Data for courses
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

DROP TABLE IF EXISTS students CASCADE;
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

-- Data for students
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

DROP TABLE IF EXISTS student_login CASCADE;
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

-- Data for student_login
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

DROP TABLE IF EXISTS staff CASCADE;
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

-- Data for staff
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

DROP TABLE IF EXISTS staff_login CASCADE;
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

-- Data for staff_login
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

DROP TABLE IF EXISTS admin_login CASCADE;
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

-- Data for admin_login
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

DROP TABLE IF EXISTS faculty CASCADE;
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

-- Data for faculty
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

DROP TABLE IF EXISTS hod CASCADE;
CREATE TABLE hod (
hod_id SERIAL PRIMARY KEY,
staff_id INT,
department_id INT,
start_date DATE,
end_date DATE,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Data for hod
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

DROP TABLE IF EXISTS class_advisor CASCADE;
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

-- Data for class_advisor
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

DROP TABLE IF EXISTS lab_assistant CASCADE;
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

-- Data for lab_assistant
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

DROP TABLE IF EXISTS warden CASCADE;
CREATE TABLE warden (
warden_id SERIAL PRIMARY KEY,
staff_id INT,
hostel_id INT,
phone VARCHAR(20),
email VARCHAR(100),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Data for warden
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

DROP TABLE IF EXISTS library_staff CASCADE;
CREATE TABLE library_staff (
library_staff_id SERIAL PRIMARY KEY,
staff_id INT,
designation VARCHAR(50),
shift VARCHAR(20),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Data for library_staff
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

DROP TABLE IF EXISTS librarian CASCADE;
CREATE TABLE librarian (
librarian_id SERIAL PRIMARY KEY,
staff_id INT,
qualification VARCHAR(100),
experience INT,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Data for librarian
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

DROP TABLE IF EXISTS library_books CASCADE;
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

-- Data for library_books (58 books from BOOKS_CATALOG)
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

DROP TABLE IF EXISTS library_issue CASCADE;
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

-- Data for library_issue
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

DROP TABLE IF EXISTS library_fine CASCADE;
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

-- Data for library_fine
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

DROP TABLE IF EXISTS hostel CASCADE;
CREATE TABLE hostel (
hostel_id SERIAL PRIMARY KEY,
hostel_name VARCHAR(100),
type VARCHAR(20),
capacity INT,
address VARCHAR(255),
warden_id INT
);

-- Data for hostel
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (1, 'Girls Hostel 1', 'Girls', 267, '755 Hines Ports', 1);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (2, 'Boys Hostel 2', 'Boys', 235, '565 Wright Crescent', 2);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (3, 'Girls Hostel 3', 'Girls', 102, '278 Mcintyre Crest', 3);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (4, 'Boys Hostel 4', 'Boys', 270, '7394 Gonzalez Dale Apt. 727', 4);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (5, 'Girls Hostel 5', 'Girls', 241, '551 Vance Vista', 5);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (6, 'Boys Hostel 6', 'Boys', 176, '258 David Flats', 6);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (7, 'Girls Hostel 7', 'Girls', 269, '70589 Mcdonald Plaza', 7);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (8, 'Boys Hostel 8', 'Boys', 126, '114 Key Stravenue', 8);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (9, 'Girls Hostel 9', 'Girls', 134, '669 David Island Apt. 778', 9);
INSERT INTO hostel (hostel_id, hostel_name, type, capacity, address, warden_id) VALUES (10, 'Boys Hostel 10', 'Boys', 167, '89226 Marie Path Apt. 422', 10);

DROP TABLE IF EXISTS hostel_rooms CASCADE;
CREATE TABLE hostel_rooms (
room_id SERIAL PRIMARY KEY,
hostel_id INT,
room_number VARCHAR(20),
floor INT,
capacity INT,
occupied INT,
status VARCHAR(20),
FOREIGN KEY (hostel_id) REFERENCES hostel(hostel_id)
);

-- Data for hostel_rooms
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (1, 1, '201', 3, 2, 0, 'Available');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (2, 2, '302', 2, 3, 1, 'Available');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (3, 3, '403', 3, 4, 2, 'Available');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (4, 4, '404', 3, 2, 0, 'Available');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (5, 5, '305', 2, 2, 0, 'Available');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (6, 6, '206', 4, 4, 2, 'Available');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (7, 7, '107', 1, 4, 3, 'Available');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (8, 8, '208', 1, 2, 2, 'Full');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (9, 9, '409', 2, 3, 1, 'Available');
INSERT INTO hostel_rooms (room_id, hostel_id, room_number, floor, capacity, occupied, status) VALUES (10, 10, '310', 1, 2, 1, 'Available');

DROP TABLE IF EXISTS hostel_students CASCADE;
CREATE TABLE hostel_students (
allocation_id SERIAL PRIMARY KEY,
student_id INT,
hostel_id INT,
room_id INT,
admission_date DATE,
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (hostel_id) REFERENCES hostel(hostel_id),
FOREIGN KEY (room_id) REFERENCES hostel_rooms(room_id)
);

-- Data for hostel_students
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (1, 1, 1, 1, '2025-03-10');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (2, 2, 2, 2, '2025-12-17');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (3, 3, 3, 3, '2025-03-27');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (4, 4, 4, 4, '2026-06-04');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (5, 5, 5, 5, '2026-05-02');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (6, 6, 6, 6, '2026-03-27');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (7, 7, 7, 7, '2025-01-16');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (8, 8, 8, 8, '2025-10-24');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (9, 9, 9, 9, '2025-08-24');
INSERT INTO hostel_students (allocation_id, student_id, hostel_id, room_id, admission_date) VALUES (10, 10, 10, 10, '2024-10-17');

DROP TABLE IF EXISTS bus_routes CASCADE;
CREATE TABLE bus_routes (
route_id SERIAL PRIMARY KEY,
route_name VARCHAR(100),
route_number VARCHAR(20),
start_point VARCHAR(100),
end_point VARCHAR(100),
distance DECIMAL(6,2),
driver_id INT,
bus_id INT
);

-- Data for bus_routes
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (1, 'Route 1', 'R1', 'Christinaland', 'College Campus', 36.46, 1, 1);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (2, 'Route 2', 'R2', 'New Shelly', 'College Campus', 12.35, 2, 2);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (3, 'Route 3', 'R3', 'East Donna', 'College Campus', 13.73, 3, 3);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (4, 'Route 4', 'R4', 'Meganshire', 'College Campus', 8.6, 4, 4);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (5, 'Route 5', 'R5', 'Port Michelleland', 'College Campus', 32.3, 5, 5);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (6, 'Route 6', 'R6', 'Lake Kelliview', 'College Campus', 35.94, 6, 6);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (7, 'Route 7', 'R7', 'Port Ashley', 'College Campus', 19.22, 7, 7);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (8, 'Route 8', 'R8', 'South Pamelaside', 'College Campus', 26.72, 8, 8);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (9, 'Route 9', 'R9', 'Dawnport', 'College Campus', 10.41, 9, 9);
INSERT INTO bus_routes (route_id, route_name, route_number, start_point, end_point, distance, driver_id, bus_id) VALUES (10, 'Route 10', 'R10', 'Sanchezfurt', 'College Campus', 37.55, 10, 10);

DROP TABLE IF EXISTS bus CASCADE;
CREATE TABLE bus (
bus_id SERIAL PRIMARY KEY,
bus_number VARCHAR(20),
registration_number VARCHAR(30) UNIQUE,
capacity INT,
driver_name VARCHAR(100),
driver_phone VARCHAR(20),
route_id INT,
FOREIGN KEY (route_id) REFERENCES bus_routes(route_id)
);

-- Data for bus
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (1, 'BUS-1', 'TN37AB1001', 40, 'Benjamin Brown', '6773592555', 1);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (2, 'BUS-2', 'TN37AB1002', 40, 'Brian Allen', '4732104696', 2);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (3, 'BUS-3', 'TN37AB1003', 50, 'Nathan Lee', '7877470168', 3);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (4, 'BUS-4', 'TN37AB1004', 40, 'Anthony Campbell', '4801624565', 4);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (5, 'BUS-5', 'TN37AB1005', 40, 'Cory Tran', '6878499121', 5);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (6, 'BUS-6', 'TN37AB1006', 60, 'Jacob Thomas', '8000257872', 6);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (7, 'BUS-7', 'TN37AB1007', 50, 'Louis Martin', '9588879470', 7);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (8, 'BUS-8', 'TN37AB1008', 50, 'Kevin Robles DDS', '9749930972', 8);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (9, 'BUS-9', 'TN37AB1009', 60, 'Michael Johnson', '3075626368', 9);
INSERT INTO bus (bus_id, bus_number, registration_number, capacity, driver_name, driver_phone, route_id) VALUES (10, 'BUS-10', 'TN37AB1010', 60, 'Joseph Hoffman', '8652785854', 10);

DROP TABLE IF EXISTS bus_students CASCADE;
CREATE TABLE bus_students (
bus_student_id SERIAL PRIMARY KEY,
student_id INT,
route_id INT,
pickup_point VARCHAR(100),
fee_status VARCHAR(20),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (route_id) REFERENCES bus_routes(route_id)
);

-- Data for bus_students
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (1, 1, 1, 'Joshua Hills', 'Paid');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (2, 2, 2, 'Shelly Hills', 'Pending');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (3, 3, 3, 'Bush Spurs', 'Paid');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (4, 4, 4, 'Stewart Keys', 'Paid');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (5, 5, 5, 'Roberts Ports', 'Pending');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (6, 6, 6, 'Huang Locks', 'Paid');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (7, 7, 7, 'Blevins Unions', 'Pending');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (8, 8, 8, 'Kelly Heights', 'Paid');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (9, 9, 9, 'Michael Mills', 'Paid');
INSERT INTO bus_students (bus_student_id, student_id, route_id, pickup_point, fee_status) VALUES (10, 10, 10, 'Burgess Forest', 'Pending');

DROP TABLE IF EXISTS subjects CASCADE;
CREATE TABLE subjects (
subject_id SERIAL PRIMARY KEY,
subject_code VARCHAR(20) UNIQUE,
subject_name VARCHAR(100),
department_id INT,
semester INT,
credits INT,
type VARCHAR(20),
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Data for subjects
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (1, 'SUB101', 'Data Structures', 1, 3, 4, 'Theory');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (2, 'SUB102', 'Digital Logic Design', 2, 2, 3, 'Theory');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (3, 'SUB103', 'Engineering Thermodynamics', 3, 4, 4, 'Lab');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (4, 'SUB104', 'Structural Mechanics', 4, 1, 4, 'Lab');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (5, 'SUB105', 'Power System Analysis', 5, 6, 4, 'Lab');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (6, 'SUB106', 'Cloud Computing', 6, 1, 3, 'Lab');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (7, 'SUB107', 'Molecular Biology', 7, 2, 4, 'Theory');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (8, 'SUB108', 'Process Design', 8, 1, 4, 'Lab');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (9, 'SUB109', 'Discrete Mathematics', 9, 6, 4, 'Lab');
INSERT INTO subjects (subject_id, subject_code, subject_name, department_id, semester, credits, type) VALUES (10, 'SUB110', 'Quantum Mechanics', 10, 5, 3, 'Lab');

DROP TABLE IF EXISTS syllabus CASCADE;
CREATE TABLE syllabus (
syllabus_id SERIAL PRIMARY KEY,
subject_id INT,
unit_no INT,
unit_name VARCHAR(100),
topics TEXT,
reference_books TEXT,
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Data for syllabus
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (1, 1, 5, 'Unit 2: Exclusive national flexibility', 'Receive case past only drug prove most point appear including response beyond side.', 'Joshua Hickman - Investment Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (2, 2, 3, 'Unit 1: Streamlined methodical matrices', 'Sense expert experience arrive shoulder present discussion school.', 'Amanda Dorsey - Key Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (3, 3, 4, 'Unit 1: Enhanced 5thgeneration infrastructure', 'Control see the face also fear owner up friend lawyer political modern.', 'Brandi Gordon - Explain Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (4, 4, 5, 'Unit 5: Ergonomic bifurcated groupware', 'Room possible responsibility add front far purpose cover.', 'Margaret Sullivan - Late Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (5, 5, 2, 'Unit 3: Profound fresh-thinking array', 'Protect continue cell food easy end dog send west few reveal.', 'Matthew Schwartz - Assume Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (6, 6, 4, 'Unit 1: Synchronized bottom-line Local Area Network', 'Civil rather type thousand show real police wait happen.', 'Tyler Mendoza - Look Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (7, 7, 3, 'Unit 5: User-friendly real-time hub', 'Reduce tree serious soon stay seven quite other skin moment month.', 'Thomas Rodriguez - Them Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (8, 8, 3, 'Unit 1: Reactive motivating customer loyalty', 'Mr clearly take kind quite response major together knowledge argue car indeed nor.', 'Megan Parker - Age Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (9, 9, 3, 'Unit 5: Object-based eco-centric ability', 'Official and general as yes various attorney value.', 'Jason Mack - Space Publications');
INSERT INTO syllabus (syllabus_id, subject_id, unit_no, unit_name, topics, reference_books) VALUES (10, 10, 3, 'Unit 4: Stand-alone upward-trending project', 'Hear through large true help bag who themselves card team budget.', 'Jenna Anderson DVM - They Publications');

DROP TABLE IF EXISTS timetable CASCADE;
CREATE TABLE timetable (
timetable_id SERIAL PRIMARY KEY,
department_id INT,
year INT,
semester INT,
section VARCHAR(5),
day VARCHAR(15),
period INT,
subject_id INT,
faculty_id INT,
room_no VARCHAR(20),
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Data for timetable
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (1, 1, 3, 4, 'C', 'Tuesday', 3, 1, 1, 'Room-101');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (2, 2, 2, 2, 'B', 'Wednesday', 6, 2, 2, 'Room-102');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (3, 3, 4, 6, 'C', 'Thursday', 2, 3, 3, 'Room-103');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (4, 4, 3, 4, 'C', 'Friday', 7, 4, 4, 'Room-104');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (5, 5, 1, 3, 'B', 'Saturday', 2, 5, 5, 'Room-105');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (6, 6, 4, 5, 'C', 'Monday', 6, 6, 6, 'Room-106');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (7, 7, 3, 4, 'B', 'Tuesday', 4, 7, 7, 'Room-107');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (8, 8, 2, 5, 'B', 'Wednesday', 7, 8, 8, 'Room-108');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (9, 9, 2, 6, 'A', 'Thursday', 3, 9, 9, 'Room-109');
INSERT INTO timetable (timetable_id, department_id, year, semester, section, day, period, subject_id, faculty_id, room_no) VALUES (10, 10, 3, 1, 'A', 'Friday', 6, 10, 10, 'Room-110');

DROP TABLE IF EXISTS attendance CASCADE;
CREATE TABLE attendance (
attendance_id SERIAL PRIMARY KEY,
student_id INT,
subject_id INT,
faculty_id INT,
date DATE,
hour INT,
status VARCHAR(10),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Data for attendance
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (1, 1, 1, 1, '2026-06-19', 3, 'Present');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (2, 2, 2, 2, '2026-06-19', 7, 'Present');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (3, 3, 3, 3, '2026-06-27', 2, 'Present');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (4, 4, 4, 4, '2026-07-09', 1, 'Present');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (5, 5, 5, 5, '2026-07-05', 4, 'Present');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (6, 6, 6, 6, '2026-07-04', 4, 'Absent');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (7, 7, 7, 7, '2026-07-13', 6, 'Present');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (8, 8, 8, 8, '2026-06-26', 6, 'Absent');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (9, 9, 9, 9, '2026-06-29', 4, 'Absent');
INSERT INTO attendance (attendance_id, student_id, subject_id, faculty_id, date, hour, status) VALUES (10, 10, 10, 10, '2026-06-27', 2, 'Present');

DROP TABLE IF EXISTS internal_marks CASCADE;
CREATE TABLE internal_marks (
mark_id SERIAL PRIMARY KEY,
student_id INT,
subject_id INT,
ia1 DECIMAL(5,2),
ia2 DECIMAL(5,2),
model_exam DECIMAL(5,2),
assignment DECIMAL(5,2),
attendance_mark DECIMAL(5,2),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Data for internal_marks
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (1, 1, 1, 19.84, 10.08, 45.02, 8.85, 3.21);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (2, 2, 2, 16.38, 12.64, 49.16, 7.59, 3.1);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (3, 3, 3, 13.74, 22.73, 39.13, 9.01, 4.34);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (4, 4, 4, 24.82, 18.93, 49.0, 9.46, 4.23);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (5, 5, 5, 20.79, 17.57, 46.61, 7.74, 4.79);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (6, 6, 6, 21.15, 17.12, 35.18, 6.24, 4.28);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (7, 7, 7, 21.49, 17.82, 42.53, 6.37, 3.15);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (8, 8, 8, 14.29, 14.08, 36.39, 7.7, 3.28);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (9, 9, 9, 13.47, 20.41, 44.13, 5.32, 3.82);
INSERT INTO internal_marks (mark_id, student_id, subject_id, ia1, ia2, model_exam, assignment, attendance_mark) VALUES (10, 10, 10, 18.14, 16.24, 34.14, 7.1, 4.81);

DROP TABLE IF EXISTS semester_results CASCADE;
CREATE TABLE semester_results (
result_id SERIAL PRIMARY KEY,
student_id INT,
subject_id INT,
grade VARCHAR(5),
marks DECIMAL(5,2),
result VARCHAR(10),
cgpa DECIMAL(4,2),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Data for semester_results
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (1, 1, 1, 'C', 75.04, 'Pass', 6.07);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (2, 2, 2, 'B', 92.84, 'Pass', 7.33);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (3, 3, 3, 'A', 40.35, 'Pass', 7.05);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (4, 4, 4, 'B+', 63.4, 'Pass', 7.88);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (5, 5, 5, 'B', 84.08, 'Pass', 9.14);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (6, 6, 6, 'A', 69.29, 'Pass', 7.53);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (7, 7, 7, 'A', 41.74, 'Pass', 8.34);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (8, 8, 8, 'C', 87.89, 'Pass', 6.58);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (9, 9, 9, 'A+', 68.04, 'Pass', 9.43);
INSERT INTO semester_results (result_id, student_id, subject_id, grade, marks, result, cgpa) VALUES (10, 10, 10, 'B+', 72.05, 'Pass', 8.07);

DROP TABLE IF EXISTS assignments CASCADE;
CREATE TABLE assignments (
assignment_id SERIAL PRIMARY KEY,
subject_id INT,
faculty_id INT,
title VARCHAR(150),
description TEXT,
due_date DATE,
file VARCHAR(255),
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Data for assignments
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (1, 1, 1, 'Assignment 1: Up-sized well-modulated budgetary management', 'Special information she this administration deal beyond.', '2026-07-20', '/files/assignment_1.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (2, 2, 2, 'Assignment 2: Right-sized systematic strategy', 'Each analysis keep music senior simply cell.', '2026-08-17', '/files/assignment_2.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (3, 3, 3, 'Assignment 3: Focused upward-trending orchestration', 'Officer significant stand down then worry miss including every news option same.', '2026-07-24', '/files/assignment_3.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (4, 4, 4, 'Assignment 4: Synergistic interactive open architecture', 'Another general poor high modern recent impact feel contain Mrs drive different tax certain.', '2026-08-01', '/files/assignment_4.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (5, 5, 5, 'Assignment 5: Centralized next generation installation', 'Newspaper care drug data position two suggest begin right couple environmental purpose owner.', '2026-08-14', '/files/assignment_5.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (6, 6, 6, 'Assignment 6: Ergonomic well-modulated parallelism', 'Describe decade trade field training deep couple scientist section senior trial receive region however dream.', '2026-07-28', '/files/assignment_6.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (7, 7, 7, 'Assignment 7: Horizontal homogeneous Local Area Network', 'Possible final growth third letter sort reveal seven floor data fine animal ten scientist administration.', '2026-08-04', '/files/assignment_7.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (8, 8, 8, 'Assignment 8: Reduced optimal success', 'Far cultural discover now early nearly want front shake major rich science leave.', '2026-08-09', '/files/assignment_8.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (9, 9, 9, 'Assignment 9: Multi-channeled composite challenge', 'Major true my politics arrive almost suggest war property share include successful discuss religious across.', '2026-08-03', '/files/assignment_9.pdf');
INSERT INTO assignments (assignment_id, subject_id, faculty_id, title, description, due_date, file) VALUES (10, 10, 10, 'Assignment 10: Multi-layered analyzing process improvement', 'Tree process administration mother in admit reveal movie expert maybe recently issue vote conference truth modern.', '2026-07-26', '/files/assignment_10.pdf');

DROP TABLE IF EXISTS assignment_submission CASCADE;
CREATE TABLE assignment_submission (
submission_id SERIAL PRIMARY KEY,
assignment_id INT,
student_id INT,
submission_date DATE,
file VARCHAR(255),
marks DECIMAL(5,2),
remarks VARCHAR(255),
FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for assignment_submission
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (1, 1, 1, '2026-07-15', '/files/submission_1.pdf', 8.31, 'Good work');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (2, 2, 2, '2026-07-11', '/files/submission_2.pdf', 8.21, 'Needs improvement');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (3, 3, 3, '2026-07-12', '/files/submission_3.pdf', 9.33, 'Needs improvement');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (4, 4, 4, '2026-07-16', '/files/submission_4.pdf', 5.25, 'Late submission');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (5, 5, 5, '2026-07-09', '/files/submission_5.pdf', 6.64, 'Late submission');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (6, 6, 6, '2026-07-18', '/files/submission_6.pdf', 6.63, 'Late submission');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (7, 7, 7, '2026-07-13', '/files/submission_7.pdf', 6.39, 'Late submission');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (8, 8, 8, '2026-07-11', '/files/submission_8.pdf', 6.26, 'Good work');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (9, 9, 9, '2026-07-15', '/files/submission_9.pdf', 7.35, 'Good work');
INSERT INTO assignment_submission (submission_id, assignment_id, student_id, submission_date, file, marks, remarks) VALUES (10, 10, 10, '2026-07-11', '/files/submission_10.pdf', 10.0, 'Excellent');

DROP TABLE IF EXISTS notes CASCADE;
CREATE TABLE notes (
note_id SERIAL PRIMARY KEY,
subject_id INT,
faculty_id INT,
title VARCHAR(150),
file VARCHAR(255),
upload_date DATE,
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Data for notes
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (1, 1, 1, 'Data Structures - Unit 2 Notes', '/files/notes_1.pdf', '2026-07-03');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (2, 2, 2, 'Digital Logic Design - Unit 1 Notes', '/files/notes_2.pdf', '2026-04-27');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (3, 3, 3, 'Engineering Thermodynamics - Unit 1 Notes', '/files/notes_3.pdf', '2026-07-18');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (4, 4, 4, 'Structural Mechanics - Unit 1 Notes', '/files/notes_4.pdf', '2026-06-17');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (5, 5, 5, 'Power System Analysis - Unit 2 Notes', '/files/notes_5.pdf', '2026-04-22');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (6, 6, 6, 'Cloud Computing - Unit 2 Notes', '/files/notes_6.pdf', '2026-05-26');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (7, 7, 7, 'Molecular Biology - Unit 1 Notes', '/files/notes_7.pdf', '2026-05-23');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (8, 8, 8, 'Process Design - Unit 5 Notes', '/files/notes_8.pdf', '2026-06-01');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (9, 9, 9, 'Discrete Mathematics - Unit 2 Notes', '/files/notes_9.pdf', '2026-06-16');
INSERT INTO notes (note_id, subject_id, faculty_id, title, file, upload_date) VALUES (10, 10, 10, 'Quantum Mechanics - Unit 2 Notes', '/files/notes_10.pdf', '2026-06-22');

DROP TABLE IF EXISTS previous_question_papers CASCADE;
CREATE TABLE previous_question_papers (
paper_id SERIAL PRIMARY KEY,
subject_id INT,
year INT,
semester INT,
exam_type VARCHAR(30),
file VARCHAR(255),
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Data for previous_question_papers
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (1, 1, 2022, 4, 'Model Exam', '/files/qp_1.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (2, 2, 2022, 4, 'IA1', '/files/qp_2.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (3, 3, 2023, 2, 'Model Exam', '/files/qp_3.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (4, 4, 2022, 3, 'Model Exam', '/files/qp_4.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (5, 5, 2021, 3, 'IA2', '/files/qp_5.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (6, 6, 2024, 6, 'Semester Exam', '/files/qp_6.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (7, 7, 2021, 5, 'Semester Exam', '/files/qp_7.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (8, 8, 2021, 6, 'IA1', '/files/qp_8.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (9, 9, 2021, 5, 'Model Exam', '/files/qp_9.pdf');
INSERT INTO previous_question_papers (paper_id, subject_id, year, semester, exam_type, file) VALUES (10, 10, 2023, 5, 'IA2', '/files/qp_10.pdf');

DROP TABLE IF EXISTS events CASCADE;
CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title VARCHAR(150),
description TEXT,
venue VARCHAR(100),
date DATE,
time TIME,
organizer VARCHAR(100),
registration_link VARCHAR(255),
poster VARCHAR(255)
);

-- Data for events
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (1, 'Tech Symposium', 'Matter its six not teach believe month.', 'Main Auditorium', '2026-07-21', '12:51:16', 'Clay, Alvarez and Williams', 'https://college.edu/events/1', '/posters/event_1.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (2, 'Cultural Fest', 'Range exactly myself probably conference sure.', 'Main Auditorium', '2026-07-19', '13:44:59', 'Goodwin Ltd', 'https://college.edu/events/2', '/posters/event_2.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (3, 'Sports Meet', 'Up federal nor note support quality music himself science so ready.', 'Main Auditorium', '2026-07-23', '09:43:13', 'Brown-Kim', 'https://college.edu/events/3', '/posters/event_3.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (4, 'Hackathon', 'Future shoulder western however similar ahead.', 'Main Auditorium', '2026-08-04', '12:42:25', 'Perez-Tran', 'https://college.edu/events/4', '/posters/event_4.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (5, 'Alumni Meet', 'It quickly produce beat peace something require bank child Republican.', 'Main Auditorium', '2026-08-26', '14:06:01', 'Ward-Davis', 'https://college.edu/events/5', '/posters/event_5.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (6, 'Workshop on AI', 'Know seven bill beautiful issue news mention billion bed.', 'Main Auditorium', '2026-08-21', '16:13:03', 'Shields-Smith', 'https://college.edu/events/6', '/posters/event_6.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (7, 'National Conference', 'Hold be top toward within occur college herself catch feeling manage.', 'Main Auditorium', '2026-07-22', '15:43:19', 'Evans-Patton', 'https://college.edu/events/7', '/posters/event_7.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (8, 'Freshers Day', 'Edge east person order crime blood fight we forward per.', 'Main Auditorium', '2026-09-05', '05:48:26', 'Jordan-Colon', 'https://college.edu/events/8', '/posters/event_8.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (9, 'Placement Drive', 'Carry fly water cut fire who why fact reason make office drug heavy.', 'Main Auditorium', '2026-09-05', '13:08:55', 'Frederick and Sons', 'https://college.edu/events/9', '/posters/event_9.jpg');
INSERT INTO events (event_id, title, description, venue, date, time, organizer, registration_link, poster) VALUES (10, 'Blood Donation Camp', 'Young conference should agree road wall decide something story attorney summer some pull.', 'Main Auditorium', '2026-07-27', '14:26:43', 'Hopkins-Espinoza', 'https://college.edu/events/10', '/posters/event_10.jpg');

DROP TABLE IF EXISTS clubs CASCADE;
CREATE TABLE clubs (
club_id SERIAL PRIMARY KEY,
club_name VARCHAR(100),
faculty_incharge INT,
description TEXT,
FOREIGN KEY (faculty_incharge) REFERENCES faculty(faculty_id)
);

-- Data for clubs
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (1, 'Coding Club', 1, 'Available wrong look husband media turn reality myself so growth time Mr.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (2, 'Robotics Club', 2, 'Body eat professor coach partner none population position.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (3, 'Music Club', 3, 'Whole involve action else member million oil offer knowledge hospital sign open.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (4, 'Dance Club', 4, 'Character young lot far turn beat story role give gas six miss give best.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (5, 'Photography Club', 5, 'Five feel special boy support possible quality clearly worker during company civil nice when.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (6, 'Literary Club', 6, 'Something picture control price how scene third last involve above.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (7, 'Entrepreneurship Cell', 7, 'Day sell speak artist big the cost for leader energy.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (8, 'Environment Club', 8, 'Month police others particularly only girl suddenly pay sport relationship father pass be care.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (9, 'Drama Club', 9, 'Draw bring health center home others offer institution main.');
INSERT INTO clubs (club_id, club_name, faculty_incharge, description) VALUES (10, 'Sports Club', 10, 'Really population yourself never majority cell fire late approach grow act carry spring white measure.');

DROP TABLE IF EXISTS club_members CASCADE;
CREATE TABLE club_members (
member_id SERIAL PRIMARY KEY,
club_id INT,
student_id INT,
position VARCHAR(50),
join_date DATE,
FOREIGN KEY (club_id) REFERENCES clubs(club_id),
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for club_members
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (1, 1, 1, 'President', '2025-07-14');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (2, 2, 2, 'Member', '2025-11-30');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (3, 3, 3, 'President', '2025-05-17');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (4, 4, 4, 'Member', '2026-03-23');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (5, 5, 5, 'Treasurer', '2025-07-10');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (6, 6, 6, 'Treasurer', '2024-09-16');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (7, 7, 7, 'Member', '2024-08-09');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (8, 8, 8, 'Treasurer', '2026-01-25');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (9, 9, 9, 'President', '2025-02-16');
INSERT INTO club_members (member_id, club_id, student_id, position, join_date) VALUES (10, 10, 10, 'Treasurer', '2025-02-03');

DROP TABLE IF EXISTS placements CASCADE;
CREATE TABLE placements (
placement_id SERIAL PRIMARY KEY,
company_name VARCHAR(100),
package DECIMAL(10,2),
drive_date DATE,
eligibility VARCHAR(150),
venue VARCHAR(100)
);

-- Data for placements
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (1, 'Roberts, Norman and Cunningham', 18.71, '2026-09-26', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (2, 'Dunn-Wilson', 12.86, '2026-07-29', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (3, 'Morrow, Richardson and Carson', 19.28, '2026-07-22', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (4, 'Alexander, Robinson and Coleman', 24.26, '2026-09-23', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (5, 'Potter, Evans and Kidd', 9.31, '2026-08-28', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (6, 'Atkins-Miller', 20.88, '2026-10-04', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (7, 'Rowe and Sons', 15.07, '2026-08-06', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (8, 'Matthews, Bell and Page', 13.9, '2026-09-13', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (9, 'Jensen and Sons', 12.86, '2026-09-30', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');
INSERT INTO placements (placement_id, company_name, package, drive_date, eligibility, venue) VALUES (10, 'Hudson PLC', 19.22, '2026-08-13', 'CGPA >= 7.0, No Backlogs', 'Placement Cell Auditorium');

DROP TABLE IF EXISTS placement_registration CASCADE;
CREATE TABLE placement_registration (
registration_id SERIAL PRIMARY KEY,
placement_id INT,
student_id INT,
status VARCHAR(20),
FOREIGN KEY (placement_id) REFERENCES placements(placement_id),
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for placement_registration
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (1, 1, 1, 'Selected');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (2, 2, 2, 'Selected');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (3, 3, 3, 'Shortlisted');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (4, 4, 4, 'Registered');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (5, 5, 5, 'Selected');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (6, 6, 6, 'Rejected');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (7, 7, 7, 'Shortlisted');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (8, 8, 8, 'Rejected');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (9, 9, 9, 'Rejected');
INSERT INTO placement_registration (registration_id, placement_id, student_id, status) VALUES (10, 10, 10, 'Selected');

DROP TABLE IF EXISTS fees CASCADE;
CREATE TABLE fees (
fee_id SERIAL PRIMARY KEY,
student_id INT,
fee_type VARCHAR(50),
amount DECIMAL(10,2),
paid DECIMAL(10,2),
payment_date DATE,
transaction_id VARCHAR(50),
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for fees
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (1, 1, 'Hostel Fee', 21722.0, 21722.0, '2026-04-18', 'TXN100001');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (2, 2, 'Bus Fee', 49253.0, 49253.0, '2026-03-06', 'TXN100002');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (3, 3, 'Bus Fee', 40420.33, 40420.33, '2026-05-21', 'TXN100003');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (4, 4, 'Hostel Fee', 53347.46, 53347.46, '2026-02-27', 'TXN100004');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (5, 5, 'Exam Fee', 25136.78, 25136.78, '2026-02-23', 'TXN100005');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (6, 6, 'Exam Fee', 53310.57, 31221.65, '2026-06-20', 'TXN100006');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (7, 7, 'Exam Fee', 46890.47, 22345.25, '2026-07-16', 'TXN100007');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (8, 8, 'Library Fee', 61507.23, 61507.23, '2026-05-16', 'TXN100008');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (9, 9, 'Bus Fee', 42141.23, 42141.23, '2026-01-19', 'TXN100009');
INSERT INTO fees (fee_id, student_id, fee_type, amount, paid, payment_date, transaction_id) VALUES (10, 10, 'Bus Fee', 45530.23, 45530.23, '2026-07-11', 'TXN100010');

DROP TABLE IF EXISTS scholarships CASCADE;
CREATE TABLE scholarships (
scholarship_id SERIAL PRIMARY KEY,
student_id INT,
name VARCHAR(100),
amount DECIMAL(10,2),
status VARCHAR(20),
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for scholarships
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (1, 1, 'Sports Scholarship', 36628.47, 'Pending');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (2, 2, 'Sports Scholarship', 16313.17, 'Approved');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (3, 3, 'State Government Scholarship', 19199.66, 'Rejected');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (4, 4, 'Need-Based Scholarship', 47789.49, 'Rejected');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (5, 5, 'State Government Scholarship', 13619.34, 'Rejected');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (6, 6, 'Minority Scholarship', 17442.48, 'Rejected');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (7, 7, 'Need-Based Scholarship', 31855.58, 'Approved');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (8, 8, 'State Government Scholarship', 18331.09, 'Pending');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (9, 9, 'State Government Scholarship', 18602.04, 'Rejected');
INSERT INTO scholarships (scholarship_id, student_id, name, amount, status) VALUES (10, 10, 'Need-Based Scholarship', 10696.23, 'Approved');

DROP TABLE IF EXISTS complaints CASCADE;
CREATE TABLE complaints (
complaint_id SERIAL PRIMARY KEY,
student_id INT,
category VARCHAR(50),
description TEXT,
status VARCHAR(20),
created_at TIMESTAMP,
resolved_at TIMESTAMP,
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for complaints
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (1, 1, 'Bus', 'Yeah term camera tend economic represent stock seven put majority.', 'Resolved', '2026-06-06 20:52:18.286435', '2026-06-15 20:52:18.286435');
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (2, 2, 'Infrastructure', 'Physical heart away some shoulder idea seek reason theory lawyer maintain old than suggest.', 'Resolved', '2026-04-26 06:54:20.615644', '2026-04-29 06:54:20.615644');
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (3, 3, 'Hostel', 'Play recently sure somebody huge why station manager follow exist natural candidate system small thus several animal.', 'Resolved', '2026-01-19 14:18:57.192341', '2026-01-27 14:18:57.192341');
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (4, 4, 'Bus', 'Administration upon citizen lead yeah into yet travel think few themselves theory behavior growth bar professor power.', 'Resolved', '2026-05-06 00:31:29.809206', '2026-05-16 00:31:29.809206');
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (5, 5, 'Bus', 'Figure record doctor pretty region ability live car difficult quite act receive stage write institution car audience him room bill finish.', 'Resolved', '2026-01-11 08:09:14.731034', '2026-01-19 08:09:14.731034');
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (6, 6, 'Hostel', 'Him spend themselves political quality attention none particular clearly goal defense.', 'Pending', '2026-06-25 21:31:12.466259', NULL);
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (7, 7, 'Library', 'Pattern kind describe to cause but role goal investment social easy popular easy over return expect.', 'Pending', '2026-05-30 09:33:07.617274', NULL);
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (8, 8, 'Hostel', 'Summer probably feeling military meeting security far approach today.', 'Pending', '2026-07-07 22:25:07.496610', NULL);
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (9, 9, 'Ragging', 'History drop point audience thousand activity guess first hit stuff inside national common likely would authority onto add.', 'Resolved', '2026-07-10 14:35:30.357006', '2026-07-12 14:35:30.357006');
INSERT INTO complaints (complaint_id, student_id, category, description, status, created_at, resolved_at) VALUES (10, 10, 'Academic', 'We huge expert Republican short interest I policy Mrs check.', 'Resolved', '2026-02-13 01:47:46.657118', '2026-02-14 01:47:46.657118');

DROP TABLE IF EXISTS lost_and_found CASCADE;
CREATE TABLE lost_and_found (
item_id SERIAL PRIMARY KEY,
title VARCHAR(100),
description TEXT,
location VARCHAR(100),
date_found DATE,
claimed_by INT,
status VARCHAR(20),
FOREIGN KEY (claimed_by) REFERENCES students(student_id)
);

-- Data for lost_and_found
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (1, 'Wallet', 'Finally memory data space movie.', 'Canteen', '2026-03-19', 1, 'Claimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (2, 'Water Bottle', 'Financial join well draw each.', 'Library', '2026-07-04', 2, 'Unclaimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (3, 'ID Card', 'Law participant finally score scientist.', 'Bus Stop', '2026-01-24', 3, 'Claimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (4, 'Umbrella', 'Reduce clearly well mission situation result.', 'Canteen', '2026-02-03', 4, 'Unclaimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (5, 'Laptop Charger', 'Seek them run brother tonight friend.', 'Bus Stop', '2026-03-27', NULL, 'Claimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (6, 'Notebook', 'Ask Republican office baby lawyer growth matter note happy effort.', 'Bus Stop', '2026-01-21', NULL, 'Claimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (7, 'Keys', 'Purpose boy scientist able teach activity animal hair turn condition.', 'Classroom', '2026-07-11', 7, 'Unclaimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (8, 'Bag', 'Need trial scientist information focus.', 'Canteen', '2026-03-24', 8, 'Unclaimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (9, 'Phone', 'Even back head maybe top conference source wonder.', 'Library', '2026-07-09', NULL, 'Unclaimed');
INSERT INTO lost_and_found (item_id, title, description, location, date_found, claimed_by, status) VALUES (10, 'Watch', 'Theory tend similar financial beat.', 'Library', '2026-04-01', NULL, 'Claimed');

DROP TABLE IF EXISTS announcements CASCADE;
CREATE TABLE announcements (
announcement_id SERIAL PRIMARY KEY,
title VARCHAR(150),
description TEXT,
department_id INT,
date DATE,
posted_by INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (posted_by) REFERENCES staff(staff_id)
);

-- Data for announcements
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (1, 'Announcement: Multi-layered dedicated frame', 'Six science drug happy will young simply run national somebody character usually agency must player.', 1, '2026-05-18', 1);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (2, 'Announcement: Advanced full-range ability', 'Support road billion morning draw man art young Republican behavior TV today.', 2, '2026-04-14', 2);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (3, 'Announcement: Total holistic knowledgebase', 'Oil measure PM hour option artist production candidate.', 3, '2026-02-28', 3);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (4, 'Announcement: Intuitive hybrid standardization', 'Fish evening avoid dark sister once choice clearly letter image movie who.', 4, '2026-02-11', 4);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (5, 'Announcement: Integrated maximized firmware', 'Bed space fight relate owner Democrat task chance represent.', 5, '2026-07-12', 5);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (6, 'Announcement: Object-based multimedia application', 'Employee wrong all identify laugh security economic left sound cause activity.', 6, '2026-06-15', 6);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (7, 'Announcement: Face-to-face clear-thinking customer loyalty', 'Head piece popular old else spend against ask total kitchen can toward stop.', 7, '2026-03-07', 7);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (8, 'Announcement: Balanced maximized application', 'Under item right many him interview government traditional every.', 8, '2026-03-30', 8);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (9, 'Announcement: Distributed 5thgeneration pricing structure', 'Pay positive material third look because him information poor something eat yes myself affect him require.', 9, '2026-04-06', 9);
INSERT INTO announcements (announcement_id, title, description, department_id, date, posted_by) VALUES (10, 'Announcement: Pre-emptive grid-enabled open system', 'Focus establish ago others ahead specific exactly speak line group once do city easy.', 10, '2026-02-17', 10);

DROP TABLE IF EXISTS notifications CASCADE;
CREATE TABLE notifications (
notification_id SERIAL PRIMARY KEY,
student_id INT,
title VARCHAR(150),
message TEXT,
read_status INTEGER,
created_at TIMESTAMP,
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for notifications
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (1, 1, 'Notification 1', 'Staff true argue you detail suffer something great stuff suddenly compare or.', 1, '2026-07-16 01:01:05.705575');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (2, 2, 'Notification 2', 'Trial agreement red way nor none could write think man.', 1, '2026-07-06 18:23:34.567917');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (3, 3, 'Notification 3', 'Also argue own after long forward pass southern future concern sort than.', 0, '2026-07-02 02:40:08.261912');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (4, 4, 'Notification 4', 'Only true similar suffer team whether health.', 0, '2026-07-18 13:47:24.270889');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (5, 5, 'Notification 5', 'Only from follow wish run join police maintain fish religious no.', 1, '2026-07-17 14:21:36.042316');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (6, 6, 'Notification 6', 'Skin development open compare fill read camera rock we we hot yes whole.', 1, '2026-07-01 14:30:03.183625');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (7, 7, 'Notification 7', 'Fish speak particularly policy bit many former back get floor player white start.', 1, '2026-07-13 12:02:05.170307');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (8, 8, 'Notification 8', 'Land enter economic attack either blue ability history run why.', 0, '2026-07-17 12:05:57.969646');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (9, 9, 'Notification 9', 'Think goal heart stock small official serve difficult later son almost after.', 0, '2026-07-05 20:55:55.625176');
INSERT INTO notifications (notification_id, student_id, title, message, read_status, created_at) VALUES (10, 10, 'Notification 10', 'Avoid color heart rule natural together behavior.', 1, '2026-07-12 02:00:17.631089');

DROP TABLE IF EXISTS ai_chat_history CASCADE;
CREATE TABLE ai_chat_history (
chat_id SERIAL PRIMARY KEY,
student_id INT,
question TEXT,
answer TEXT,
timestamp TIMESTAMP,
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for ai_chat_history
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (1, 1, 'When is the next exam?', 'Your next internal exam is scheduled for next week.', '2026-07-12 10:47:17.025797');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (2, 2, 'How do I apply for a library book?', 'You can request a book through the library portal.', '2026-07-10 00:10:04.525921');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (3, 3, 'What is the bus fee for this semester?', 'The bus fee for this semester is Rs. 8000.', '2026-07-01 13:52:43.152470');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (4, 4, 'How can I contact my class advisor?', 'You can contact your class advisor via the staff directory.', '2026-07-18 14:01:21.006134');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (5, 5, 'What is my attendance percentage?', 'Your current attendance is 87%.', '2026-07-04 01:53:06.697765');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (6, 6, 'When is the next exam?', 'Your next internal exam is scheduled for next week.', '2026-07-17 14:25:42.775114');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (7, 7, 'How do I apply for a library book?', 'You can request a book through the library portal.', '2026-07-03 22:21:01.972114');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (8, 8, 'What is the bus fee for this semester?', 'The bus fee for this semester is Rs. 8000.', '2026-07-02 21:20:34.476820');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (9, 9, 'How can I contact my class advisor?', 'You can contact your class advisor via the staff directory.', '2026-07-04 20:02:41.345902');
INSERT INTO ai_chat_history (chat_id, student_id, question, answer, timestamp) VALUES (10, 10, 'What is my attendance percentage?', 'Your current attendance is 87%.', '2026-07-04 13:04:27.542162');

DROP TABLE IF EXISTS buildings CASCADE;
CREATE TABLE buildings (
building_id SERIAL PRIMARY KEY,
building_name VARCHAR(100),
description TEXT,
floor_count INT,
latitude DECIMAL(10,6),
longitude DECIMAL(10,6),
model_path VARCHAR(255)
);

-- Data for buildings
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (1, 'Main Block', 'Reveal role enter example down anyone occur style child guess.', 6, 12.179579, 77.803906, '/models/building_1.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (2, 'Admin Block', 'Because station person lose best deal point with list.', 2, 11.850278, 77.544562, '/models/building_2.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (3, 'Library Block', 'Final however major produce before.', 6, 11.297979, 77.265632, '/models/building_3.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (4, 'CSE Block', 'Hold he high cost and keep enjoy student nor character.', 2, 11.14282, 77.165923, '/models/building_4.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (5, 'Mechanical Block', 'Beat gas must wife operation.', 3, 12.190088, 77.82424, '/models/building_5.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (6, 'Civil Block', 'Article hit mission whole reach view of dog federal house.', 3, 11.878307, 77.468698, '/models/building_6.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (7, 'Auditorium', 'Maybe too song quality per.', 3, 12.399467, 77.942676, '/models/building_7.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (8, 'Hostel Block A', 'We last we cold deep cover.', 5, 12.079963, 77.437759, '/models/building_8.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (9, 'Sports Complex', 'Interest write itself young physical.', 5, 11.079722, 77.432029, '/models/building_9.glb');
INSERT INTO buildings (building_id, building_name, description, floor_count, latitude, longitude, model_path) VALUES (10, 'Canteen Block', 'Election treat trial attack hold however for everybody leader them.', 3, 12.207427, 77.025865, '/models/building_10.glb');

DROP TABLE IF EXISTS campus_navigation CASCADE;
CREATE TABLE campus_navigation (
location_id SERIAL PRIMARY KEY,
building_id INT,
x_coordinate DECIMAL(10,4),
y_coordinate DECIMAL(10,4),
z_coordinate DECIMAL(10,4),
floor INT,
FOREIGN KEY (building_id) REFERENCES buildings(building_id)
);

-- Data for campus_navigation
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (1, 1, 22.8924, 67.4298, 17.2103, 4);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (2, 2, 95.0786, 99.9572, 13.4456, 2);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (3, 3, 57.6247, 76.3109, 3.5038, 4);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (4, 4, 65.1509, 91.6073, 3.6298, 4);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (5, 5, 43.5885, 81.4245, 19.3811, 3);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (6, 6, 34.7961, 33.3308, 13.4027, 1);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (7, 7, 32.9804, 69.3674, 5.7644, 3);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (8, 8, 81.3566, 55.0097, 9.0965, 2);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (9, 9, 25.2399, 11.5922, 15.451, 4);
INSERT INTO campus_navigation (location_id, building_id, x_coordinate, y_coordinate, z_coordinate, floor) VALUES (10, 10, 82.4927, 0.1151, 17.3873, 3);

DROP TABLE IF EXISTS labs CASCADE;
CREATE TABLE labs (
lab_id SERIAL PRIMARY KEY,
lab_name VARCHAR(100),
department_id INT,
lab_incharge INT,
assistant_id INT,
room_number VARCHAR(20),
capacity INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id),
FOREIGN KEY (lab_incharge) REFERENCES faculty(faculty_id),
FOREIGN KEY (assistant_id) REFERENCES lab_assistant(assistant_id)
);

-- Data for labs
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (1, 'Programming Lab', 1, 1, 1, 'L-101', 40);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (2, 'Electronics Lab', 2, 2, 2, 'L-102', 30);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (3, 'Thermal Lab', 3, 3, 3, 'L-103', 30);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (4, 'Structural Lab', 4, 4, 4, 'L-104', 60);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (5, 'Power Systems Lab', 5, 5, 5, 'L-105', 40);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (6, 'Networking Lab', 6, 6, 6, 'L-106', 60);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (7, 'Biotech Lab', 7, 7, 7, 'L-107', 40);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (8, 'Process Lab', 8, 8, 8, 'L-108', 60);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (9, 'Mathematics Lab', 9, 9, 9, 'L-109', 40);
INSERT INTO labs (lab_id, lab_name, department_id, lab_incharge, assistant_id, room_number, capacity) VALUES (10, 'Physics Lab', 10, 10, 10, 'L-110', 30);

DROP TABLE IF EXISTS lab_equipment CASCADE;
CREATE TABLE lab_equipment (
equipment_id SERIAL PRIMARY KEY,
lab_id INT,
equipment_name VARCHAR(100),
quantity INT,
working_status VARCHAR(20),
FOREIGN KEY (lab_id) REFERENCES labs(lab_id)
);

-- Data for lab_equipment
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (1, 1, 'Desktop Computer', 18, 'Needs Repair');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (2, 2, 'Oscilloscope', 40, 'Working');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (3, 3, 'CRO', 23, 'Needs Repair');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (4, 4, 'Multimeter', 49, 'Needs Repair');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (5, 5, 'Soldering Kit', 12, 'Working');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (6, 6, 'Microscope', 45, 'Out of Order');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (7, 7, 'Centrifuge', 20, 'Out of Order');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (8, 8, '3D Printer', 15, 'Needs Repair');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (9, 9, 'Projector', 40, 'Working');
INSERT INTO lab_equipment (equipment_id, lab_id, equipment_name, quantity, working_status) VALUES (10, 10, 'Server Rack', 40, 'Needs Repair');

DROP TABLE IF EXISTS classrooms CASCADE;
CREATE TABLE classrooms (
classroom_id SERIAL PRIMARY KEY,
room_no VARCHAR(20),
building_id INT,
capacity INT,
type VARCHAR(30),
FOREIGN KEY (building_id) REFERENCES buildings(building_id)
);

-- Data for classrooms
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (1, 'CR-101', 1, 40, 'Lecture Hall');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (2, 'CR-102', 2, 40, 'Seminar Room');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (3, 'CR-103', 3, 40, 'Smart Classroom');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (4, 'CR-104', 4, 40, 'Seminar Room');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (5, 'CR-105', 5, 80, 'Seminar Room');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (6, 'CR-106', 6, 80, 'Smart Classroom');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (7, 'CR-107', 7, 60, 'Seminar Room');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (8, 'CR-108', 8, 60, 'Seminar Room');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (9, 'CR-109', 9, 40, 'Seminar Room');
INSERT INTO classrooms (classroom_id, room_no, building_id, capacity, type) VALUES (10, 'CR-110', 10, 80, 'Lecture Hall');

DROP TABLE IF EXISTS canteen_menu CASCADE;
CREATE TABLE canteen_menu (
item_id SERIAL PRIMARY KEY,
item_name VARCHAR(100),
price DECIMAL(6,2),
category VARCHAR(30),
availability VARCHAR(20)
);

-- Data for canteen_menu
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (1, 'Masala Dosa', 52.19, 'Lunch', 'Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (2, 'Idli Sambar', 40.39, 'Beverages', 'Not Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (3, 'Veg Biryani', 112.77, 'Snacks', 'Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (4, 'Chicken Fried Rice', 41.11, 'Snacks', 'Not Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (5, 'Samosa', 105.18, 'Beverages', 'Not Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (6, 'Tea', 47.96, 'Beverages', 'Not Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (7, 'Coffee', 112.61, 'Lunch', 'Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (8, 'Cold Drink', 72.9, 'Lunch', 'Not Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (9, 'Sandwich', 14.8, 'Beverages', 'Not Available');
INSERT INTO canteen_menu (item_id, item_name, price, category, availability) VALUES (10, 'Fruit Salad', 52.47, 'Lunch', 'Not Available');

DROP TABLE IF EXISTS alumni CASCADE;
CREATE TABLE alumni (
alumni_id SERIAL PRIMARY KEY,
name VARCHAR(100),
department VARCHAR(100),
batch VARCHAR(20),
company VARCHAR(100),
designation VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(20)
);

-- Data for alumni
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (1, 'Lisa Mills', 'Computer Science', '2016-2020', 'Rodriguez-Hernandez', 'Software Engineer', 'buckleyanna@gmail.com', '8564679970');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (2, 'Lee Steele', 'Electronics & Communication', '2017-2021', 'Foster LLC', 'Manager', 'brandonalvarez@yahoo.com', '0544471324');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (3, 'Lisa Davis', 'Mechanical Engineering', '2018-2022', 'Lewis-Holloway', 'Team Lead', 'xmalone@gmail.com', '1486289023');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (4, 'Anthony Ward', 'Civil Engineering', '2019-2023', 'Hill Group', 'Team Lead', 'hreid@hotmail.com', '3579727985');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (5, 'Melissa Mitchell', 'Electrical Engineering', '2020-2024', 'Williams-Nash', 'Analyst', 'mercedesholland@hotmail.com', '4680072290');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (6, 'Elizabeth Rasmussen', 'Information Technology', '2021-2025', 'Hill, Woodard and York', 'Software Engineer', 'dking@yahoo.com', '9108589944');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (7, 'Donald Nguyen', 'Biotechnology', '2022-2026', 'Green-Dawson', 'Consultant', 'jacob83@gmail.com', '5207446660');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (8, 'Micheal Parks', 'Chemical Engineering', '2023-2027', 'Glover, Knox and Powers', 'Software Engineer', 'megan82@yahoo.com', '7248251353');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (9, 'Kevin Ford', 'Mathematics', '2024-2028', 'Ruiz Ltd', 'Team Lead', 'kennedyjames@gmail.com', '8460223569');
INSERT INTO alumni (alumni_id, name, department, batch, company, designation, email, phone) VALUES (10, 'Catherine Miller', 'Physics', '2025-2029', 'Welch-Thompson', 'Consultant', 'smithjoshua@gmail.com', '7129666676');

DROP TABLE IF EXISTS visitors CASCADE;
CREATE TABLE visitors (
visitor_id SERIAL PRIMARY KEY,
name VARCHAR(100),
purpose VARCHAR(150),
person_to_meet VARCHAR(100),
entry_time TIMESTAMP,
exit_time TIMESTAMP
);

-- Data for visitors
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (1, 'Adrian Morris', 'Interview', 'Cheryl Rhodes', '2026-07-04 17:17:49.333149', '2026-07-04 18:17:49.333149');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (2, 'Michael Cooper', 'Interview', 'James Chapman', '2026-07-12 16:37:41.943730', '2026-07-12 20:37:41.943730');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (3, 'Elizabeth Carter', 'Official Visit', 'Linda Morgan', '2026-07-04 02:47:27.899249', '2026-07-04 03:47:27.899249');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (4, 'Grace Valenzuela MD', 'Guest Lecture', 'Travis Hull', '2026-07-17 13:37:54.540900', '2026-07-17 16:37:54.540900');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (5, 'Nicholas Anderson', 'Meeting', 'Leah Jackson', '2026-07-08 12:38:14.761568', '2026-07-08 16:38:14.761568');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (6, 'Amanda Mcdowell', 'Parent Meeting', 'Joseph Williams', '2026-07-07 20:09:30.347875', '2026-07-07 23:09:30.347875');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (7, 'Martha Smith', 'Guest Lecture', 'Jennifer James', '2026-07-19 13:24:52.174911', '2026-07-19 17:24:52.174911');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (8, 'Christian Neal', 'Parent Meeting', 'Elizabeth Stanley', '2026-07-11 05:04:16.419385', '2026-07-11 09:04:16.419385');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (9, 'Larry Taylor', 'Parent Meeting', 'Ashley Higgins', '2026-07-13 08:39:27.589854', '2026-07-13 09:39:27.589854');
INSERT INTO visitors (visitor_id, name, purpose, person_to_meet, entry_time, exit_time) VALUES (10, 'Brian Gonzalez', 'Interview', 'Dennis Mills', '2026-07-03 04:43:16.130271', '2026-07-03 05:43:16.130271');

DROP TABLE IF EXISTS emergency_contacts CASCADE;
CREATE TABLE emergency_contacts (
contact_id SERIAL PRIMARY KEY,
department VARCHAR(100),
name VARCHAR(100),
phone VARCHAR(20),
email VARCHAR(100)
);

-- Data for emergency_contacts
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (1, 'Security', 'Michael Phillips', '8737530011', 'security@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (2, 'Medical/First Aid', 'Penny Jones', '4374470120', 'medicalfirstaid@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (3, 'Fire Safety', 'Brian York', '0225579415', 'firesafety@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (4, 'Transport', 'Victor Nelson', '7621202169', 'transport@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (5, 'Hostel Warden', 'James Howard', '2771670145', 'hostelwarden@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (6, 'Admin Office', 'Courtney Sosa', '8891637562', 'adminoffice@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (7, 'IT Helpdesk', 'Timothy Wagner', '7217535408', 'ithelpdesk@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (8, 'Placement Cell', 'David Stevens', '1775170166', 'placementcell@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (9, 'Counseling Center', 'Brandon Munoz', '8837550375', 'counselingcenter@college.edu');
INSERT INTO emergency_contacts (contact_id, department, name, phone, email) VALUES (10, 'Maintenance', 'Matthew Baldwin', '1305548851', 'maintenance@college.edu');

DROP TABLE IF EXISTS feedback CASCADE;
CREATE TABLE feedback (
feedback_id SERIAL PRIMARY KEY,
student_id INT,
category VARCHAR(50),
rating INT,
comments TEXT,
submitted_at TIMESTAMP,
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Data for feedback
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (1, 1, 'Transport', 3, 'State score important effect cultural building system democratic station.', '2026-07-04 13:20:25.927016');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (2, 2, 'Facilities', 1, 'Blue increase unit study open sign late probably what care material morning.', '2026-07-01 21:45:00.731148');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (3, 3, 'Hostel', 1, 'Stuff lot meet TV concern official room campaign hold over third mean his.', '2026-07-19 06:37:01.831502');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (4, 4, 'Transport', 1, 'Event white wife laugh card include record security federal reduce.', '2026-07-17 01:25:19.092473');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (5, 5, 'Hostel', 2, 'Plan cut person fact generation public wonder practice when mean reason follow break good lose.', '2026-07-11 15:31:47.572533');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (6, 6, 'Transport', 3, 'Purpose throw move there institution actually blood herself apply argue environment size worker.', '2026-07-13 18:01:11.680350');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (7, 7, 'Faculty', 1, 'Style real far send allow sport bill test science.', '2026-07-17 03:16:23.283371');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (8, 8, 'Canteen', 1, 'Home memory someone receive realize another high indicate small rate whole approach season data than.', '2026-07-17 01:18:15.428693');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (9, 9, 'Canteen', 3, 'Stop treatment relate positive sense national owner simply who family concern radio cost.', '2026-07-04 05:49:29.570620');
INSERT INTO feedback (feedback_id, student_id, category, rating, comments, submitted_at) VALUES (10, 10, 'Canteen', 4, 'Budget American evidence enough claim suffer accept letter visit always up others similar personal successful.', '2026-07-06 14:51:22.045652');

