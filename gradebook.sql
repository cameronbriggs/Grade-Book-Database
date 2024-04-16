USE gradebook_db;

-- Drop tables in the correct order
DROP TABLE IF EXISTS Scores;
DROP TABLE IF EXISTS Assignments;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;

-- Table for storing course information
CREATE TABLE Courses (
    CourseID INT NOT NULL AUTO_INCREMENT,
    Department VARCHAR(50),
    CourseNumber VARCHAR(10),
    CourseName VARCHAR(100),
    Semester VARCHAR(10),
    Year INT,
    PRIMARY KEY (CourseID)
);

CREATE TABLE Students (
    StudentID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    PRIMARY KEY (StudentID)
);

-- Table for enrolling students in courses
CREATE TABLE Enrollments (
    -- EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Assignments (
    AssignmentID INT NOT NULL AUTO_INCREMENT,
    CourseID INT,
    AssignmentName VARCHAR(255),
    Category VARCHAR(50),
    Weight FLOAT,
    PRIMARY KEY (AssignmentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Table for scores on assignments
CREATE TABLE Scores (
    -- ScoreID INT PRIMARY KEY,
    AssignmentID INT,
    StudentID INT,
    Score FLOAT,
    PRIMARY KEY (AssignmentID, StudentID),
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

INSERT INTO Courses (Department, CourseNumber, CourseName, Semester, Year) VALUES
('Math', 'M101', 'Calculus I', 'Fall', 2024),
('Science', 'SCI103', 'Biology', 'Fall', 2024),
('English Language Arts', 'ELA105', 'Essay Writing', 'Fall', 2024),
('History', 'HIST107', 'US History', 'Fall', 2024);

INSERT INTO Students (FirstName, LastName) VALUES
('John', 'Doe'),
('Anna', 'Bell'),
('April', 'Jones'),
('John', 'Wick'),
('Tyler', 'Johnson'),
('Jane', 'Doe');

-- Inserting enrollments without specifying EnrollmentID
INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 1),
(2, 1),
(2, 3),
(3, 3),
(3, 2),
(4, 2),
(5, 4),
(6, 4);

-- Inserting assignments without specifying AssignmentID
INSERT INTO Assignments (CourseID, AssignmentName, Category, Weight) VALUES
-- Course one
(1, 'Midterm Exam', 'Tests', 25.0),
(1, 'Final Exam', 'Test', 25.0),
(1, 'Project', 'Projects', 20.0),
(1, 'Homework 1', 'Homeworks', 5.0),
(1, 'Homework 2', 'Homeworks', 5.0),
(1, 'Homework 3', 'Homeworks', 5.0),
(1, 'Participation', 'Participation', 5.0),
-- Course three
(3, 'Midterm Exam', 'Tests', 25.0),
(3, 'Final Exam', 'Test', 25.0),
(3, 'Project', 'Projects', 20.0),
(3, 'Homework 1', 'Homeworks', 5.0),
(3, 'Homework 2', 'Homeworks', 5.0),
(3, 'Homework 3', 'Homeworks', 5.0),
(3, 'Participation', 'Participation', 5.0),
-- Course two
(2, 'Midterm Exam', 'Test', 25.0),
(2, 'Final Exam', 'Test', 25.0),
(2, 'Project', 'Projects', 20.0),
(2, 'Homework 1', 'Homeworks', 5.0),
(2, 'Homework 2', 'Homeworks', 5.0),
(2, 'Homework 3', 'Homeworks', 5.0),
(2, 'Participation', 'Participation', 5.0),
-- Course four
(4, 'Midterm Exam', 'Test', 25.0),
(4, 'Final Exam', 'Test', 25.0),
(4, 'Project', 'Projects', 20.0),
(4, 'Homework 1', 'Homeworks', 5.0),
(4, 'Homework 2', 'Homeworks', 5.0),
(4, 'Homework 3', 'Homeworks', 5.0),
(4, 'Participation', 'Participation', 5.0);

-- Inserting fake score data into the Scores table
INSERT INTO Scores (AssignmentID, StudentID, Score) VALUES
-- Scores for Course 1 (Students 1 and 2 are enrolled)
(1, 1, 84), (1, 2, 91),  -- Midterm Exam
(2, 1, 86), (2, 2, 90),  -- Final Exam
(3, 1, 90), (3, 2, 85),  -- Project
(4, 1, 81), (4, 2, 88),  -- Homework 1
(21, 1, 83), (21, 2, 88), -- Homework 2
(22, 1, 87), (22, 2, 91), -- Homework 3
(5, 1, 88), (5, 2, 92),  -- Participation

-- Scores for Course 3 (Students 2 and 3 are enrolled)
(6, 2, 85), (6, 3, 75),  -- Midterm Exam
(7, 2, 91), (7, 3, 76),  -- Final Exam
(8, 2, 84), (8, 3, 82),  -- Project
(9, 2, 87), (9, 3, 78),  -- Homework 1
(23, 3, 85), (23, 4, 89), -- Homework 2
(24, 3, 82), (24, 4, 92), -- Homework 3
(10, 2, 90), (10, 3, 83),-- Participation

-- Scores for Course 2 (Students 3 and 4 are enrolled)
(11, 3, 87), (11, 4, 92),  -- Midterm Exam
(12, 3, 84), (12, 4, 89),  -- Final Exam
(13, 3, 91), (13, 4, 86),  -- Project
(14, 3, 82), (14, 4, 90),  -- Homework 1
(25, 2, 84), (25, 3, 78), -- Homework 2
(26, 2, 90), (26, 3, 80), -- Homework 3
(15, 3, 89), (15, 4, 93),  -- Participation

-- Scores for Course 4 (Students 5 and 6 are enrolled)
(16, 5, 83), (16, 6, 90),  -- Midterm Exam
(17, 5, 86), (17, 6, 92),  -- Final Exam
(18, 5, 88), (18, 6, 83),  -- Project
(19, 5, 85), (19, 6, 89),  -- Homework 1
(27, 5, 86), (27, 6, 92), -- Homework 2
(28, 5, 89), (28, 6, 94), -- Homework 3
(20, 5, 90), (20, 6, 94);  -- Participation
