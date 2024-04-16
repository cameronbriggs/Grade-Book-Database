USE gradebook_db;

-- Courses
DROP TABLE IF EXISTS Scores;
DROP TABLE IF EXISTS Assignments;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;

-- Table for storing course information
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    Department VARCHAR(50),
    CourseNumber VARCHAR(10),
    CourseName VARCHAR(100),
    Semester VARCHAR(10),
    Year INT
);

-- Table for storing student information
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Table for enrolling students in courses
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Table for assignments in each course
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY,
    CourseID INT,
    AssignmentName VARCHAR(100),
    Category VARCHAR(50),
    Weight FLOAT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Table for scores on assignments
CREATE TABLE Scores (
    ScoreID INT PRIMARY KEY,
    AssignmentID INT,
    StudentID INT,
    Score FLOAT,
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);


-- Insert course data
INSERT INTO Courses (CourseID, Department, CourseNumber, CourseName, Semester, Year) VALUES
(101, 'Math', 'M101', 'Calculus I', 'Fall', 2024);

INSERT INTO Courses(CourseID, Department, CourseNumber, CourseName, Semester, Year) VALUES
(103, 'Science', 'SCI103', 'Biology', 'Fall', 2024);

INSERT INTO Courses(CourseID, Department, CourseNumber, CourseName, Semester, Year) VALUES
(105, 'English Language Arts', 'ELA105', 'Essay Writing', 'Fall', 2024);

INSERT INTO Courses(CourseID, Department, CourseNumber, CourseName, Semester, Year) VALUES
(107, 'History', 'HIST107', 'US History', 'Fall', 2024);

-- Insert student data
INSERT INTO Students (StudentID, FirstName, LastName) VALUES
(1, 'John', 'Doe');

INSERT INTO Students (StudentID, FirstName, LastName) VALUES
(2, 'Anna', 'Bell');

INSERT INTO Students (StudentID, FirstName, LastName) VALUES
(3, 'April', 'Jones');

INSERT INTO Students (StudentID, FirstName, LastName) VALUES
(4, 'John', 'Wick');

INSERT INTO Students (StudentID, FirstName, LastName) VALUES
(5, 'Tyler', 'Johnson');

INSERT INTO Students (StudentID, FirstName, LastName) VALUES
(6, 'Jane', 'Doe');

-- Enroll a student in a course
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(1, 1, 101);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(2, 2, 101);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(3, 2, 103);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(4, 3, 103);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(5, 3, 105);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(6, 4, 105);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(7, 5, 107);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(8, 6, 107);

-- Add an assignment to a course
INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(1, 101, 'Midterm Exam', 'Tests', 25.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(2, 101, 'Final Exam', 'Test', 25.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(3, 101, 'Project', 'Projects', 20.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(4, 101, 'Homework', 'Homeworks', 20.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(5, 101, 'Paticipation', 'Participation', 10.0)

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(6, 103, 'Midterm Exam', 'Tests', 25.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(7, 103, 'Final Exam', 'Test', 25.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(8, 103, 'Project', 'Projects', 20.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(9, 103, 'Homework', 'Homeworks', 20.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(10, 103, 'Participation', 'Participation', 10.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(11, 105, 'Midterm Exam', 'Test', 25.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(12, 105, 'Final Exam', 'Test', 25.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(13, 105, 'Project', 'Projects', 20.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(14, 105, 'Homework', 'Homeworks', 20.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(15, 105, 'Participation', 'Participation', 10.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(16, 107, 'Midterm Exam', 'Test', 25.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(17, 107, 'Final Exam', 'Test', 25.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(18, 107, 'Project', 'Projects', 20.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(19, 107, 'Homework', 'Homeworks', 20.0);

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(20, 107, 'Participation', 'Participation', 10.0);

-- Add scores for assignments
INSERT INTO Scores (ScoreID, AssignmentID, StudentID, Score) VALUES
(1, 1, 1, 88.0);

INSERT INTO Scores (ScoreID, AssignmentID, StudentID, Score) VALUES
(2, 2, 1, 75.0);



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
WHERE e.CourseID = 101;

-- Task 6: List all of the students in a course and all of their scores on every assignment;
SELECT s.StudentID, s.FirstName, s.LastName, a.AssignmentName, sc.Score
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Assignments a ON e.CourseID = a.CourseID
JOIN Scores sc ON s.StudentID = sc.StudentID AND a.AssignmentID = sc.AssignmentID
WHERE e.CourseID = 101;

-- Task 7: Add an assignment to a course;
INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, Category, Weight) VALUES
(2, 101, 'Final Exam', 'Tests', 50.0);

-- Task 8: Change the percentages of the categories for a course;
UPDATE Assignments
SET Weight = 40.0
WHERE CourseID = 101 AND Category = 'Tests';

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

-- Task 12: Compute the grade for a student, where the lowest score for a given category is dropped
WITH CategoryScores AS (
    SELECT s.StudentID, a.Category, sc.Score, a.Weight,
           ROW_NUMBER() OVER (PARTITION BY s.StudentID, a.Category ORDER BY sc.Score ASC) AS RankNum
    FROM Scores sc
    JOIN Assignments a ON sc.AssignmentID = a.AssignmentID
    JOIN Students s ON sc.StudentID = s.StudentID
    WHERE s.StudentID = 1
),
FilteredScores AS (
    SELECT StudentID, Score, Weight FROM CategoryScores WHERE RankNum > 1
)
SELECT StudentID, SUM(Score * Weight / 100) AS AdjustedGrade
FROM FilteredScores
GROUP BY StudentID;

