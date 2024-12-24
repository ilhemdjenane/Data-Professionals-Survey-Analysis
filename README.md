### Data Professionals Survey Analysis Report


---

#### **Introduction**
This report provides a comprehensive analysis of survey responses collected from data professionals. The primary objective was to understand key trends in the data industry, such as salary distributions, favorite tools and languages, education levels, and overall happiness in current roles. The dataset, cleaned and organized in SQL, was visualized using Power BI to generate actionable insights.

---
## Dashboard Overview
![Dashboard](https://github.com/ilhemdjenane/Data-Professionals-Survey-Analysis/blob/bc99597a09a3aacacc8ae325064af1f21587e7ad/Dashboard)

#### **Data Cleaning and Organization**

**Process Overview:**
The raw dataset required significant preprocessing to ensure accuracy and usability. The following steps were undertaken:

1. **Data Importation:** The dataset was imported into SQL Server, where the initial structure and inconsistencies were identified.
2. **Column Cleanup:**
   - Removed unnecessary columns such as "Email," "Browser," and "Time Spent" to streamline the dataset.
   - Renamed columns (e.g., "Q1 - Which Title Best Fits your Current Role?" to "CurrentJob") for better readability.
3. **Error Corrections:**
   - Fixed numerous typos in the "CurrentJob" column.
   - Standardized entries in the "Country" column, addressing typos and inconsistencies.
4. **Categorization:**
   - Created new columns for "JobCategory" and "IndustryCategory" using SQL `UPDATE` and `CASE` statements.
   - Grouped similar job titles and industries into meaningful categories (e.g., "Data Analyst" and "Financial Analyst" grouped under "Analytics").
5. **Salary Analysis:**
   - Transformed "YearlySalaryUSD" into "SalaryMin," "SalaryMax," and "AvgSalary" columns.
   - Categorized salaries into "Low," "Mid," and "High" based on average salary values.
6. **Additional Data Cleaning:**
   - Standardized entries in "FavoriteLanguage" (e.g., "sql" and "Sql" unified as "SQL").
   - Addressed "Other (Please Specify)" entries across multiple columns by extracting and retaining meaningful information.

**Challenges and Solutions:**
- **Challenge:** Correcting typos and inconsistencies in key columns like "CurrentJob."
  **Solution:** Used SQL string functions and manual updates to ensure uniformity.
- **Challenge:** Creating meaningful categories for job roles and industries.
  **Solution:** Implemented SQL `CASE` statements to classify entries into predefined groups.
- **Challenge:** Parsing complex salary formats.
  **Solution:** Utilized SQL functions to extract minimum, maximum, and average salary values from textual data.

---

#### **Dashboard Insights**
The Power BI dashboard highlights several important trends:

1. **Average Salary by Job Title:**
   - Top-paying roles include Analytics Consultant, Director, and Manager, each with an average salary of $188,000.
   - Entry-level roles like Data Scientist and Social Media Analyst average around $96,000.

2. **Favorite Programming Languages:**
   - Python dominates as the most preferred language among respondents, followed by SQL and R.

3. **Education Levels:**
   - Most respondents hold a Bachelor's degree (57%), followed by Master’s degrees (33%).
   - High school and Associate degrees represent a smaller proportion of the dataset.

4. **Gender-Based Salary Distribution:**
   - The average salary distribution is nearly equal between male and female respondents (51% female, 49% male).

5. **Difficulty Breaking into Data:**
   - 42% reported "Neither Difficult nor Easy" while 25% found it "Difficult", highlighting the varied paths to entering the field.

6. **Overall Happiness:**
   - Average happiness score: 5.26/10.
   - Personal Services reported the highest score happiness (8/10)
   - Management were happiness score (2.67/10).

---

#### **Technical Skills Demonstrated**

1. **SQL**:
   - Data cleaning (null handling, standardization, and deduplication).
   - Corrected typos and inconsistencies in key columns.
   - Created new categorical columns (e.g., "JobCategory," "IndustryCategory").
   - Parsed and analyzed salary data to extract actionable insights.
2. **Power BI**:
   - Designed interactive visuals to highlight key metrics.
   - Filtered dashboards for deeper user-specific insights.
3. **Data Analysis**:
   - Extracted actionable trends from complex datasets.
   - Addressed real-world challenges in the data industry.

---

#### **Impact and Recommendations**

**Key Findings:**
- **Industry Preferences:** The demand for Python suggests professionals should prioritize its mastery for data-related roles.
- **Education Trends:** Higher degrees dominate, but there is still representation from non-traditional pathways.
- **Breaking into Data:** Mentorship and educational resources could ease transitions into data careers.

**Recommendations:**
- Organizations should focus on improving management satisfaction and career mobility to retain talent.
- Community-driven initiatives (e.g., workshops) could address difficulties in entering the field.

---

#### **Conclusion**
This project showcases the ability to clean and analyze complex datasets using SQL and Power BI, translating raw data into actionable insights. The insights gained offer meaningful contributions to understanding data professionals' experiences and industry trends. This analysis demonstrates my expertise in data analysis and visualization, with direct application to real-world challenges.

---

#### **Appendices**
- SQL Queries: Detailed scripts for data cleaning and transformations.
- Dashboard Visuals: Screenshots and explanations of Power BI components.

Thank you for reviewing this report. I look forward to discussing how these skills can contribute to your organization's success.

