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
SELECT DISTINCT SkillKey AS PrimaryKey, 
Skill
from Jobs.tblJobs;

SELECT * FROM JOBS.TBLSKILLS;

DROP TABLE IF EXISTS Jobs.tblJobsXwalk;

CREATE TABLE Jobs.tblJobsXwalk AS
SELECT DISTINCT JobTitle, Company, Location
from Jobs.tblJobs;

alter table Jobs.tbljOBSXWALK add column JOBID int(10) unsigned primary KEY AUTO_INCREMENT;

SELECT * FROM JOBS.TBLJOBSXWALK;

DROP TABLE IF EXISTS Jobs.tblCompanies;

CREATE TABLE Jobs.tblCompanies AS
SELECT DISTINCT Company
from Jobs.tblJobs;

alter table Jobs.tblCOMPANIES add column COMPID int(10) unsigned primary KEY AUTO_INCREMENT;

SELECT * FROM JOBS.TBLCOMPANIES;


DROP TABLE IF EXISTS Jobs.tblLocations;

CREATE TABLE Jobs.tblLocations AS
SELECT DISTINCT Location
from Jobs.tblJobs;

alter table Jobs.tblLOCATIONS add column LOCID int(10) unsigned primary KEY AUTO_INCREMENT;

SELECT * FROM JOBS.TBLLOCATIONS;

SET GLOBAL connect_timeout=300;
SET GLOBAL wait_timeout=28800;
SET GLOBAL interactive_timeout=28800;
SET GLOBAL net_read_timeout=6000;

drop table IF EXISTS jobs.output_for_r;


CREATE TABLE JOBS.OUTPUT_FOR_R AS
SELECT 
A.SKILL, B.PRIMARYKEY AS SKILLKEY, A.JOBTITLE, C.JOBID, A.COMPANY, D.COMPID,
A.LOCATION, E.LOCID FROM
(SELECT DISTINCT SKILL, JOBTITLE, COMPANY, LOCATION
FROM JOBS.TBLJOBS) AS A INNER JOIN JOBS.TBLSKILLS AS B ON A.SKILL=B.SKILL 
INNER JOIN JOBS.TBLJOBSXWALK AS C ON A.JOBTITLE=C.JOBTITLE and A.COMPANY=C.COMPANY AND
A.LOCATION=C.LOCATION INNER JOIN
JOBS.TBLCOMPANIES AS D ON A.COMPANY=D.COMPANY INNER JOIN
JOBS.TBLLOCATIONS AS E ON A.LOCATION=E.LOCATION;

alter table Jobs.OUTPUT_FOR_R add column ID int(10) unsigned primary KEY AUTO_INCREMENT;

SELECT * FROM JOBS.OUTPUT_FOR_R;

DESC jobs.output_for_r;

