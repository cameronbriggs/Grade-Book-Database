# Gradebook Database Project for Academic Courses

## Problem Statement

You are asked to implement a grade book to keep track of student grades for several courses that a professor teaches. Courses should have the information of department, course number, course name, semester, and year. For each course, the grade is calculated on various categories, including course participations, homework, tests, projects, etc. The total percentages of the categories should add to 100%, and the total perfect grade should be 100. The number of assignments from each category is unspecified and can change at any time. For example, a course may be graded by the distribution: 10% participation, 20% homework, 50% tests, 20% projects. Please note that if there are 5 homework assignments, each homework is worth 20%/5=4% of the grade.

## Tasks

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

# MySQL Setup and Connection to VS Code Using Database Client

The following is a guide on how to install MySQL, create a database, and connect it to Visual Studio Code using the "Database Client" extension with JDBC. This was the way we chose to run our code. Note: All group members have MacOS so the following instructions are for MacOS.

## Installing MySQL

1. **Download MySQL Installer**: Go to the [MySQL Downloads](https://dev.mysql.com/downloads/) page and select the MySQL Community Server. Choose the version that is appropriate for your operating system.

2. **Run the Installer**: Open the downloaded installer file and follow the installation prompts. During the installation process, set a root password when prompted. Make a note of this password as it will be required later to manage databases.

3. **Complete the Setup**: Finish the installation by following the setup wizard's instructions. It may include setting up MySQL as a service that starts on boot.

## Finding the MySQL Installation

1. **Default Installation Path**: After installation, MySQL is typically located in one of the following directories, depending on your operating system:
   - On macOS: `/usr/local/mysql/bin`

2. **Add to Path**: Run this command to add the default installation path to your path: 
   - On macOS: `export PATH="/usr/local/mysql/bin:$PATH"`

3. **Verify Installation**: You can verify that MySQL is running by opening your terminal (or Command Prompt on Windows) and typing `mysql -u root -p`, then entering the password you set during installation.

## Creating a Database

1. **Access the MySQL Shell**: After opening the MySQL command-line tool, create a new database by running:
   ```sql
   CREATE DATABASE gradebook_db;
   ```
   Note: Make the database name "gradebook_db" for code extensive purposes.


