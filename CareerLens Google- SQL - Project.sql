-- Project Name: CareerLens – A SQL-Powered Career Insights Platform 
-- Goal: Build a SQL-powered career insight engine using job, applicant and skills data 
-- Objective: Help job seekers discover in-demand skills, career paths and hiring trends from Google-related datasets 
-- Data: Simulated multi-sheet dataset (Job_Postings, Applicants, Skills_Demand ~50k rows each).

CREATE DATABASE CareerLens;
USE CareerLens;

-- CREATING TABLES 
CREATE TABLE job_postings(
   Job_ID INT PRIMARY KEY,
   Job_Title VARCHAR(100),
   Company VARCHAR(50),
   Location VARCHAR(50),
   Skills VARCHAR(100),
   Posting_Date DATE 
);

CREATE TABLE Applicants_detail(
   Applicant_ID INT PRIMARY KEY,
   Name VARCHAR(100),
   Applied_Job_ID INT,
   Experience VARCHAR(50),
   Degree VARCHAR(100),
   Application_Status VARCHAR(30),
   FOREIGN KEY (Applied_Job_ID) REFERENCES job_postings(Job_ID)
);

CREATE TABLE Skills_Demand(
    Skill VARCHAR (50) PRIMARY KEY,
    Demand_Count INT
);

-- IMPORTED DATA
SELECT * FROM job_posting_new; 
SELECT * FROM job_postings;
SELECT * FROM applicants;
SELECT * FROM skills_demand_new;

-- Making both the tables equal
INSERT INTO job_postings
(Job_ID, Job_Title, Company, Location, Skills, Posting_Date)
SELECT Job_ID, Job_Title, Company, Location, Skills, Posting_Date
FROM job_posting_new;

-- Verified
SELECT COUNT(*) FROM job_postings;
SELECT COUNT(*) FROM job_posting_new;

INSERT INTO Applicants_detail
(Applicant_ID, Name, Applied_Job_ID, Experience, Degree, Application_Status)
SELECT Applicant_ID, Name, Applied_Job_ID, Experience, Degree, Application_Status 
FROM applicants;

-- Verified
SELECT COUNT(*) FROM Applicants_detail;
SELECT COUNT(*) FROM applicants;

INSERT INTO Skills_Demand
(Skill, Demand_Count)
SELECT Skill, Demand_Count
FROM skills_Demand_new;

-- Verified
SELECT COUNT(*) FROM skills_demand;
SELECT COUNT(*) FROM skills_demand_new;

-- QUERIES 
-- 1. Top 10 Most Demanded Job Roles at Google
SELECT job_title, COUNT(*) AS Total_postings
FROM job_postings
GROUP BY job_title
ORDER BY Total_postings DESC
LIMIT 10; 
-- Insight: Google is actively recruiting cloud engineers the most. 

-- 2. Most Popular Locations for Google Jobs
SELECT Location, Count(*) as popular_location
FROM job_postings
GROUP BY Location
ORDER BY popular_location DESC;
-- Insight: Singapore is the most popular location where google is expanding. 

-- 3. Skills by job role
SELECT Job_Title, Skills, COUNT(*) AS Frequency
FROM Job_Postings
GROUP BY Job_Title, Skills
ORDER BY Frequency DESC;
-- Insight: It give insights on the skills associated with each Google job role.

-- 4. Most Competitive Roles (Applications per Job Posting)
SELECT jp.Job_Title, COUNT(a.Applicant_ID) / COUNT(DISTINCT jp.Job_ID) AS Avg_Applicants_Per_Job
FROM Job_Postings jp
JOIN Applicants a 
ON jp.Job_ID = a.Applied_Job_ID
GROUP BY jp.Job_Title
ORDER BY Avg_Applicants_Per_Job DESC;
-- Insight: Software Engineers have the highest competition.

-- 5. Conversion Rate of Applicants to Offers
SELECT Application_status, COUNT(*) AS count
FROM applicants
GROUP BY Application_Status
ORDER BY count;
-- Insight: Out of 12494 applications only 12595 received the offer letter means offers > applications which shows the data is not correct we need to fix it. 

-- 6. Which Degrees Perform Best in Applications
SELECT Degree, count(*) AS Applications, 
SUM(CASE WHEN Application_Status = 'Offered' THEN 1 ELSE 0 END) AS Offers
FROM Applicants
GROUP BY Degree
ORDER BY Offers DESC; 
-- Insight: It reveals MSc AI candidate yield the highest offer rates.

-- 7. Experience Level vs Offer Rate
SELECT Experience,
Sum(CASE WHEN Application_Status = 'Offered' THEN 1 ELSE 0 END) * 100/ count(*) AS offer_rate
FROM applicants
GROUP BY Experience
ORDER BY offer_rate DESC;
-- Insight: Google prefers both fresher and experienced hires but more to the experienced candidate.

-- 8. Most Applied Job Roles
SELECT jp.Job_Title, COUNT(a.Applicant_ID) AS Applications
FROM Applicants a
JOIN Job_Postings jp ON a.Applied_Job_ID = jp.Job_ID
GROUP BY jp.Job_Title
ORDER BY Applications DESC;
-- Insight: Cloud Engineer which is demanding role by google attract the most interest from applicants.

-- 9. Top Companies Posting Jobs
SELECT Company, COUNT(*) AS Jobs
FROM job_postings
GROUP BY Company
ORDER BY Jobs DESC;
-- Insight: Among all the google brands, you tube is the top Company posting Jobs.

-- 10. Locations with Highest Offer Conversion
SELECT jp.Location,
SUM(CASE WHEN a.Application_Status = 'Offered' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Offer_Rate
FROM Job_Postings jp
JOIN Applicants a ON jp.Job_ID = a.Applied_Job_ID
GROUP BY jp.Location
ORDER BY Offer_Rate DESC;
-- Insight: London offer rate is the highest.

-- END OF THE PROJECT --