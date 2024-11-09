USE portfolio; 

SELECT * FROM loan;


-- Count Total Loan Applications
SELECT COUNT(*) AS Total_Application
FROM loan;
   


-- Average Loan Amount by Employment Status
SELECT Employment_Status, AVG(Loan_Amount) AS Average_Loan_Amount
FROM loan
GROUP BY Employment_Status;
   


-- Average Credit Score by Education Level
SELECT Education_Level, AVG(Credit_Score) AS Average_Credit_Score
FROM loan
GROUP BY Education_Level;



-- Loan Approval Rate by Marital Status
SELECT Marital_Status, 
	COUNT(CASE WHEN Loan_Approved = 1 THEN 1 END) AS Approved,
	COUNT(*) AS Total,
	(COUNT(CASE WHEN Loan_Approved = 1 THEN 1 END) * 100.0 / COUNT(*)) AS Approval_Rate
FROM loan
GROUP BY Marital_Status;
   


-- Total Loan Amounts by Loan Purpose
SELECT Loan_Purpose, SUM(Loan_Amount) AS Total_Loan_Amount
FROM loan
GROUP BY Loan_Purpose;



--  Average Debt-to-Income Ratio for Approved Loans
SELECT AVG(Debt_To_Income_Ratio) AS Average_DTI
FROM loan
WHERE Loan_Approved = 1;



-- Count of Previous Loan Defaults by Employment Status
SELECT Employment_Status, SUM(Previous_Loan_Defaults) AS Total_Previous_Defaults
FROM loan
GROUP BY Employment_Status;



-- Distribution of Credit Scores
SELECT 
	CASE 
		WHEN Credit_Score < 580 THEN 'Poor'
		WHEN Credit_Score BETWEEN 580 AND 669 THEN 'Fair'
		WHEN Credit_Score BETWEEN 670 AND 739 THEN 'Good'
		WHEN Credit_Score BETWEEN 740 AND 799 THEN 'Very Good'
		ELSE 'Excellent'
	END AS Credit_Score_Category,
       COUNT(*) AS Count
FROM loan
GROUP BY Credit_Score_Category;



-- Average Monthly Loan Payment by Age Group
SELECT 
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 and Above'
    END AS Age_Group,
    AVG(Monthly_Loan_Payment) AS Average_Monthly_Payment
FROM
    loan
GROUP BY Age_Group;


-- Average Loan Amount by Income Category
SELECT 
    CASE 
        WHEN Annual_Income < 30000 THEN 'Less than 30,000'
        WHEN Annual_Income BETWEEN 30000 AND 59999 THEN '30,000 - 59,999'
        WHEN Annual_Income BETWEEN 60000 AND 99999 THEN '60,000 - 99,999'
        WHEN Annual_Income BETWEEN 100000 AND 149999 THEN '100,000 - 149,999'
        ELSE '150,000 and above'
    END AS Income_Category,
    AVG(Loan_Amount) AS Average_Loan_Amount
FROM loan
GROUP BY Income_Category
ORDER BY Income_Category;



-- PREDICTIVE ANALYSIS

-- Average Debt-to-Income Ratio for Approved Loans
SELECT AVG(Debt_To_Income_Ratio) AS Average_DTI
FROM loan
WHERE Loan_Approved = 1;



-- Previous Loan Defaults by Employment Status
SELECT Employment_Status, SUM(Previous_Loan_Defaults) AS Total_Previous_Defaults
FROM loan
GROUP BY Employment_Status;
   

   

   

   

   

   

   

