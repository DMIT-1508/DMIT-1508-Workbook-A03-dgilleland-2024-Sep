/* **********************************************
 * Simple Table Creation - Columns and Primary Keys
 *
 * School Transcript
 *  Version 1.0.0
 *
 * Author: Dan Gilleland
 ********************************************** */
-- Create the database
IF NOT EXISTS (SELECT name FROM master.sys.databases WHERE name = N'SchoolTranscript')
BEGIN
    CREATE DATABASE [SchoolTranscript]
END
GO

-- Switch execution context to the database
USE [SchoolTranscript] -- remaining SQL statements will run against the SchoolTranscript database
GO

-- Create Tables...
-- 1) Drop any tables that already exist
--    Always drop them in the reverse order
--    that you create them
DROP TABLE IF EXISTS StudentCourses
DROP TABLE IF EXISTS Courses
DROP TABLE IF EXISTS Students

-- 2) Setup/Create my tables
-- A CREATE TABLE statement contains a
-- comma-separated list of column definitions.
CREATE TABLE Students
(
    StudentID       int
        -- The CONSTRAINT keyword introduces some restrictions on the data that can be entered into this column.         
        CONSTRAINT PK_Students_StudentID
            PRIMARY KEY
            -- Primary Key constraints mean that a) you cannot
            -- have duplicate values and b) the value will be
            -- "indexed" to make it faster to find information
        IDENTITY(20250001, 3)    -- The first student will have the value 2025001
        -- Assign the database the responsibility to generate
        -- a value for this column (using the IDENTITY)
                                NOT NULL,
    GivenName       varchar(50)
        CONSTRAINT CK_Students_GivenName
            CHECK (GivenName LIKE '[A-Z][A-Z]%')
            -- Pattern Matching    \___/\___/\- % means zero or more characters
            --                       |- A single character ranging from A to Z
            -- Here are samples of values that would "pass" the check constraint
            --      'Bellum'
            --      'Yu'
            --      'Je55'
            -- The following would "fail" and prevent a row of data being entered
            --      'J'
            --      '5ally'
                                NOT NULL,
    Surname         varchar(50)
        CONSTRAINT CK_Student_Surname
            CHECK (Surname LIKE '__%')  -- Note the two underscores
            -- Pattern Matching: a single underscore _ means a single character
                                NOT NULL,
    DateOfBirth     datetime
        CONSTRAINT CK_Students_DateOfBirth
            CHECK (DateOfBirth < GETDATE())
            -- Relational Comparison to the results of the GETDATE() function
            -- The GETDATE() will return the current date/time
                                NOT NULL,
    Enrolled        bit
        CONSTRAINT DF_Students_Enrolled
            DEFAULT (1) -- If a value is not supplied for this column
                        -- during an INSERT, then the database server
                        -- will use this value as the default
                                NOT NULL
)

CREATE TABLE Courses
(
    [Number]    varchar(10)
        CONSTRAINT PK_Courses_Number
            PRIMARY KEY
        CONSTRAINT CK_Courses_Number
            CHECK ([Number] LIKE '[a-z][a-z][a-z][a-z][- ][1-9][0-9][0-9][0-9]%')
            --                    \ four letter      /\  /\ four digits      /
                                NOT NULL,
    [Name]      varchar(50)
        CONSTRAINT CK_Courses_Name
            CHECK (LEN([Name]) >= 5)
            -- The LEN() function will return the number of characters
                                NOT NULL,
    Credits     decimal(3, 1)
        CONSTRAINT CK_Courses_Credits
            CHECK (Credits = 3.0 OR Credits = 4.5 OR Credits = 6.0)
                                NOT NULL,
    [Hours]     tinyint
        CONSTRAINT CK_Courses_Hours
            CHECK ([Hours] IN (60, 75, 90, 120))
            -- As long as [Hours] matches one of these, it's acceptable
                                NOT NULL,
    Active      bit
        CONSTRAINT DF_Courses_Active
            DEFAULT (1)
                                NOT NULL,
    [Cost]      money
        CONSTRAINT CK_Courses_Cost
            CHECK (Cost >= 0)   -- Always indicating the acceptable value
                                NOT NULL
)

/*
StudentCourses table
 Year must be between 2000 and 2299
 Term must be either "SEP", "JAN" or "MAY"
 FinalMark must be between 0 and 100
 Status must be either 'W', 'E', or 'A' (Withdrawal, Enrolled, or Audit) and must default to 'E'
*/
CREATE TABLE StudentCourses
(
    StudentID       int
        CONSTRAINT FK_StudentCourses_StudentID
            FOREIGN KEY REFERENCES Students(StudentID)
                                NOT NULL,
    CourseNumber    varchar(10)
        CONSTRAINT FK_StudentCourses_CourseNumber
            FOREIGN KEY REFERENCES Courses([Number])
                                NOT NULL,
    [Year]          smallint
        CONSTRAINT CK_StudentCourses_Year
            CHECK ([Year] BETWEEN 2000 AND 2299)
                                NOT NULL,
    Term            char(3)
        CONSTRAINT CK_StudentCourses_Term
            CHECK (Term IN ('SEP', 'JAN', 'MAY'))
                                NOT NULL,
    FinalMark       tinyint
        CONSTRAINT CK_StudentCourses_FinalMark
            CHECK (FinalMark BETWEEN 0 AND 100)
                                    NULL,
    [Status]        char(1)
        CONSTRAINT CK_StudentCourses_Status
            CHECK ([Status] IN ('W', 'E', 'A'))
        CONSTRAINT DF_StudentCourses_Status
            DEFAULT ('E')
                                NOT NULL,
    -- In order to create a constraint that involves two or more columns,
    -- you have to put those "separate" in your CREATE TABLE as a
    -- table-level constraint
    CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
        PRIMARY KEY (StudentID, CourseNumber)
)

/*
    Once our database is deployed into production, we can
    expect data to be entered into our tables. But what if
    we need to make changes to the schema/structure of our
    tables? We can't (shouldn't) DROP TABLE, because we will
    lose all of the data.

    SELECT * FROM Students

    To solve this, we use the ALTER TABLE statement.
*/

-- A) Modify the Students table to include an optional
--    column for the MiddleNames (max of 75 characters)
ALTER TABLE Students
    ADD MiddleNames  varchar(75)     NULL
--  By having this as NULL, it will not cause a conflict
--  with existing data in the database

-- B) Also create a column named GPA that is a decimal(3,1).
ALTER TABLE Students
    ADD GPA         decimal(3, 1)   NULL

-- C) Double the size of the Surname column. This is to
--    better accommodate students with hypenated surnames.
ALTER TABLE Students
    ALTER COLUMN Surname    varchar(100)    NOT NULL
-- Notice that we are modifying an existing column in the
-- table, and that it was already `NOT NULL`. We can keep
-- this aspect of the column being required (NOT NULL)

-- D) Add a column to the Courses table for the Semester.
--    Store the Semester number as a tinyint. Allow it to
--    be NULL. Also ensure that the values have to be
--    between 1 and 4.
ALTER TABLE Courses
    ADD Semester    tinyint         NULL
        CONSTRAINT CK_Courses_Semester
            CHECK (Semester BETWEEN 1 and 4)

-- E) We want to indicate if a course is available for
--    "Open Studies". Open Studies courses are ones that
--    Students can take without having to be enrolled in
--    the entire Program of Studies.
ALTER TABLE Courses
    ADD [OpenStudies]   bit     NOT NULL
        CONSTRAINT DF_Courses_OpenStudies
            DEFAULT (0)
-- Because we have a default value that the database
-- can use, we can make this column required (NOT NULL)
-- and the database will simply put the default value
-- into that column for all the pre-existing rows of data.

/*
    In our database, we are able to create INDEXes that
    make our searching/modifying faster.
*/

CREATE NONCLUSTERED INDEX IX_StudentCourses_StudentID
    ON StudentCourses(StudentID)

CREATE NONCLUSTERED INDEX IX_StudentCourses_CourseNumber
    ON StudentCourses(CourseNumber)
    