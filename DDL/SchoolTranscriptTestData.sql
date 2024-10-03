/*
    Database scripts execute within a certain context - a
    specific database. We can change the context through
    the USE statement.
*/
SELECT DB_NAME() AS 'Initial Database'
GO
USE [SchoolTranscript]
GO
SELECT DB_NAME() AS 'Active Database'
GO

-- Let's create some test data to see what happens with our
-- database design.
INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES  ('Sara', 'Bellum', 'Aug 1, 2005', 1),
        ('Steward', 'Dent', 'July 23, 2003', 1)

INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES  ('Anne', 'Other', 'Nov 3, 2004')
GO  -- The GO keyword tells the database server to GO ahead and make these changes

-- Here's a sample of some bad data
INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES  ('Oh', 'No', 'Feb 5, 2045') -- This is a bad date

-- Explore the results (Query statement)
SELECT * FROM Students

