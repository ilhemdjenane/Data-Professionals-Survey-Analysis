USE [Survey Data];

SELECT *
FROM SurveyData;


-- Deleting unecessary columns
ALTER TABLE SurveyData
DROP COLUMN [Email],
            [Date Taken (America/New_York)],
            [Time Taken (America/New_York)],
            [Browser],
            [OS],
            [City],
            [Country],
            [Referrer],
            [Time Spent];


-- Let's have a look at the data types of the columns
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SurveyData';

-- Let's change the column names to make them more readable
EXEC sp_rename 
    'SurveyData.[Q1 - Which Title Best Fits your Current Role?]',
    'CurrentJob',
    'COLUMN';

EXEC sp_rename 
    'SurveyData.[Q2 - Did you switch careers into Data?]',
    'CarreerSwitchToData',
    'COLUMN';

EXEC sp_rename 
    'SurveyData.[Q3 - Current Yearly Salary (in USD)]',
    'YearlySalaryUSD',
    'COLUMN';

EXEC sp_rename 
    'SurveyData.[Q4 - What Industry do you work in?]',
    'Industry',
    'COLUMN';
EXEC sp_rename 
    'SurveyData.[Q5 - Favorite Programming Language]',
    'FavoriteLanguage',
    'COLUMN';

EXEC sp_rename 
    'SurveyData.[Q6 - How Happy are you in your Current Position with the followi]',
    'HappinessSalary',
    'COLUMN';

    EXEC sp_rename 
    'SurveyData.[Q6 - How Happy are you in your Current Position with the follow1]',
    'HappinessWorkLifeBalance',
    'COLUMN';

 EXEC sp_rename 
    'SurveyData.[Q6 - How Happy are you in your Current Position with the follow2]',
    'HappinessCoworkers',
    'COLUMN';

-- Let's have a look at the data types of the columns
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SurveyData';

 EXEC sp_rename 
    'SurveyData.[Q6 - How Happy are you in your Current Position with the follow3]',
    'HappinessManagement',
    'COLUMN';

 EXEC sp_rename 
    'SurveyData.[Q6 - How Happy are you in your Current Position with the follow4]',
    'HappinessUpwardMobility',
    'COLUMN';
 EXEC sp_rename 
    'SurveyData.[Q6 - How Happy are you in your Current Position with the follow5]',
    'HappinessLearning',
    'COLUMN';

EXEC sp_rename 
    'SurveyData.[Q7 - How difficult was it for you to break into Data?]',
    'DifficultyBreakingIntoData',
    'COLUMN';
 EXEC sp_rename 
    'SurveyData.[Q8 - If you were to look for a new job today, what would be the ]',
    'JobPriority',
    'COLUMN';

EXEC sp_rename 
    'SurveyData.[Q9 - Male/Female?]',
    'Gender',
    'COLUMN';
 EXEC sp_rename 
    'SurveyData.[Q10 - Current Age]',
    'Age',
    'COLUMN';

------------
 EXEC sp_rename 
    'SurveyData.[Q11 - Which Country do you live in?]',
    'Country',
    'COLUMN';

EXEC sp_rename 
    'SurveyData.[Q12 - Highest Level of Education]',
    'EducationLevel',
    'COLUMN';
 EXEC sp_rename 
    'SurveyData.[Q13 - Ethnicity]',
    'Ethnicity',
    'COLUMN';

-- Let's check the distinct values of the column 'CurrentJob'
SELECT DISTINCT CurrentJob
FROM SurveyData;

-- Cleaning the column 'CurrentJob', removing other and keeping job titles only

UPDATE SurveyData
SET CurrentJob = LTRIM(SUBSTRING(CurrentJob, CHARINDEX(':', CurrentJob) +1, LEN(CurrentJob)))
WHERE CurrentJob LIKE 'Other (Please Specify):%';

-- Let's clean the column 'CurrentJob' again, fixing typos and so on
UPDATE SurveyData
SET CurrentJob = 'Business Analyst'
WHERE CurrentJob = 'Business Analys';

UPDATE SurveyData
SET CurrentJob = 'Social Media Analyst'
WHERE CurrentJob = 'Does a social media analyst count?';

UPDATE SurveyData
SET CurrentJob = 'Financial Analyst'
WHERE CurrentJob = 'Finance Analyst ';

UPDATE SurveyData
SET CurrentJob = 'Data Analyst'
WHERE CurrentJob = 'I work with data tools and can create simple dashboards but I am not a data scientist';

UPDATE SurveyData
SET CurrentJob = 'Analytics Manager'
WHERE CurrentJob = 'Manager of a team of Data Analysts';

BEGIN TRANSACTION;

UPDATE SurveyData
SET [CurrentJob] = 'Manager'
WHERE [CurrentJob] LIKE '%manager%';


SELECT DISTINCT CurrentJob
FROM SurveyData;

COMMIT;

UPDATE SurveyData
SET CurrentJob = 'Other'
WHERE CurrentJob = 'Other (Please Specify)';


-- Let's add a new column 'JobCategory' to the table
ALTER TABLE SurveyData
ADD JobCategory NVARCHAR(255);

-- Let's update the column 'JobCategory' based on the column 'CurrentJob'
UPDATE SurveyData
SET JobCategory = CurrentJob;


SELECT DISTINCT JobCategory, CurrentJob
FROM SurveyData;

-- Let't put job titles into categories

BEGIN TRANSACTION;

UPDATE SurveyData
SET JobCategory = 'Research'
WHERE CurrentJob IN ('Researchers ',
                        'Research Associate '
                        );

UPDATE SurveyData
SET JobCategory = 'Education'
WHERE CurrentJob IN ('Teacher',
                        'Educator'
                        );

SELECT DISTINCT JobCategory
 FROM SurveyData;


UPDATE SurveyData
SET JobCategory = 'Administration'
WHERE CurrentJob IN ('PMO',
                        'System Administrator',
                        'Tableau admin',
                        'Director of Data Analytics',
                        'Director',
                        'Manager',
                        'Consultant',
                        'Reporting Adm');

SELECT CurrentJob, JobCategory
FROM SurveyData;

UPDATE SurveyData
SET JobCategory = 'Business Intelligence'
WHERE JobCategory IN ('BI consultant ',
                        'BI Developer ',
                        'Business Analyst ',
                        'Business Intelligence Analyst',
                        'Business Intelligence Consultant',
                        'Business Intelligence Developer',
                        'Business Intelligence Engineer',
                        'Business Intelligence Engineer ',
                        'Power Bi Developer',
                        'Senior Business Analyst',
                        'Sr. Supply Chain Analyst ');



UPDATE SurveyData
SET JobCategory = 'Analytics'
WHERE JobCategory IN ('Analyst',
                        'Analyst Primary Market Intelligence',
                        'Billing analyst',
                        'Data Analyst',
                        'Financial Analyst',
                        'FP&A Analyst',
                        'Insights analyst',
                        'Analytics Consultant ',
                        'Analytics Engineer',
                        'Social Media Analyst',
                        'Predictive Analyst',
                        'Research Analyst',
                        'GIS Analyst ',
                        'Investigation specialist'
                        );


SELECT DISTINCT JobCategory
 FROM SurveyData;


UPDATE SurveyData
SET JobCategory = 'Data Roles'
WHERE JobCategory IN ('Data Architect',
                        'Data Coordinator',
                        'Data Engineer',
                        'Data Integrity',
                        'Data Scientist',
                        'Data Scientist Intern',
                        'Data Steward',
                        'Jr. Data Scientist',
                        'Database Developer',
                        'DBA',
                        'Marketing Data Specialist',
                        'Informatics Specialist'
                        );

UPDATE SurveyData
SET JobCategory = 'Sales & Marketing'
WHERE JobCategory IN ('Ads operations',
                        'Sales & marketing',
                        'Presales Engineer ',
                        'Product owner');

UPDATE SurveyData
SET JobCategory = 'Software & Development'
WHERE JobCategory IN ('Software Developer ',
                        'software engineer',
                        'Software Engineer, AI ',
                        'Software support',
                        'Web Developer',
                        'Technical consulta',
                        'Systems configuration ',
                        'Junior Software Engineer',
                        'Support Engineer');


UPDATE SurveyData
SET JobCategory = 'Other'
WHERE JobCategory IN ('Continuous Quality Improvement Specialist',
                        'Driver',
                        'SAP Security Analyst',
                        'RF Engineer');

UPDATE SurveyData
SET JobCategory = 'Unemployed/Student'
WHERE JobCategory IN ('Student working as a data analyst intern ',
                        'Student/Looking/None');


--- Let's check the yearlysalary column

SELECT DISTINCT YearlySalaryUSD
FROM SurveyData;

-- We will Create an AverageSalary column 
-- First we have to create two columns for min and max salary

ALTER TABLE SurveyData
ADD SalaryMin INT,
    SalaryMax INT;

SELECT * FROM SurveyData;

UPDATE SurveyData
SET SalaryMin = CASE
                    WHEN CHARINDEX('-', YearlySalaryUSD) > 0 THEN
                        CAST(REPLACE(LEFT(YearlySalaryUSD, 
                                    CHARINDEX('-', YearlySalaryUSD) -1), 'k','000')AS INT)
                    ELSE NULL
                END,
    SalaryMax = CASE
                   WHEN YearlySalaryUSD LIKE '%+%' THEN NULL
                   WHEN CHARINDEX('-', YearlySalaryUSD) > 0 THEN
                        CAST(REPLACE(SUBSTRING(YearlySalaryUSD,
                                    CHARINDEX('-',YearlySalaryUSD) 
                                    +1, LEN(YearlySalaryUSD)), 'k','000') AS INT)
                ELSE NULL
            END;

-- Now we can create the AverageSalary column
ALTER TABLE SurveyData
ADD AvgSalary INT;

UPDATE SurveyData
SET AvgSalary = CASE 
                  WHEN SalaryMin IS NULL THEN SalaryMin
                  ELSE (SalaryMin + SalaryMax) / 2
                END;

ALTER TABLE SurveyData
ADD SalaryCategory NVARCHAR(50);

--Let's Create a new column to categorize the salary
UPDATE SurveyData
SET SalaryCategory = CASE
                        WHEN AvgSalary < 50000 THEN 'Low'
                        WHEN AvgSalary BETWEEN 50000 AND 100000 THEN 'Mid'
                        WHEN AvgSalary > 100000 THEN 'High'
            END;

SELECT * FROM SurveyData;

-- Let's clean the country column
SELECT DISTINCT Country
FROM SurveyData;

-- First let's keep only the country name
UPDATE SurveyData
SET Country = LTRIM(SUBSTRING(Country, 
                CHARINDEX(':', Country) +1, LEN(Country)))
WHERE Country LIKE 'Other (Please Specify):%';

-- Let's clean the country column again, fixing typos and so on
UPDATE SurveyData
SET Country = 'Nigeria'
WHERE Country = 'Africa (Nigeria)';

UPDATE SurveyData
SET Country = 'Argentine'
WHERE Country = 'Argentina';

UPDATE SurveyData
SET Country = 'Austria'
WHERE Country = 'Austr';

UPDATE SurveyData
SET Country = 'Brazil'
WHERE Country = 'Brazik';

UPDATE SurveyData
SET Country = 'Brazil'
WHERE Country = 'Brazik';

-- Lets make country name start with a capital letter

UPDATE SurveyData
SET Country =
    UPPER(LEFT(LTRIM(RTRIM(Country)), 1)) +
    LOWER(SUBSTRING(Country, 2, CHARINDEX(' ', Country + ' ') -1))+
    CASE WHEN CHARINDEX(' ', Country) > 0 THEN
        ' ' + UPPER(SUBSTRING(Country, CHARINDEX(' ',Country) +1, 1))+
        LOWER(SUBSTRING(Country, CHARINDEX(' ', Country) +2, LEN(Country)))
    ELSE '' END;

UPDATE SurveyData
SET Country = 'Finland'
WHERE Country = 'Fin';

SELECT DISTINCT Country
FROM SurveyData;

UPDATE SurveyData
SET Country = 'Ireland'
WHERE Country IN ('Ire',
                    'Irel');

UPDATE SurveyData
SET Country = 'Kenya'
WHERE Country = 'Kenua';

UPDATE SurveyData
SET Country = 'Lebanon'
WHERE Country = 'Leba';

UPDATE SurveyData
SET Country = 'Other'
WHERE Country IN ('Other  (please specify)',
                'Aisa');

UPDATE SurveyData
SET Country = 'Peru'
WHERE Country = 'Perú  ';

UPDATE SurveyData
SET Country = 'Portugal'
WHERE Country = 'Portugsl';

UPDATE SurveyData
SET Country = 'Singapore'
WHERE Country = 'Sg';

UPDATE SurveyData
SET Country = 'United  Arab emirates '
WHERE Country = 'Uae';

UPDATE SurveyData
SET Country = 'Uzbekistan'
WHERE Country = 'Uzb';

USE [Survey Data];

SELECT * FROM SurveyData;

-- Let's check the distinct values of the column 'Industry'
SELECT DISTINCT Industry
FROM SurveyData;

-- Let's clean the column 'Industry', removing other and keeping Industry titles only

UPDATE SurveyData
SET Industry = LTRIM(SUBSTRING(Industry, CHARINDEX(':', Industry) +1, LEN(Industry)))
WHERE Industry LIKE 'Other (Please Specify):%';

-- Let's create a new column 'IndustryCategory' to the table
ALTER TABLE SurveyData
ADD IndustryCategory NVARCHAR(255);

-- Let's update the column 'IndustryCategory' based on the column 'Industry'
UPDATE SurveyData
SET IndustryCategory = Industry;

SELECT DISTINCT IndustryCategory, Industry
FROM SurveyData;

-- Let't put Industry titles into categories
UPDATE SurveyData
SET IndustryCategory = 'Advertising, Media & Marketing'
WHERE IndustryCategory IN ('Advertising',
                            'Digital Mar',
                            'Digital Marketing ',
                            'Direct Marketing',
                            'Market research',
                            'Marketing ',
                            'Media & advertising ',
                            'Sports/Marketing');

SELECT DISTINCT IndustryCategory
FROM SurveyData;

UPDATE SurveyData
SET IndustryCategory = 'Aerospace & Defense'
WHERE IndustryCategory IN ('Aerospace',
                            'Arrosp',
                            'Avia',
                            'Aviation',
                            'Space & Defense',
                            'Defense ');

UPDATE SurveyData
SET IndustryCategory = 'Agriculture & Food'
WHERE IndustryCategory IN ('Agriculture',
                            'Beverage and foods',
                            'Food & Beverage ',
                            'Food and bece',
                            'Food and Beverages',
                            'Foodservice',
                            'Foodservice Franchising',
                            'Poultry',
                            'FMCG');


UPDATE SurveyData
SET IndustryCategory = 'Automotive'
WHERE IndustryCategory IN ('Automobile (cars)',
                            'Automobile Industry',
                            'Automotive');
SELECT DISTINCT IndustryCategory
FROM SurveyData;

UPDATE SurveyData
SET IndustryCategory = 'Consulting & Professional Services'
WHERE IndustryCategory IN ('Audit Firm',
                            'Cons',
                            'Consulti',
                            'Consulting',
                            'Cobsukting',
                            'Outsourcing ',
                            'Staffing and Recruting ');


UPDATE SurveyData
SET IndustryCategory = 'Consumer Goods & Retail'
WHERE IndustryCategory IN ('Consumer Elec',
                            'Consumer retail',
                            'Cosmetics ',
                            'Ecom',
                            'Ecommerce',
                            'E-commerce ',
                            'fashion/online store',
                            'Distribution',
                            'Reta',
                            'Retail',
                            'Retails',
                            'Retails');
            

UPDATE SurveyData
SET IndustryCategory = 'Education'
WHERE IndustryCategory IN ('Education',
                            'Demography and Social Statistics ',
                            'Not working at the moment, but previously I have been into Education industry');



UPDATE SurveyData
SET IndustryCategory = 'Eenrgy & Utilities'
WHERE IndustryCategory IN ('Clean Energy',
                            'Energy',
                            'Energy (oil and gas)',
                            'Oil and gas',
                            'Renewable Resources',
                            'Utili',
                            'Utilities');            

SELECT DISTINCT IndustryCategory
FROM SurveyData;                            

UPDATE SurveyData
SET IndustryCategory = 'Eenrgy & Utilities'
WHERE IndustryCategory IN ('Clean Energy',
                            'Energy',
                            'Energy (oil and gas)',
                            'Oil and gas',
                            'Renewable Resources',
                            'Utili',
                            'Utilities');            

UPDATE SurveyData
SET IndustryCategory = 'Government & Public Administration'
WHERE IndustryCategory IN ('Government',
                    'Government Administration',
                    'Government Programs',
                    'State',
                    'State Government',
                    'Police / Emergency Services',
                    'Gover',
                    'State Government');

UPDATE SurveyData
SET IndustryCategory = 'Healthcare & Biotech'
WHERE IndustryCategory IN ('Healthcare',
                            'Biotech',
                            'Medical Industry');
--------------------------------------------------

UPDATE SurveyData
SET IndustryCategory = 'Hospitality & Entertainment'
WHERE IndustryCategory IN ('Culinary',
                            'Entertainment',
                            'Hospitality');
--------------------------------------------------

UPDATE SurveyData
SET IndustryCategory = 'IT & Technology'
WHERE IndustryCategory IN ('Data Insights Company',
                    'IT',
                    'Sensors',
                    'Semiconductor Manufacturing',
                    'Tech',
                    'Telecommunications',
                    'Telecommunication',
                    'Electronics');

SELECT DISTINCT IndustryCategory
FROM SurveyData;                    

UPDATE SurveyData
SET IndustryCategory = 'Logistics & Supply Chain'
WHERE IndustryCategory IN ('Logistics',
                    'Logistics and Warehousing',
                    'Supply Chain',
                    'Supply Chain - Warehousing, Transportation and',
                    'Third Party Logistics',
                    'Last Mile Delivery Logistics',
                    'Transportation',
                    'Public Transport',
                    'Warehouse',
                    'Air transpo',
                    'Supply Chain - warehousing, transpiration and ');
--------------------------------------------------

UPDATE SurveyData
SET IndustryCategory = 'Manufacturing'
WHERE IndustryCategory IN ('Chemical Manufacturing', 
                    'Manufacturing', 
                    'Manuf', 
                    'Manufa', 
                    'Manufacturering', 
                    'Manufacturing (Chemicals)',
                    'Manufacturing',
                    'Maritime');

--------------------------------------------------

UPDATE SurveyData
SET IndustryCategory = 'Nonprofit & Social Services'
WHERE IndustryCategory IN ('NGO - Legislation',
                    'Non Profit Animal Welfare',
                    'Nonprofit',
                    'Homelessness',
                    'Social Work',
                    'Nonprofit & Social Services',
                    'Non Profit Organization');

--------------------------------------------------
UPDATE SurveyData
SET IndustryCategory = 'Research & Development'
WHERE IndustryCategory IN ('Research (non-clinical)',
                    'Interning in Sciences, Weather and Meteorological Data',
                    'Research (non-clincial)');

--------------------------------------------------
UPDATE SurveyData
SET IndustryCategory = 'Others'
WHERE IndustryCategory IN ('Other', 
                    'Others', 
                    'Others (Please Specify)',
                    'Culture',
                    'Customer Service',
                    'Customer Support',
                    'Urbanism',
                    'Workforce',
                    'Sports',
                    'Coworking space',
                    'Igaming',
                    'Construction',
                    'General Contractor',
                    'Other (Please Specify)',
                    'Home maker ',
                    'Home and living');

SELECT DISTINCT IndustryCategory
FROM SurveyData;                    


UPDATE SurveyData
SET IndustryCategory = 'Finance'
WHERE IndustryCategory IN ('Finance', 
                    'Insurance');

--------------------------------------------------
UPDATE SurveyData
SET IndustryCategory = 'Legal & Law Enforcement'
WHERE IndustryCategory IN ('Legal', 
                    'Law Enforcement');

--------------------------------------------------

UPDATE SurveyData
SET IndustryCategory = 'Student'
WHERE IndustryCategory IN ('I am a Student', 
                    'I am Student.',
                    'I`m Currently Student',
                    'Currently Studying. Previously Worked in Power Generation',
                    'Taking bootcamp',
                    'Currently studying . Previously worked in Power Generation');

--------------------------------------------------
UPDATE SurveyData
SET IndustryCategory = 'Unemployed'
WHERE IndustryCategory IN ('Unemployed', 
                    'Not Currently Working',
                    'Not Working Yet',
                    'Unemployed, trying to switch career',
                    'None for now',
                    'none',
                    'Looking for job');


SELECT * FROM SurveyData;

SELECT DISTINCT FavoriteLanguage
FROM SurveyData;

-- Let's clean the column 'FavoriteLanguage', removing other and keeping Language titles only

UPDATE SurveyData
SET FavoriteLanguage = LTRIM(SUBSTRING(FavoriteLanguage, CHARINDEX(':', FavoriteLanguage) +1, LEN(FavoriteLanguage)))
WHERE FavoriteLanguage LIKE 'Other:%';

-- Let's clean the column

UPDATE SurveyData
SET FavoriteLanguage = 'SQL'
WHERE FavoriteLanguage IN ('If SQL is categorise', 
                                 'Mostly use s',
                                'Sql &  plsql',
                                'SQL bec',
                                'sql',
                                'Sql',
                                'i mean, i mostly work in SQL and its variants?',
                                'Mostly use sql but that’s not programming language..',
                                'SQL because that is all I know really well so far. ',
                                'SQL Postgres ',
                                'I do analysis and create presentations based on datasets provided by others',
                                'If SQL is categorised as a programming language then I will definitely say SQL. Since I am still learning, I can''t give a definite answer in relation to the abover mentioned but for the sake of choosing I will say R then followed by python');


UPDATE SurveyData
SET FavoriteLanguage = 'None'
WHERE FavoriteLanguage IN (
                            'Dont require', 
                            'I do ana',
                            'I don’t know',
                            'I don''t use programming in my role',
                            'i mean, i mo',
                            'Just started learnin',
                            'Knowledge of',
                            'NA',
                            'None',
                            'None at the moment',
                            'Other',
                            'unknown',
                            'I currently do not work with programming languages yet',
                            'Just started learning ',
                            'I don’t know any',
                            'I do analysis and create presentations based on datasets provided by others'

                        );

SELECT DISTINCT FavoriteLanguage
FROM SurveyData;                        


UPDATE SurveyData
SET FavoriteLanguage = 'Excel'
WHERE FavoriteLanguage IN (
                                'Excel', 
                                'Excel/SQL',
                                'Mainly use E',
                                'Mainly use Excel',
                                'Knowledge of Excel and SQL yet');


UPDATE SurveyData
SET FavoriteLanguage = 'SAS'
WHERE FavoriteLanguage IN (
                                'SAS', 
                                'SAS SQL'
                               );

SELECT * FROM SurveyData;