USE gradebook_db;

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

-- Task 12: Compute the grade for a student, excluding the lowest score in the 'Homework' category.
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
