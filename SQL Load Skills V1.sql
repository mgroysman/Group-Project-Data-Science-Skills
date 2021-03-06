/* Author - Mikhail Groysman, CUNY Master of Data Science Student 

   Date 10/20/2018 

   3rd project; Team project; 2018 Fall Term Acquisition and Management DATA 607 

   Loading Data Science Jobs in MySQL */





CREATE DATABASE Jobs;



DROP TABLE IF EXISTS Jobs.tblJobs;



CREATE TABLE Jobs.tblJobs

(

  Counter int not NULL,

  SkillKey int not NULL, 	/* Skill key*/

  Skill varchar(50) NOT NULL, 	/* Skill */

  JobCounter int NOT NULL, 	/* Job counter for the skill */

  JobTitle varchar(300) NOT NULL, 	/* Job Title */

  Company varchar(100) NOT NULL,     /* Company name */

  Location varchar(150) NOT NULL,    /* Location of the company*/

  Summary varchar(10000) NULL  /* Job description - incomplete */

);

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Skills.csv"
INTO TABLE Jobs.tblJobs
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY "\r\n"
IGNORE 1 ROWS;

DROP TABLE IF EXISTS Jobs.tblSkills;

CREATE TABLE Jobs.tblSkills AS
SELECT DISTINCT SkillKey as PrimaryKey, Skill
from Jobs.tblJobs;

DROP TABLE IF EXISTS Jobs.tblJobsXwalk;

CREATE TABLE Jobs.tblJobsXwalk AS
SELECT DISTINCT JobTitle, Company, Location
from Jobs.tblJobs;

DROP TABLE IF EXISTS Jobs.tblCompanies;

CREATE TABLE Jobs.tblCompanies AS
SELECT DISTINCT Company
from Jobs.tblJobs;

DROP TABLE IF EXISTS Jobs.tblLocations;

CREATE TABLE Jobs.tblLocations AS
SELECT DISTINCT Location
from Jobs.tblJobs;

SELECT * FROM Jobs.Skills;




