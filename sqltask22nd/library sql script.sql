--
-- File generated with SQLiteStudio v3.4.17 on Mon Sep 22 18:16:57 2025
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Authors
CREATE TABLE IF NOT EXISTS Authors (
    author_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name     TEXT(50) NOT NULL,
    last_name      TEXT(50) NOT NULL
);

-- Table: BookAuthors
CREATE TABLE IF NOT EXISTS BookAuthors (
    book_id   INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Table: BookCopies
CREATE TABLE IF NOT EXISTS BookCopies (copy_id INTEGER PRIMARY KEY AUTOINCREMENT, book_id INTEGER NOT NULL REFERENCES Books (book_id) ON DELETE SET NULL ON UPDATE CASCADE, acquisition_date NUMBER, status TEXT (20) DEFAULT 'Available' CHECK (status IN ('Available', 'Issued', 'Lost', 'Damaged')), FOREIGN KEY (book_id) REFERENCES Books (book_id));

-- Table: Books
CREATE TABLE IF NOT EXISTS Books (
    book_id        INTEGER PRIMARY KEY AUTOINCREMENT,
    title          TEXT(200) NOT NULL,
    isbn           TEXT(20) UNIQUE,
    publisher      TEXT(100),
    published_year INTEGER,
    category_id    INTEGER,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Table: Categories
CREATE TABLE IF NOT EXISTS Categories (
    category_id    INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name  TEXT(100) NOT NULL UNIQUE);

-- Table: Fines
CREATE TABLE IF NOT EXISTS Fines (
    fine_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    loan_id     INTEGER NOT NULL UNIQUE,
    fine_amount REAL NOT NULL,
    paid_status TEXT(20) CHECK(paid_status IN ('Paid','Unpaid')),
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);

-- Table: Loans
CREATE TABLE IF NOT EXISTS Loans (
    loan_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id   INTEGER NOT NULL,
    copy_id     INTEGER NOT NULL,
    issue_date  NUMBER NOT NULL,
    due_date    NUMBER NOT NULL,
    return_date NUMBER,
    status      TEXT(20) CHECK(status IN ('Issued','Returned','Overdue')),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (copy_id) REFERENCES BookCopies(copy_id)
);

-- Table: Members
CREATE TABLE IF NOT EXISTS Members (member_id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT (50) NOT NULL, last_name TEXT (50) NOT NULL, email TEXT (100) UNIQUE, phone TEXT (20), address TEXT, membership_date NUMERIC NOT NULL, status TEXT (20) CHECK (status IN ('Active', 'Expired', 'Suspended')));

-- Table: Staff
CREATE TABLE IF NOT EXISTS Staff (
    staff_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT(50) NOT NULL,
    last_name  TEXT(50) NOT NULL,
    role       TEXT(30) CHECK(role IN ('Librarian','Assistant','Admin')),
    email      TEXT(100) UNIQUE,
    phone      TEXT(20)
);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
