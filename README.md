# Gradebook Database Project

### Problem Statement

You are asked to implement a grade book to keep track of student grades for several courses that a professor teaches. Courses should have the information of department, course number, course name, semester, and year. For each course, the grade is calculated on various categories, including course participations, homework, tests, projects, etc. The total percentages of the categories should add to 100%, and the total perfect grade should be 100. The number of assignments from each category is unspecified and can change at any time. For example, a course may be graded by the distribution: 10% participation, 20% homework, 50% tests, 20% projects. Please note that if there are 5 homework assignments, each homework is worth 20%/5=4% of the grade.

### Tasks

1. Design the ER diagram.
2. Write the commands for creating tables and inserting values.
3. Show the tables with the contents that you have inserted.
4. Compute the average/highest/lowest score of an assignment.
5. List all of the students in a given course.
6. List all of the students in a course and all of their scores on every assignment.
7. Add an assignment to a course.
8. Change the percentages of the categories for a course.
9. Add 2 points to the score of each student on an assignment.
10. Add 2 points just to those students whose last name contains a ‘Q’.
11. Compute the grade for a student.
12. Compute the grade for a student, where the lowest score for a given category is dropped.

## MySQL Setup and Connection to VS Code Using Database Client

The following is a guide on how to install MySQL, create a database, and connect it to Visual Studio Code using the "Database Client" extension with JDBC. This was the way we chose to run our code. Note: All group members have MacOS so the following instructions are for MacOS.

### Installing MySQL

1. **Download MySQL Installer**: Go to the [MySQL Downloads](https://dev.mysql.com/downloads/) page and select the MySQL Community Server. Choose the version that is appropriate for your operating system.

2. **Run the Installer**: Open the downloaded installer file and follow the installation prompts. During the installation process, set a root password when prompted. Make a note of this password as it will be required later to manage databases.

3. **Complete the Setup**: Finish the installation by following the setup wizard's instructions. It may include setting up MySQL as a service that starts on boot.

#### Finding the MySQL Installation

1. **Default Installation Path**: After installation, MySQL is typically located in one of the following directories, depending on your operating system:
   - On macOS: `/usr/local/mysql/bin`

2. **Add to Path**: Run this command to add the default installation path to your path: 
   - On macOS: `export PATH="/usr/local/mysql/bin:$PATH"`

3. **Verify Installation**: You can verify that MySQL is running by opening your terminal (or Command Prompt on Windows) and typing `mysql -u root -p`, then entering the password you set during installation.

#### Creating a Database

1. **Access the MySQL Shell**: After opening the MySQL command-line tool, create a new database by running:
   ```sql
   CREATE DATABASE gradebook_db;
   ```
   Note: Make the database name "gradebook_db" for code extensive purposes.

### Adding VScode Extensions

To manage your MySQL databases directly within Visual Studio Code, you'll need to install two extensions: `Database Client JDBC` and `MySQL`. These extensions allow you to connect to and interact with your MySQL databases through a user-friendly interface. 

#### Installing the Required Extensions

1. **Open Visual Studio Code**: Launch the application on your computer.

2. **Access the Extensions Marketplace**:
    - Click on the Extensions icon on the sidebar, or use the shortcut `Cmd+Shift+X` on macOS.

3. **Search for Extensions**:
    - Type `Database Client JDBC` into the search bar and find the extension by Weijan Chen.
    - Click the `Install` button to install the extension.
    - Repeat the search and installation process for the `MySQL` extension.

4. **Confirm Installation**:
    - After installation, the extensions should appear in the Extensions sidebar. You can click on them to manage their settings or view more information.

#### Connecting Database Client JDBC to Your MySQL Database

1. **Open Command Palette**:
    - Use the shortcut `Ctrl+Shift+P` on Windows/Linux or `Cmd+Shift+P` on macOS to open the Command Palette.

2. **Initiate Connection**:
    - Type `Database Client: Add New Connection` and select the option to open the connection configuration pane.

3. **Configure Database Connection**:
    - Choose `MySQL` as the database type.
    - Enter your MySQL connection details including hostname (often `localhost` or `127.0.0.1` if running on the same machine), port (usually `3306`), user (like `root`), and the password you set during installation.
    - If you've created a specific database already, you can enter its name; otherwise, you can connect to the default MySQL database to execute further operations like creating a new database. FOR THE SAKE OF THIS PROJECT, use the database name from earlier `gradebook_db`.

4. **Save and Test Connection**:
    - Save the configuration. The extension should automatically attempt to connect to your MySQL server with the provided details.
    - If the connection is successful, you will see the database and its schemas listed in the `DATABASE` panel, typically on the sidebar of VS Code.

#### Run Code

With the extension set up, you can now run our sql files on your computer. Open up the files in vscode, then right-click inside the file. Press on 'Run all SQL' or 'Run all SQL in Editor' to run the whole file. If you'd like to run selective parts, just highlight the part and right-click or click on the 'Execute' play button on top of the selected part to run it.

## SUBMISSION
1. The ER diagram (with the attributes and foreign keys/primary keys indicated);
   - Can be found in the github, titled **ER Diagram.png**
2. The commands for creating tables and inserting values (task 2);
   - Can be found below as well as in the **gradebook.sql** file.
3. The tables with the contents that you have inserted (task 3);
   - Screenshots of the tables can be found in the **tables** folder. Each screenshot is labeled according to the table.
4. The command that you use to get task 4, 5, 6, 7, 8, 9, 10, 11, 12;
   - Can be found below as well as in **testcases.sql** file.
5. The source code;
6. A README file. The minimum required content of the file should contains the instructions to compile and execute your code;
7. The test cases that you use and the results that you get from the test cases.
   - Test cases code can be found in **testcases.sql** file.
   - The results from the test cases can be found in the **testcase results** folder containing screenshots of the results. Each screenshot is labeled according to the task results it shows.

### Commands for Creating Tables

Courses Table:
```sql
CREATE TABLE Courses (
    CourseID INT NOT NULL AUTO_INCREMENT,
    Department VARCHAR(50),
    CourseNumber VARCHAR(10),
    CourseName VARCHAR(100),
    Semester VARCHAR(10),
    Year INT,
    PRIMARY KEY (CourseID)
);
```

Students Table:
```sql
CREATE TABLE Students (
    StudentID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    PRIMARY KEY (StudentID)
);
```

Enrollment Table:
```sql
CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
```

Assignments Table:
```sql
CREATE TABLE Assignments (
    AssignmentID INT NOT NULL AUTO_INCREMENT,
    CourseID INT,
    AssignmentName VARCHAR(255),
    Category VARCHAR(50),
    Weight FLOAT,
    PRIMARY KEY (AssignmentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

```

Scores Table:
```sql
-- Table for scores on assignments
CREATE TABLE Scores (
    AssignmentID INT,
    StudentID INT,
    Score FLOAT,
    PRIMARY KEY (AssignmentID, StudentID),
    FOREIGN KEY (AssignmentID) REFERENCES Assignments(AssignmentID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
```

### Commands for inserting values

Inserting Course data:
```sql
INSERT INTO Courses (Department, CourseNumber, CourseName, Semester, Year) VALUES
('Math', 'M101', 'Calculus I', 'Fall', 2024),
('Science', 'SCI103', 'Biology', 'Fall', 2024),
('English Language Arts', 'ELA105', 'Essay Writing', 'Fall', 2024),
('History', 'HIST107', 'US History', 'Fall', 2024);
```

Inserting Student data:
```sql
INSERT INTO Students (FirstName, LastName) VALUES
('John', 'Doe'),
('Anna', 'Bell'),
('April', 'Jones'),
('John', 'Wick'),
('Tyler', 'Johnson'),
('Jane', 'Doe');
```

Inserting Enrollment data:
```sql
INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 1),
(2, 1),
(2, 3),
(3, 3),
(3, 2),
(4, 2),
(5, 4),
(6, 4);
```

Inserting Assignment data:
```sql
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
```

Inserting Scores data:
```sql
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
```

### Commands for task 4 - 12

Task 4 Commands:
```sql
-- Task 4: Compute the average/highest/lowest score of an assignment;
-- Average score
SELECT AVG(Score) AS AverageScore FROM Scores WHERE AssignmentID = 1;
-- Highest score
SELECT MAX(Score) AS HighestScore FROM Scores WHERE AssignmentID = 1;
-- Lowest score
SELECT MIN(Score) AS LowestScore FROM Scores WHERE AssignmentID = 1;
```

Task 5 Commands:
```sql
-- Task 5: List all of the students in a given course;
-- List all students in Calculus I
SELECT s.StudentID, s.FirstName, s.LastName FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID = 1;
```

Task 6 Commands:
```sql
-- Task 6: List all of the students in a course and all of their scores on every assignment;
SELECT s.StudentID, s.FirstName, s.LastName, a.AssignmentName, sc.Score
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Assignments a ON e.CourseID = a.CourseID
JOIN Scores sc ON s.StudentID = sc.StudentID AND a.AssignmentID = sc.AssignmentID
WHERE e.CourseID = 1;
```

Task 7 Commands:
```sql
-- Task 7: Add an assignment to a course;
INSERT INTO Assignments (CourseID, AssignmentName, Category, Weight) VALUES
(2, 'Final Exam', 'Tests', 50.0);
```

Task 8 Commands:
```sql
-- Task 8: Change the percentages of the categories for a course;
UPDATE Assignments
SET Weight = 40.0
WHERE CourseID = 1 AND Category = 'Exam';
```

Task 9 Commands:
```sql
-- Task 9: Add 2 points to the score of each student on an assignment;
UPDATE Scores
SET Score = Score + 2
WHERE AssignmentID = 1;
```

Task 10 Commands:
```sql
-- Task 10: Add 2 points just to those students whose last name contains a ‘Q’.
UPDATE Scores
SET Score = Score + 2
WHERE StudentID IN (
    SELECT StudentID FROM Students WHERE LastName LIKE '%Q%'
) AND AssignmentID = 1;
```

Task 11 Commands:
```sql
-- Task 11: Compute the grade for a student;
SELECT StudentID, SUM(Score * Weight / 100) AS TotalGrade
FROM Scores
JOIN Assignments ON Scores.AssignmentID = Assignments.AssignmentID
WHERE StudentID = 1
GROUP BY StudentID;
```

Task 12 Commands:
```sql
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
```
