-- Library Management System Database
-- Created by CASSIAN CELSUS KIRAGU
-- Date: 5/12/2025

-- Create database
DROP DATABASE IF EXISTS library_management;
CREATE DATABASE library_management;
USE library_management;

-- Members table (Patrons of the library)
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    membership_date DATE NOT NULL,
    membership_status ENUM('Active', 'Expired', 'Suspended') DEFAULT 'Active',
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Books table (Library collection)
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    publisher VARCHAR(100),
    publication_year INT,
    genre VARCHAR(50),
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    shelf_location VARCHAR(20),
    CONSTRAINT chk_copies CHECK (available_copies <= total_copies AND total_copies >= 0)
);

-- Authors table (For many-to-many relationship with books)
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT,
    nationality VARCHAR(50)
);

-- Book-Author junction table (M-M relationship)
CREATE TABLE book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Loans table (Track book borrowing)
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Active', 'Returned', 'Overdue') DEFAULT 'Active',
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    CONSTRAINT chk_dates CHECK (due_date >= loan_date AND (return_date IS NULL OR return_date >= loan_date))
);

-- Fines table (Track overdue penalties)
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    issue_date DATE NOT NULL,
    payment_date DATE,
    status ENUM('Pending', 'Paid') DEFAULT 'Pending',
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
    CONSTRAINT chk_amount CHECK (amount >= 0)
);

-- Staff table (Library employees)
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    position VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT chk_staff_email CHECK (email LIKE '%@%.%')
);

-- Create triggers to maintain data integrity

-- Update available copies when a book is loaned
DELIMITER //
CREATE TRIGGER after_loan_insert
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
    UPDATE books 
    SET available_copies = available_copies - 1
    WHERE book_id = NEW.book_id;
END//
DELIMITER ;

-- Update available copies when a book is returned
DELIMITER //
CREATE TRIGGER after_loan_update
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN
    IF NEW.return_date IS NOT NULL AND OLD.return_date IS NULL THEN
        UPDATE books 
        SET available_copies = available_copies + 1
        WHERE book_id = NEW.book_id;
    END IF;
END//
DELIMITER ;

-- Create views for common queries

-- View of currently checked out books
CREATE VIEW active_loans AS
SELECT l.loan_id, b.title, m.first_name, m.last_name, l.loan_date, l.due_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.status = 'Active';

-- View of overdue books
CREATE VIEW overdue_loans AS
SELECT l.loan_id, b.title, m.first_name, m.last_name, m.email, l.loan_date, l.due_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.status = 'Active' AND l.due_date < CURDATE();

-- Sample data insertion
INSERT INTO members (first_name, last_name, email, phone, membership_date) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '2023-01-15'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', '2023-02-20'),
('Michael', 'Brown', 'michael.b@email.com', NULL, '2023-03-10');

INSERT INTO books (isbn, title, author, publication_year, total_copies, available_copies) VALUES
('978-0061120084', 'To Kill a Mockingbird', 'Harper Lee', 1960, 5, 5),
('978-0451524935', '1984', 'George Orwell', 1949, 3, 3),
('978-0743273565', 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 4, 4);

INSERT INTO loans (book_id, member_id, loan_date, due_date) VALUES
(1, 1, '2023-06-01', '2023-06-15'),
(2, 2, '2023-06-05', '2023-06-19');
