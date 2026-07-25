-- ============================================================
-- SUPABASE SETUP SCRIPT
-- Run this entire file in your Supabase SQL Editor
-- ============================================================

-- First, run the entire database.sql content here (all 55 tables + data)
-- Then run the RPC functions below:

-- ============================================================
-- RPC FUNCTION: verify_student_login
-- ============================================================
CREATE OR REPLACE FUNCTION verify_student_login(p_username TEXT, p_password TEXT)
RETURNS TABLE(success BOOLEAN, student_id INT, username TEXT, name TEXT)
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_student_id INT;
  v_username TEXT;
  v_name TEXT;
BEGIN
  SELECT sl.student_id, sl.username, s.first_name || ' ' || s.last_name
  INTO v_student_id, v_username, v_name
  FROM student_login sl
  JOIN students s ON s.student_id = sl.student_id
  WHERE sl.username = p_username AND sl.possword = p_password;
  
  IF FOUND THEN
    RETURN QUERY SELECT true, v_student_id, v_username, v_name;
  ELSE
    RETURN QUERY SELECT false, NULL::INT, NULL::TEXT, NULL::TEXT;
  END IF;
END;
$$;

-- ============================================================
-- RPC FUNCTION: verify_staff_login
-- ============================================================
CREATE OR REPLACE FUNCTION verify_staff_login(p_username TEXT, p_password TEXT)
RETURNS TABLE(success BOOLEAN, staff_id INT, username TEXT, name TEXT)
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_staff_id INT;
  v_username TEXT;
  v_name TEXT;
BEGIN
  SELECT sl.staff_id, sl.username, st.name
  INTO v_staff_id, v_username, v_name
  FROM staff_login sl
  JOIN staff st ON st.staff_id = sl.staff_id
  WHERE sl.username = p_username AND sl.possword = p_password;
  
  IF FOUND THEN
    RETURN QUERY SELECT true, v_staff_id, v_username, v_name;
  ELSE
    RETURN QUERY SELECT false, NULL::INT, NULL::TEXT, NULL::TEXT;
  END IF;
END;
$$;

-- ============================================================
-- RPC FUNCTION: verify_admin_login
-- ============================================================
CREATE OR REPLACE FUNCTION verify_admin_login(p_username TEXT, p_password TEXT)
RETURNS TABLE(success BOOLEAN, admin_id INT, username TEXT, name TEXT)
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_admin_id INT;
  v_username TEXT;
  v_name TEXT;
BEGIN
  SELECT al.admin_id, al.username, al.name
  INTO v_admin_id, v_username, v_name
  FROM admin_login al
  WHERE al.username = p_username AND al.possword = p_password;
  
  IF FOUND THEN
    RETURN QUERY SELECT true, v_admin_id, v_username, v_name;
  ELSE
    RETURN QUERY SELECT false, NULL::INT, NULL::TEXT, NULL::TEXT;
  END IF;
END;
$$;

-- ============================================================
-- RPC FUNCTION: reset_student_password
-- ============================================================
CREATE OR REPLACE FUNCTION reset_student_password(p_username TEXT, p_email TEXT)
RETURNS TABLE(success BOOLEAN)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  UPDATE student_login sl
  SET possword = 'reset123'
  FROM students s
  WHERE sl.student_id = s.student_id
  AND sl.username = p_username
  AND s.email = p_email;
  
  IF FOUND THEN
    RETURN QUERY SELECT true;
  ELSE
    RETURN QUERY SELECT false;
  END IF;
END;
$$;

-- ============================================================
-- RPC FUNCTION: get_all_books
-- Returns all library books with full details
-- ============================================================
CREATE OR REPLACE FUNCTION get_all_books()
RETURNS TABLE(
  book_id INT,
  isbn VARCHAR(20),
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
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT lb.book_id, lb.isbn, lb.title, lb.author, lb.publisher,
         lb.edition, lb.category, lb.rack_no, lb.floor_location,
         lb.shelf_location, lb.total_copies, lb.available_copies, lb.status
  FROM library_books lb
  ORDER BY lb.title ASC;
END;
$$;

-- ============================================================
-- RPC FUNCTION: search_library_books
-- Search books by title, author, ISBN, or category
-- ============================================================
CREATE OR REPLACE FUNCTION search_library_books(
  p_search_term TEXT DEFAULT '',
  p_category_filter TEXT DEFAULT 'ALL'
)
RETURNS TABLE(
  book_id INT,
  isbn VARCHAR(20),
  title VARCHAR(200),
  author VARCHAR(150),
  publisher VARCHAR(100),
  category VARCHAR(50),
  rack_no VARCHAR(20),
  floor_location VARCHAR(30),
  shelf_location VARCHAR(20),
  total_copies INT,
  available_copies INT,
  status VARCHAR(20)
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT lb.book_id, lb.isbn, lb.title, lb.author, lb.publisher,
         lb.category, lb.rack_no, lb.floor_location,
         lb.shelf_location, lb.total_copies, lb.available_copies, lb.status
  FROM library_books lb
  WHERE (
    p_search_term = '' OR
    lb.title ILIKE '%' || p_search_term || '%' OR
    lb.author ILIKE '%' || p_search_term || '%' OR
    lb.isbn ILIKE '%' || p_search_term || '%' OR
    lb.category ILIKE '%' || p_search_term || '%'
  )
  AND (
    p_category_filter = 'ALL' OR
    lb.category ILIKE '%' || p_category_filter || '%'
  )
  ORDER BY lb.title ASC;
END;
$$;

-- ============================================================
-- RPC FUNCTION: get_book_by_id
-- Returns single book details by book_id
-- ============================================================
CREATE OR REPLACE FUNCTION get_book_by_id(p_book_id INT)
RETURNS TABLE(
  book_id INT,
  isbn VARCHAR(20),
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
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT lb.book_id, lb.isbn, lb.title, lb.author, lb.publisher,
         lb.edition, lb.category, lb.rack_no, lb.floor_location,
         lb.shelf_location, lb.total_copies, lb.available_copies, lb.status
  FROM library_books lb
  WHERE lb.book_id = p_book_id;
  
  IF NOT FOUND THEN
    RETURN QUERY SELECT NULL::INT, NULL::VARCHAR(20), NULL::VARCHAR(200),
                        NULL::VARCHAR(150), NULL::VARCHAR(100), NULL::VARCHAR(20),
                        NULL::VARCHAR(50), NULL::VARCHAR(20), NULL::VARCHAR(30),
                        NULL::VARCHAR(20), NULL::INT, NULL::INT, NULL::VARCHAR(20)
    WHERE FALSE;
  END IF;
END;
$$;

-- ============================================================
-- RPC FUNCTION: get_books_by_category
-- Returns books filtered by category
-- ============================================================
CREATE OR REPLACE FUNCTION get_books_by_category(p_category VARCHAR(50))
RETURNS TABLE(
  book_id INT,
  isbn VARCHAR(20),
  title VARCHAR(200),
  author VARCHAR(150),
  publisher VARCHAR(100),
  category VARCHAR(50),
  rack_no VARCHAR(20),
  floor_location VARCHAR(30),
  shelf_location VARCHAR(20),
  total_copies INT,
  available_copies INT,
  status VARCHAR(20)
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT lb.book_id, lb.isbn, lb.title, lb.author, lb.publisher,
         lb.category, lb.rack_no, lb.floor_location,
         lb.shelf_location, lb.total_copies, lb.available_copies, lb.status
  FROM library_books lb
  WHERE lb.category ILIKE '%' || p_category || '%'
  ORDER BY lb.title ASC;
END;
$$;

-- ============================================================
-- RPC FUNCTION: get_book_categories
-- Returns distinct book categories
-- ============================================================
CREATE OR REPLACE FUNCTION get_book_categories()
RETURNS TABLE(category VARCHAR(50), book_count BIGINT)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT lb.category, COUNT(*)::BIGINT AS book_count
  FROM library_books lb
  GROUP BY lb.category
  ORDER BY lb.category ASC;
END;
$$;

-- ============================================================
-- RPC FUNCTION: issue_book
-- Issues a book to a student (decrements available copies)
-- ============================================================
CREATE OR REPLACE FUNCTION issue_book(
  p_book_id INT,
  p_student_id INT,
  p_issue_date DATE DEFAULT CURRENT_DATE
)
RETURNS TABLE(success BOOLEAN, issue_id INT, message TEXT)
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_available INT;
  v_issue_id INT;
  v_due_date DATE;
BEGIN
  -- Check if book exists and has available copies
  SELECT lb.available_copies INTO v_available
  FROM library_books lb
  WHERE lb.book_id = p_book_id;
  
  IF NOT FOUND THEN
    RETURN QUERY SELECT false, NULL::INT, 'Book not found.'::TEXT;
    RETURN;
  END IF;
  
  IF v_available <= 0 THEN
    RETURN QUERY SELECT false, NULL::INT, 'No copies available for issue.'::TEXT;
    RETURN;
  END IF;
  
  -- Check if student already has this book issued and not returned
  IF EXISTS (
    SELECT 1 FROM library_issue li
    WHERE li.book_id = p_book_id AND li.student_id = p_student_id AND li.return_date IS NULL
  ) THEN
    RETURN QUERY SELECT false, NULL::INT, 'Student already has this book issued and not returned.'::TEXT;
    RETURN;
  END IF;
  
  -- Calculate due date (14 days from issue date)
  v_due_date := p_issue_date + INTERVAL '14 days';
  
  -- Insert issue record
  INSERT INTO library_issue (book_id, student_id, issue_date, due_date, status)
  VALUES (p_book_id, p_student_id, p_issue_date, v_due_date, 'Issued')
  RETURNING issue_id INTO v_issue_id;
  
  -- Decrement available copies
  UPDATE library_books
  SET available_copies = available_copies - 1,
      status = CASE WHEN available_copies - 1 <= 0 THEN 'Issued Out' ELSE 'Available' END
  WHERE book_id = p_book_id;
  
  RETURN QUERY SELECT true, v_issue_id, 'Book issued successfully. Due date: ' || v_due_date::TEXT;
END;
$$;

-- ============================================================
-- RPC FUNCTION: return_book
-- Returns a book (increments available copies, updates return date)
-- ============================================================
CREATE OR REPLACE FUNCTION return_book(
  p_issue_id INT,
  p_return_date DATE DEFAULT CURRENT_DATE
)
RETURNS TABLE(success BOOLEAN, message TEXT, fine_amount DECIMAL(8,2))
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_book_id INT;
  v_due_date DATE;
  v_days_overdue INT;
  v_fine_amount DECIMAL(8,2) := 0;
  v_fine_id INT;
BEGIN
  -- Get issue details
  SELECT li.book_id, li.due_date INTO v_book_id, v_due_date
  FROM library_issue li
  WHERE li.issue_id = p_issue_id AND li.return_date IS NULL;
  
  IF NOT FOUND THEN
    RETURN QUERY SELECT false, 'Issue record not found or book already returned.'::TEXT, 0.00;
    RETURN;
  END IF;
  
  -- Calculate overdue fine (Rs. 5 per day after due date)
  v_days_overdue := GREATEST(0, (p_return_date - v_due_date));
  v_fine_amount := v_days_overdue * 5.00;
  
  -- Update issue record
  UPDATE library_issue
  SET return_date = p_return_date,
      fine = v_fine_amount,
      status = 'Returned'
  WHERE issue_id = p_issue_id;
  
  -- Create fine record if applicable
  IF v_fine_amount > 0 THEN
    INSERT INTO library_fine (student_id, issue_id, amount, paid_status, paid_date)
    VALUES (
      (SELECT student_id FROM library_issue WHERE issue_id = p_issue_id),
      p_issue_id,
      v_fine_amount,
      'Unpaid',
      NULL
    )
    RETURNING fine_id INTO v_fine_id;
  END IF;
  
  -- Increment available copies
  UPDATE library_books
  SET available_copies = available_copies + 1,
      status = 'Available'
  WHERE book_id = v_book_id;
  
  IF v_fine_amount > 0 THEN
    RETURN QUERY SELECT true,
      'Book returned successfully. Fine of Rs. ' || v_fine_amount || ' applicable for ' || v_days_overdue || ' days overdue.'::TEXT,
      v_fine_amount;
  ELSE
    RETURN QUERY SELECT true, 'Book returned successfully on time. No fine.'::TEXT, 0.00;
  END IF;
END;
$$;

-- ============================================================
-- RPC FUNCTION: get_student_issued_books
-- Returns all books currently issued to a student
-- ============================================================
CREATE OR REPLACE FUNCTION get_student_issued_books(p_student_id INT)
RETURNS TABLE(
  issue_id INT,
  book_id INT,
  isbn VARCHAR(20),
  title VARCHAR(200),
  author VARCHAR(150),
  issue_date DATE,
  due_date DATE,
  days_remaining INT,
  fine DECIMAL(8,2),
  status VARCHAR(20)
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT li.issue_id, lb.book_id, lb.isbn, lb.title, lb.author,
         li.issue_date, li.due_date,
         GREATEST(0, (li.due_date - CURRENT_DATE))::INT AS days_remaining,
         COALESCE(li.fine, 0.00) AS fine,
         li.status
  FROM library_issue li
  JOIN library_books lb ON lb.book_id = li.book_id
  WHERE li.student_id = p_student_id
  ORDER BY li.issue_date DESC;
END;
$$;

-- ============================================================
-- RPC FUNCTION: get_all_library_issues
-- Returns all library issues with student and book info
-- ============================================================
CREATE OR REPLACE FUNCTION get_all_library_issues()
RETURNS TABLE(
  issue_id INT,
  book_title VARCHAR(200),
  student_name TEXT,
  student_roll VARCHAR(20),
  issue_date DATE,
  due_date DATE,
  return_date DATE,
  fine DECIMAL(8,2),
  status VARCHAR(20)
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT li.issue_id, lb.title,
         (s.first_name || ' ' || s.last_name)::TEXT AS student_name,
         s.roll_no AS student_roll,
         li.issue_date, li.due_date, li.return_date,
         COALESCE(li.fine, 0.00) AS fine,
         li.status
  FROM library_issue li
  JOIN library_books lb ON lb.book_id = li.book_id
  JOIN students s ON s.student_id = li.student_id
  ORDER BY li.issue_date DESC;
END;
$$;

-- ============================================================
-- RPC FUNCTION: get_all_library_fines
-- Returns all library fines with student and issue info
-- ============================================================
CREATE OR REPLACE FUNCTION get_all_library_fines()
RETURNS TABLE(
  fine_id INT,
  student_name TEXT,
  student_roll VARCHAR(20),
  book_title VARCHAR(200),
  amount DECIMAL(8,2),
  paid_status VARCHAR(20),
  paid_date DATE
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT lf.fine_id,
         (s.first_name || ' ' || s.last_name)::TEXT AS student_name,
         s.roll_no AS student_roll,
         lb.title AS book_title,
         lf.amount,
         lf.paid_status,
         lf.paid_date
  FROM library_fine lf
  JOIN students s ON s.student_id = lf.student_id
  JOIN library_issue li ON li.issue_id = lf.issue_id
  JOIN library_books lb ON lb.book_id = li.book_id
  ORDER BY lf.fine_id DESC;
END;
$$;

-- ============================================================
-- RPC FUNCTION: pay_library_fine
-- Marks a library fine as paid
-- ============================================================
CREATE OR REPLACE FUNCTION pay_library_fine(p_fine_id INT)
RETURNS TABLE(success BOOLEAN, message TEXT)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  UPDATE library_fine
  SET paid_status = 'Paid',
      paid_date = CURRENT_DATE
  WHERE fine_id = p_fine_id AND paid_status = 'Unpaid';
  
  IF FOUND THEN
    RETURN QUERY SELECT true, 'Fine payment recorded successfully.'::TEXT;
  ELSE
    RETURN QUERY SELECT false, 'Fine record not found or already paid.'::TEXT;
  END IF;
END;
$$;

-- ============================================================
-- RPC FUNCTION: get_library_stats
-- Returns summary statistics for the library dashboard
-- ============================================================
CREATE OR REPLACE FUNCTION get_library_stats()
RETURNS TABLE(
  total_books INT,
  total_copies INT,
  available_copies INT,
  issued_books INT,
  overdue_books INT,
  total_fines_pending DECIMAL(10,2),
  total_categories INT
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_total_books INT;
  v_total_copies INT;
  v_available_copies INT;
  v_issued_books INT;
  v_overdue_books INT;
  v_total_fines_pending DECIMAL(10,2);
  v_total_categories INT;
BEGIN
  SELECT COUNT(*), COALESCE(SUM(total_copies), 0), COALESCE(SUM(available_copies), 0)
  INTO v_total_books, v_total_copies, v_available_copies
  FROM library_books;
  
  SELECT COUNT(*)
  INTO v_issued_books
  FROM library_issue
  WHERE return_date IS NULL;
  
  SELECT COUNT(*)
  INTO v_overdue_books
  FROM library_issue
  WHERE return_date IS NULL AND due_date < CURRENT_DATE;
  
  SELECT COALESCE(SUM(amount), 0)
  INTO v_total_fines_pending
  FROM library_fine
  WHERE paid_status = 'Unpaid';
  
  SELECT COUNT(DISTINCT category)
  INTO v_total_categories
  FROM library_books;
  
  RETURN QUERY SELECT v_total_books, v_total_copies, v_available_copies,
                      v_issued_books, v_overdue_books, v_total_fines_pending, v_total_categories;
END;
$$;

