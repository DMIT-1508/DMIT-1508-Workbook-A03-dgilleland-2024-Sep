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
            -- Primary Key constraints
            -- mean that a) you cannot
            -- have duplicate values and
            -- b) the value will be
            -- "indexed" to make it faster
            -- to find information
                                NOT NULL,
    GivenName       varchar(50) NOT NULL,
    Surname         varchar(50) NOT NULL,
    DateOfBirth     datetime    NOT NULL,
    Enrolled        bit         NOT NULL
)

CREATE TABLE Courses
(
    [Number]    varchar(10)
        CONSTRAINT PK_Courses_Number
            PRIMARY KEY
                                NOT NULL,
    [Name]      varchar(50)     NOT NULL,
    Credits     decimal(3, 1)   NOT NULL,
    [Hours]     tinyint         NOT NULL,
    Active      bit             NOT NULL,
    [Cost]      money           NOT NULL
)

CREATE TABLE StudentCourses
(
    StudentID       int         NOT NULL,
    CourseNumber    varchar(10) NOT NULL,
    [Year]          smallint    NOT NULL,
    Term            char(3)     NOT NULL,
    FinalMark       tinyint         NULL,
    [Status]        char(1)     NOT NULL,
    -- In order to create a constraint
    -- that involves two or more columns,
    -- you have to put those "separate"
    -- in your CREATE TABLE as a
    -- table-level constraint
    CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
        PRIMARY KEY (StudentID, CourseNumber)
)
