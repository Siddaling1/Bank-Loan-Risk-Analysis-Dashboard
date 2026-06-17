CREATE DATABASE loan ;
use loan;

CREATE TABLE loan(
Loan_ID	VARCHAR(50),
Gender	VARCHAR(50),
Married	VARCHAR(50),
Dependents	INT,
Education	VARCHAR(50),
Self_Employed	VARCHAR(50),
ApplicantIncome	INT,
CoapplicantIncome	INT,
LoanAmount	INT,
Loan_Amount_Term	INT,
Credit_History	INT,
Property_Area	VARCHAR(50),
Loan_Status VARCHAR(50)
);

SET SQL_SAFE_UPDATES = 0;
UPDATE loan_risk 
SET ApplicantIncome = ApplicantIncome * 12;

SET SQL_SAFE_UPDATES = 0;
UPDATE loan_risk
SET LoanAmount = LoanAmount * 1000;


/* Questions */

### 1.What is the total number of loan applications?

SELECT 
    COUNT(Loan_ID)
FROM
    loan_risk;
/* Output
count(Loan_ID)
204
*/


### 2.What is the overall loan approval vs rejection rate?

SELECT 
    count(case when Loan_Status= "Y" then 1 end )*100/count(*) as Approval_Rate,
    count(case when Loan_Status= "N" then 1 end )*100/count(*) as Rejection_Rate
FROM
    loan_risk;

/* Output
Approval_Rate, Rejection_Rate
'61.2745', '38.7255'
*/

### 3.What is the total and average loan amount requested

SELECT 
    SUM(LoanAmount) AS TOTAL_Loan_Amount,
    AVG(LoanAmount) AS Avg_Loan_Amount
FROM
    loan_risk;

/*
TOTAL_Loan_Amount, Avg_Loan_Amount
'36151000', '177210.7843'
*/

### 4.Does applicant income affect loan approval?

SELECT 
    Loan_Status, AVG(ApplicantIncome) AS Application_Income
FROM
    loan_risk
GROUP BY Loan_Status;

/*
Loan_Status, Application_Income
'Y', '79105.1520'
'N', '83388.0000'
*/

-- Applicant income won't affect loan approval , because avg Application income is less the rejecting Application Loan

### 5.Which education group has higher loan approval rates?

SELECT 
    Education,
    COUNT(CASE
        WHEN Loan_Status = 'Y' THEN 1
    END) * 100 / COUNT(*) AS Loan_Approval_Rate
FROM
    loan_risk
GROUP BY Education;

/*
# Education, Loan_Approval_Rate
'Graduate', '63.1902'
'Not Graduate', '53.6585'
*/

-- Graduate Have High Approval Rate 

### 6.How does credit history impact loan approval?

SELECT 
    Credit_History,
    COUNT(CASE
        WHEN Loan_Status = 'Y' THEN 1
    END) * 100 / COUNT(*) AS Approval_Rate
FROM
    loan_risk
GROUP BY Credit_History;

/*
# Credit_History, Approval_Rate
'1', '71.3450'
'0', '9.0909'
*/
 
### 7.Which property area (Urban/Semiurban/Rural) has the highest approvals?

SELECT 
    Property_Area, count(Loan_Status) as Total_Approvals
FROM
    loan_risk
WHERE
    Loan_Status = 'Y'
GROUP BY Property_Area
order by Loan_Status desc;

/*
# Property_Area, Total_Approvals
'Semiurban', '54'
'Urban', '49'
'Rural', '22'
*/


### 8.Does marital status affect loan approval chances?

SELECT 
    Married,
    COUNT(CASE
        WHEN Loan_Status = 'Y' THEN 1
    END) * 100 / COUNT(*) AS Approval_Rate
FROM
    loan_risk
GROUP BY Married;

/* 
# Married, Approval_Rate
'Yes', '65.9259'
'No', '52.1739'
*/

-- Married People Have High Approval Rate

### 9.How do dependents influence loan approval? 

SELECT 
    Dependents,
    COUNT(CASE
        WHEN Loan_Status = 'Y' THEN 1
    END) * 100 / COUNT(*) AS Approval_Rate
FROM
    loan_risk
GROUP BY Dependents;

/*
# Dependents, Approval_Rate
'2', '74.2857'
'3', '61.1111'
'1', '60.0000'
'0', '57.6577'
*/


### 10.Which gender applies for more loans and gets more approvals?

SELECT 
    Gender,
    COUNT(Loan_Status) AS Total_Applied,
    COUNT(CASE
        WHEN Loan_Status = 'Y' THEN 1
    END) * 100 / COUNT(*) AS Approval_Rate
FROM
    loan_risk
GROUP BY Gender;

/*
# Gender, Total_Applied, Approval_Rate
'Male', '168', '61.9048'
'Female', '31', '58.0645'
'Unknown', '5', '60.0000'
*/

### 11.Who are the high-risk customers (low income, high loan amount)?

SELECT 
    Dependents,
    AVG(ApplicantIncome) AS Income,
    AVG(LoanAmount) AS Loan_Amount
FROM
    loan_risk
GROUP BY Dependents;

/*
# Dependents, Income, Loan_Amount
'3', '182573.3333', '290166.6667'
'1', '86920.8000', '186500.0000'
'0', '69591.1351', '159036.0360'
'2', '56800.8000', '166142.8571'
*/

### 12.Which occupation type (Self-employed or not) has more loan rejections?

SELECT 
    Self_Employed,
    COUNT(CASE
        WHEN Loan_Status = 'N' THEN 1
    END) * 100 / COUNT(*) AS Rejection_Rate
FROM
    loan_risk
GROUP BY Self_Employed;

/*
# Self_Employed, Rejection_Rate
'Yes', '45.8333'
'No', '37.7778'
*/

### 13.What is the average income of approved vs rejected applicants?

SELECT 
    Loan_Status, AVG(ApplicantIncome) AS Income
FROM
    loan_risk
GROUP BY Loan_Status;

/*
# Loan_Status, Income
'Y', '79105.1520'
'N', '83388.0000'
*/

### 14.Find customers whose loan amount is above average.

SELECT 
    Loan_ID,
    LoanAmount
FROM
    loan_risk
WHERE
    LoanAmount > (SELECT AVG(LoanAmount) FROM loan_risk);


/*
# Loan_ID, LoanAmount
'LP001011', '267000'
'LP001020', '349000'
'LP001028', '200000'
'LP001046', '315000'
'LP001066', '191000'
'LP001091', '201000'
'LP001100', '320000'
'LP001114', '184000'
'LP001186', '286000'
'LP001198', '180000'
'LP001225', '258000'
'LP001233', '312000'
'LP001253', '187000'
'LP001273', '265000'
'LP001289', '210000'
'LP001318', '188000'
'LP001369', '225000'
'LP001379', '216000'
'LP001401', '185000'
'LP001422', '259000'
'LP001439', '194000'
'LP001448', '370000'
'LP001465', '182000'
'LP001469', '650000'
'LP001488', '290000'
'LP001492', '242000'
'LP001531', '244000'
'LP001536', '600000'
'LP001552', '255000'
'LP001562', '275000'
'LP001585', '700000'
'LP001610', '495000'
'LP001637', '260000'
'LP001708', '214000'
'LP001713', '240000'
'LP001776', '280000'
'LP001843', '279000'
'LP001844', '192000'
'LP001859', '304000'
'LP001865', '330000'
'LP001903', '207000'
'LP001907', '436000'
'LP001996', '480000'
'LP002065', '300000'
'LP002067', '376000'
'LP002101', '490000'
'LP002139', '228000'
'LP002140', '308000'
'LP002170', '236000'
'LP002191', '570000'
'LP002201', '380000'
'LP002229', '296000'
'LP002317', '360000'
'LP002328', '218000'
'LP002335', '178000'
'LP002342', '239000'
'LP002386', '405000'
'LP002444', '190000'
'LP002529', '230000'
'LP002541', '234000'
'LP002543', '246000'
'LP002547', '500000'
'LP002562', '186000'
'LP002602', '209000'
'LP002615', '208000'
'LP002622', '243000'
'LP002640', '250000'
'LP002652', '311000'
'LP002699', '400000'
'LP002729', '196000'
'LP002734', '324000'
'LP002788', '181000'
'LP002820', '211000'
'LP002892', '205000'
'LP002933', '292000'
'LP002949', '350000'
'LP002959', '496000'
'LP002983', '253000'
*/


### 15.Find applicants whose income is below average but loan amount is above average.

SELECT 
    Loan_ID, ApplicantIncome, LoanAmount
FROM
    loan_risk
WHERE
    ApplicantIncome < (SELECT 
            AVG(ApplicantIncome)
        FROM
            loan_risk)
        AND LoanAmount > (SELECT 
            AVG(LoanAmount)
        FROM
            loan_risk);





























