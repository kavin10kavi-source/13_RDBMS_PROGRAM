CREATE DATABASE CollegeDB;
USE CollegeDB;

CREATE TABLE Student_Unnormalized (
    StudentID INT,
    StudentName VARCHAR(50),
    CourseName VARCHAR(50),
    FacultyName VARCHAR(50),
    DepartmentName VARCHAR(50)
);

INSERT INTO Student_Unnormalized VALUES
(1001, 'Alice Smith', 'Database Systems', 'Dr. Alan Turing', 'Computer Science'),
(1001, 'Alice Smith', 'Data Structures', 'Dr. Alan Turing', 'Computer Science'),
(1002, 'Bob Jones', 'Linear Algebra', 'Dr. Ada Lovelace', 'Mathematics'),
(1003, 'Charlie Brown', 'Database Systems', 'Dr. Alan Turing', 'Computer Science');

DROP TABLE IF EXISTS Student_Unnormalized;

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY AUTO_INCREMENT,
    FacultyName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(50) NOT NULL UNIQUE,
    FacultyID INT NOT NULL,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

CREATE TABLE Enrollment (
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE
);

INSERT INTO Department (DepartmentName) VALUES
('Computer Science'),
('Mathematics');

INSERT INTO Faculty (FacultyName) VALUES
('Dr. Alan Turing'),
('Dr. Ada Lovelace');

INSERT INTO Student (StudentID, StudentName, DepartmentID) VALUES
(1001, 'Alice Smith', 1),
(1002, 'Bob Jones', 2),
(1003, 'Charlie Brown', 1);

INSERT INTO Course VALUES
('Database Systems', 1),
('Data Structures', 1),
('Linear Algebra', 2);

INSERT INTO Enrollment (StudentID, CourseID) VALUES
(1001, 1), -- Alice in Database Systems
(1001, 2), -- Alice in Data Structures
(1002, 3), -- Bob in Linear Algebra
(1003, 1); -- Charlie in Database Systems

SELECT 
    s.StudentID,
    s.StudentName,
    c.CourseName,
    f.FacultyName,
    d.DepartmentName
FROM Enrollment e
JOIN Student s ON e.StudentID = s.StudentID
JOIN Course c ON e.CourseID = c.CourseID
JOIN Faculty f ON c.FacultyID = f.FacultyID
JOIN Department d ON s.DepartmentID = d.DepartmentID
ORDER BY s.StudentID, c.CourseID;
