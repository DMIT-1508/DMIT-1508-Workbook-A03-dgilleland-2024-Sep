/*  TEST DATA
    Having test data that we can insert into our database tables
    will help us to ensure that our CREATE TABLE and ALTER TABLE statements
    are running correctly.
*/

-- Database scripts execute within a certain context - a specific database.
SELECT DB_NAME() AS 'Initial Database'  -- should be [master] when first executed
GO
-- We can change the context through the USE statement,ensuring that we're inside the correct database
USE [SchoolTranscript]  -- Switch to the desired database
GO  -- The GO keyword tells the database server to GO ahead and make these changes
SELECT DB_NAME() AS 'Active Database'   -- shows that we are in the correct database
GO


/*=== Start of Test Data ===*/

-- Add a single student (DML statement)
INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES  ('Sara', 'Bellum', 'Aug 1, 2005', 1)

-- Add multiple students (with default constraints)
INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES  ('Oliver', 'Nerr', 'April 1, 2001'), -- O. Nerr
        ('Stewart', 'Dent', 'July 23, 2003'), -- Stew Dent
        ('Yu', 'Sur', 'Feb 29, 2000'),
        ('Anne', 'Other', 'Nov 3, 2004'),
        ('Dee', 'Vellop-Ur', 'Dec 4, 1999')

/*
-- Add these students after altering the table constraints
INSERT INTO Students(GivenName, MiddleNames, Surname, DateOfBirth)
VALUES  ('Reginald', 'Ian', 'Stirr', 'Aug 1, 2005') -- Reg I. Stirr
*/

-- Explore the results (Query statement)
SELECT * FROM Students


/*
-- Samples of "bad" data (violates CHECK constraints)
INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES  ('B', '4', 'Aug 20, 2025', 1) -- Bad GivenName and Surname

INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES  ('Oh', 'No', 'Feb 5, 2045') -- This is a bad date

*/
