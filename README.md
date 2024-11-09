## Project 3: Loan Credibility Analysis

### Objective
The objective of this analysis is to assess the creditworthiness of loan applicants using historical loan data. By examining various demographic and financial factors, we aim to identify significant predictors of loan defaults. This analysis will highlight trends in loan approvals and rejections, providing actionable insights for risk management and decision-making within lending institutions. Understanding these dynamics can help improve lending strategies and reduce financial risks associated with loan defaults.

### Key Skills
- **SQL Skills**: Proficient in data extraction and manipulation, including:
  - **Aggregate Functions**: Using `COUNT`, `SUM`, `AVG` to summarize data.
  - **Grouping and Filtering**: Utilizing `GROUP BY` and `WHERE` clauses to refine datasets.
  - **Conditional Logic**: Applying `CASE` statements for categorical analysis.
  - **Correlation Analysis**: Using statistical functions to understand relationships between variables.
- **Python Skills**: Experienced in data cleaning, visualization, and analysis using libraries such as:
  - **Pandas**: For data manipulation and analysis.
  - **Matplotlib/Seaborn**: For creating insightful visualizations.

### Methodology

#### 1. Data Extraction and Cleaning
Utilized SQL to extract relevant loan data from the dataset and applied data cleaning techniques to handle any inconsistencies or missing values.

**Example SQL Code**:
```sql
SELECT *
FROM loan
WHERE Loan_Amount IS NOT NULL AND CreditScore IS NOT NULL;
```

#### 2. Descriptive Analysis
Descriptive analysis was conducted to summarize and understand the characteristics of the loan applicants. This involved calculating averages, counts, and distributions of key variables such as `AnnualIncome`, `CreditScore`, and `LoanAmount`.

**SQL Queries**:

1. **Count Total Loan Applications**
   ```sql
   SELECT COUNT(*) AS Total_Applications
   FROM loan;
   ```
   *Purpose*: To determine the total number of loan applications in the dataset.

2. **Average Loan Amount by Employment Status**
   ```sql
   SELECT Employment_Status, AVG(Loan_Amount) AS Average_Loan_Amount
   FROM loan
   GROUP BY Employment_Status;
   ```
   *Purpose*: To analyze how loan amounts differ across various employment statuses.

3. **Average Credit Score by Education Level**
   ```sql
   SELECT Education_Level, AVG(Credit_Score) AS Average_Credit_Score
   FROM loan
   GROUP BY Education_Level;
   ```
   *Purpose*: To evaluate the impact of education level on credit scores.

4. **Loan Approval Rate by Marital Status**
   ```sql
   SELECT Marital_Status, 
          COUNT(CASE WHEN Loan_Approved = 1 THEN 1 END) AS Approved,
          COUNT(*) AS Total,
          (COUNT(CASE WHEN Loan_Approved = 1 THEN 1 END) * 100.0 / COUNT(*)) AS Approval_Rate
   FROM loan
   GROUP BY Marital_Status;
   ```
   *Purpose*: To assess loan approval rates based on marital status.

5. **Total Loan Amounts by Loan Purpose**
   ```sql
   SELECT Loan_Purpose, SUM(Loan_Amount) AS Total_Loan_Amount
   FROM loan
   GROUP BY Loan_Purpose;
   ```
   *Purpose*: To understand the distribution of loan amounts across different loan purposes.

6. **Average Debt-to-Income Ratio for Approved Loans**
   ```sql
   SELECT AVG(Debt_To_Income_Ratio) AS Average_DTI
   FROM loan
   WHERE LoanApproved = 1;
   ```
   *Purpose*: To analyze the average debt-to-income ratio among approved loans.

7. **Count of Previous Loan Defaults by Employment Status**
   ```sql
   SELECT Employment_Status, SUM(Previous_Loan_Defaults) AS Total_Previous_Defaults
   FROM loan
   GROUP BY Employment_Status;
   ```
   *Purpose*: To identify the correlation between employment status and previous loan defaults.

8. **Distribution of Credit Scores**
   ```sql
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
   ```
   *Purpose*: To categorize credit scores and understand their distribution among applicants.

9. **Average Monthly Loan Payment by Age Group**
   ```sql
   SELECT 
       CASE 
           WHEN Age < 30 THEN 'Under 30'
           WHEN Age BETWEEN 30 AND 39 THEN '30-39'
           WHEN Age BETWEEN 40 AND 49 THEN '40-49'
           WHEN Age BETWEEN 50 AND 59 THEN '50-59'
           ELSE '60 and Above'
       END AS Age_Group,
       AVG(Monthly_Loan_Payment) AS Average_Monthly_Payment
   FROM loan
   GROUP BY Age_Group;
   ```
   *Purpose*: To analyze how monthly loan payments vary by age group.

10. **Average Loan Amount by Income Category**
    ```sql
    SELECT 
        CASE 
            WHEN Annual_Income < 30000 THEN 'Less than $30,000'
            WHEN Annual_Income BETWEEN 30000 AND 59999 THEN '$30,000 - $59,999'
            WHEN Annual_Income BETWEEN 60000 AND 99999 THEN '$60,000 - $99,999'
            WHEN Annual_Income BETWEEN 100000 AND 149999 THEN '$100,000 - $149,999'
            ELSE '$150,000 and above'
        END AS Income_Category,
        AVG(Loan_Amount) AS Average_Loan_Amount
    FROM loan
    GROUP BY Income_Category
    ORDER BY Income_Category;
    ```
    *Purpose*: This SQL query categorizes annual income into defined ranges and calculates the average loan amount for each category, helping to understand how loan amounts vary with different income levels.

#### 3. Predictive Analysis
The predictive analysis phase involved utilizing statistical methods to model the likelihood of loan defaults based on various applicant characteristics.

**SQL Queries**:

1. **Average Debt-to-Income Ratio for Approved Loans**
   ```sql
   SELECT AVG(Debt_To_Income_Ratio) AS Average_DTI
   FROM loan
   WHERE LoanApproved = 1;
   ```
   *Purpose*: To analyze the average debt-to-income ratio for approved loans.

2. **Previous Loan Defaults by Employment Status**
   ```sql
   SELECT Employment_Status, SUM(Previous_Loan_Defaults) AS Total_Previous_Defaults
   FROM loan
   GROUP BY Employment_Status;
   ```
   *Purpose*: To correlate employment status with previous loan defaults.

### Findings
- **Key Predictors**: The analysis identified that `Credit_Score`, `Debt_To_Income_Ratio`, and `Employment_Status` are significant predictors of loan defaults. Higher credit scores and lower debt-to-income ratios correlate with higher approval rates.
- **Risk Insights**: Applicants with lower credit scores and higher debt-to-income ratios exhibited a significantly higher likelihood of defaulting on loans.
- **Actionable Insights**: Recommendations include refining lending criteria to focus more on these key predictors and implementing stricter checks for applicants in higher risk categories.

### Visualizations
The following visualizations were created using Python to further illustrate the findings and enhance understanding of the data:

1. **Average Loan Amount by Employment Status**
   ```python
   avg_loan_by_status = df.groupby('EmploymentStatus')['LoanAmount'].mean().reset_index()
   sns.barplot(x='EmploymentStatus', y='LoanAmount', data=avg_loan_by_status)
   plt.title('Average Loan Amount by Employment Status')
   plt.show()
   ```

2. **Loan Approval Rates by Marital Status**
   ```python
   approval_rates = df['MaritalStatus'].value_counts(normalize=True) * 100
   plt.pie(approval_rates, labels=approval_rates.index, autopct='%1.1f%%')
   plt.title('Loan Approval Rates by Marital Status')
   plt.show()
   ```

3. **Monthly Loan Payments by Credit Score Category**
   ```python
   df['Credit_Score_Category'] = pd.cut(df['CreditScore'], bins=[0, 580, 670, 740, 800, 850], labels=['Poor', 'Fair', 'Good', 'Very Good', 'Excellent'])
   sns.boxplot(x='Credit_Score_Category', y='MonthlyLoanPayment', data=df)
   plt.title('Monthly Loan Payments by Credit Score Category')
   plt.show()
   ```

4. **Total Loan Amounts by Loan Purpose**
   ```python
   total_loan_by_purpose = df.groupby('Loan_Purpose')['Loan_Amount'].sum().reset_index()
   plt.figure(figsize=(12, 8))
   sns.barplot(x='Loan_Purpose', y='Loan_Amount', data=total_loan_by_purpose, palette='magma')
   plt.title('Total Loan Amounts by Loan Purpose', fontsize=16, fontweight='bold')
   plt.xlabel('Loan Purpose', fontsize=14)
   plt.ylabel('Total Loan Amount', fontsize=14)
   plt.xticks(rotation=45)
   plt.show()
   ```

5. **Loan Approval Rates by Education Level**
   ```python
   plt.figure(figsize=(12, 8))
   sns.countplot(x='Education_Level', hue='Loan_Approved', data=df, palette='Pastel1')
   plt.title('Loan Approval Rates by Education Level', fontsize=16, fontweight='bold')
   plt.xlabel('Education Level', fontsize=14)
   plt.ylabel('Count', fontsize=14)
   plt.legend(title='Loan Approved', loc='upper right')
   plt.show()
   ```

### Limitations
- **Data Quality**: The analysis is dependent on the quality of the historical data. Missing or inaccurate data can lead to misleading results.
- **Sample Size**: If the dataset is not representative of the broader population, conclusions drawn may not be applicable universally.
- **External Factors**: Economic conditions, regulatory changes, and other external factors influencing loan approvals and defaults may not be captured in the dataset.

### Conclusion
This project provides a comprehensive analysis of loan credibility, revealing key factors influencing loan defaults and approval rates. By leveraging these insights, lending institutions can enhance their risk assessment processes and improve decision-making strategies.
