# CareerLens – Google SQL Project  

## Goal  
Analyze 50k career/job records using SQL to extract actionable insights about job trends, hiring patterns, and career growth.  

##  Dataset  
- **Size:** 50,000 rows  
- **Format:** Excel (`.xlsx`) → imported into MySQL  
- **Content:** job title, skills, salary, experience, region, company info, etc.  
- **Type:** Synthetic but realistic dataset designed for analysis  

##  SQL Techniques Used  
- Joins (INNER, LEFT, RIGHT)  
- Aggregations (SUM, COUNT, AVG, MAX, MIN)  
- Subqueries   
- Window Functions 

## 💡 Business Insights  
- Identified top industries hiring the most candidates  
- Conversion Rate of Applicants to Offers
- Analyzed top Companies Posting Jobs  
- Locations with Highest Offer Conversion
- Experience Level vs Offer Rate  

## 🗂️ Project Files  
- `careerlens_google_db.xlsx` → Cleaned Dataset  
- `CareerLens Google - SQL - Project.sql` → SQL queries (basic → advanced)  
- `CareerLens_ER_Diagram.png` → Database schema (ER diagram)  
- `README.md` → Project summary & documentation  

## 📈 ER Diagram  
![ER Diagram](https://github.com/Aastha-collab/CareerLens-Google--SQL-Project/blob/fd1674ac696609bf2b2164b53625deea0836b556/Careerlens_ER%20Diagram.png)  

##  How to Run  
1. Import the `.xlsx` file into MySQL Workbench.  
2. Execute queries from the `.sql` file.  
3. Visualize database structure with the ER diagram.    

## Queries + Insights 
eg- Locations with Highest Offer Conversion

SELECT jp.Location,
SUM(CASE WHEN a.Application_Status = 'Offered' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Offer_Rate
FROM Job_Postings jp
JOIN Applicants a ON jp.Job_ID = a.Applied_Job_ID
GROUP BY jp.Location
ORDER BY Offer_Rate DESC;

-- Insight: London offer rate is the highest.

eg- Top Companies Posting Jobs

SELECT Company, COUNT(*) AS Jobs
FROM job_postings
GROUP BY Company
ORDER BY Jobs DESC;

-- Insight: Among all the google brands, you tube is the top Company posting Jobs.
