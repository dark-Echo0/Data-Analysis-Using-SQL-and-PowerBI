# **Data Analysis using SQL and Power BI**

## Preview of the Dashboard
![](image/SalesDB-Visualization.png)

## Key Insights
- Total Sales trended down, resulting in a 0.79% decrease between January 2014 and December 2014.
- Total Sales started trending down on May 2014, falling by 4.41% ($395,122.5) in 6 months.
- At $13,337,300.5, Bangladesh had the highest Total Sales and was 122.56% higher than China, which had the lowest Total Sales at $5,992,661.
- Bangladesh accounted for 12.65% of Total Sales.
- Across all 10 product category, Total Sales ranged from $386,461 to $3,676,606.

## USE of SQL SERVER
In this project, I utilized SQL Server for data preparation, cleaning, and validation. The workflow follows the Medallion Architecture, transforming raw data into clean, analytics-ready data for visualization.

 Steps Performed:

a. Database Creation
- Created a database named SalesDB to store and manage all datasets.

b. Data Ingestion (Bronze Layer)
- Imported raw CSV data into the bronze schema using the BULK INSERT command.
- This layer retains the original, unprocessed data.

c. Data Cleaning & Transformation (Silver Layer)
- Removed duplicate records.
- Standardized text formats (e.g., capitalization, trimming spaces).
- Converted and standardized date formats.
- Handled missing or null values appropriately.

d. Data Modeling (Gold Layer)
- Stored the cleaned and transformed data in the gold schema.
- Created views for easy access and reporting.
- Prepared the dataset for downstream visualization tools (e.g., Power BI).

## Validation & Exploratory Analysis
To review the findings, refer to the document “Exploratory Analysis for SalesDB Database.pdf” uploaded in this repository.
This document is used to:
- Validate and cross-check the results shown in Power BI visualizations.
- Ensure consistency and accuracy between the SQL-processed data and the dashboard outputs.
- Support data integrity through exploratory analysis.

## USE of POWER BI
In this phase, I utilized Power BI to create interactive dashboards and visualize insights derived from the dataset.
Key Steps Performed:
a. Data Modeling
- Established relationships by connecting foreign keys from the fact table to the corresponding dimension tables
- Designed a star schema to ensure efficient querying and accurate analysis

b. Data Visualization
- Selected appropriate charts (e.g., bar charts, line graphs, and KPIs) to effectively communicate insights
- Built an interactive dashboard to highlight key trends, patterns, and business metrics

## Disclaimer: The dataset used in this project is fictional and was obtained from Kaggle for educational purposes only.
  




















