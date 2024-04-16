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
('Computer Science', 'CS101', 'Intro to Programming', 'Fall', 2024),
('Mathematics', 'MA201', 'Calculus I', 'Spring', 2024),
('Literature', 'LT301', 'American Literature', 'Fall', 2024),
('Physics', 'PH101', 'General Physics', 'Spring', 2024);

INSERT INTO Students (FirstName, LastName) VALUES
('John', 'Doe'),
('Jane', 'Smith'),
('Alice', 'Johnson'),
('Bob', 'Brown');

INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 1),
(2, 1),
(1, 2),
(3, 3),
(4, 4);

INSERT INTO Assignments (CourseID, AssignmentName, Category, Weight) VALUES
(1, 'Homework 1', 'Homework', 10),
(1, 'Project 1', 'Project', 20),
(1, 'Participation', 'Participation', 70),
(2, 'Midterm Exam', 'Exam', 30),
(3, 'Essay', 'Homework', 25),
(4, 'Lab Report', 'Lab', 15);


INSERT INTO Scores (AssignmentID, StudentID, Score) VALUES
(1, 1, 85),
(1, 2, 90),
(2, 1, 88),
(3, 3, 92),
(4, 4, 75),
(3, 1, 75);

-- Task 4: Compute the average/highest/lowest score of an assignment;
-- Average score
SELECT AVG(Score) AS AverageScore FROM Scores WHERE AssignmentID = 1;
-- Highest score
SELECT MAX(Score) AS HighestScore FROM Scores WHERE AssignmentID = 1;
-- Lowest score
SELECT MIN(Score) AS LowestScore FROM Scores WHERE AssignmentID = 1;

-- Task 5: List all of the students in a given course; ???
-- List all students in Calculus I
SELECT s.StudentID, s.FirstName, s.LastName FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID = 1;

-- Task 6: List all of the students in a course and all of their scores on every assignment;
SELECT s.StudentID, s.FirstName, s.LastName, a.AssignmentName, sc.Score
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Assignments a ON e.CourseID = a.CourseID
JOIN Scores sc ON s.StudentID = sc.StudentID AND a.AssignmentID = sc.AssignmentID
WHERE e.CourseID = 1;

-- Task 7: Add an assignment to a course;
INSERT INTO Assignments (CourseID, AssignmentName, Category, Weight) VALUES
(2, 'Final Exam', 'Tests', 50.0);


-- Task 8: Change the percentages of the categories for a course;
UPDATE Assignments
SET Weight = 40.0
WHERE CourseID = 1 AND Category = 'Exam';

-- Task 9: Add 2 points to the score of each student on an assignment;
UPDATE Scores
SET Score = Score + 2
WHERE AssignmentID = 1;

-- Task 10: Add 2 points just to those students whose last name contains a ‘Q’.
UPDATE Scores
SET Score = Score + 2
WHERE StudentID IN (
    SELECT StudentID FROM Students WHERE LastName LIKE '%Q%'
) AND AssignmentID = 1;

-- Task 11: Compute the grade for a student;
SELECT StudentID, SUM(Score * Weight / 100) AS TotalGrade
FROM Scores
JOIN Assignments ON Scores.AssignmentID = Assignments.AssignmentID
WHERE StudentID = 1
GROUP BY StudentID;

-- Compute the grade for a student, excluding the lowest score in the 'Homework' category.
SELECT
    s.StudentID,
    SUM(CASE 
            WHEN a.Category = 'Homework' AND sc.Score > (
                SELECT MIN(Score)
                FROM Scores sc2
                JOIN Assignments a2 ON sc2.AssignmentID = a2.AssignmentID
                WHERE a2.Category = 'Homework'
                AND sc2.StudentID = s.StudentID
            ) THEN sc.Score * a.Weight / 100
            WHEN a.Category != 'Homework' THEN sc.Score * a.Weight / 100
            ELSE 0
        END) AS AdjustedGrade
FROM Students s
JOIN Scores sc ON s.StudentID = sc.StudentID
JOIN Assignments a ON sc.AssignmentID = a.AssignmentID
GROUP BY s.StudentID;

