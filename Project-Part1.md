# Data Cleaning in SQL Server

## Introduction
This project involves a data cleaning process to prepare data for analysis. This is the most essential part of any data analytics project; mastering it facilitates identifying trends and patterns in the data. This also makes it easier to design 
dashboards and write reports to communicate the findings.

## Importance of the Project
In this project, I delve into data cleaning to prepare a report concerning the total layoffs of some companies in different countries. The project was completed by following the video from [Alex the Analyst](https://www.youtube.com/watch?v=4UltKCnnnTA). 
Although the video showcases the completion of the project in MySQL, I went on to perform the same tasks in SQL Server. It was a little challenging at the beginning, but I am very happy I was able to complete it. In what follows, I describe step-by-step all the 
tasks completed in cleaning and transforming the data.

Data Information: 2361 rows and 9 columns

Steps completed:
---> Imported data into SQL Server. When I first imported the data into SQL Server using the option Import Flat File, I encountered an error. This was my first time encountering this error. From there, I watched a YouTube video by 
TaiKup (Link: https://www.youtube.com/watch?v=K5_u6Xrbl_s) which showed how to use another option, Import Data. The video was very explicit and after watching it I went on to apply the steps and was able to import my data without any errors.

Note: It is not advised to work on the raw dataset. Always copy the raw data and do all your cleaning from the copied data. This is good practice as you can refer to the raw data if at any stage of your data cleaning, you made a mistake.

During this first step, I previewed the data to have a broad idea of what needs to be done.

---> Copied the raw data to a new table
In SQL server, the command to create a table from an existing one is different from that in MySQL. I also explained this in one of my posts here on LinkedIn. To copy the table to a new one, I used the following query in SQL Server:
SELECT * INTO layoffs_working
FROM [Learn SQL].dbo.layoffs;

---> Previewed the data using 
SELECT * 
FROM [Learn SQL].dbo.layoffs;

---> Checked for duplicates
SELECT *
FROM (
    SELECT *,
		ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions ORDER BY total_laid_off) AS dup_row_num
	FROM [Learn SQL].dbo.layoffs_working ) AS rem_duplicate_data
WHERE dup_row_num > 1;

Note: The ORDER BY clause is necessary when using the ROW_NUMBER() function in SQL Server. Therefore, if you write the above query without the ORDER BY clause it will return an error. 

In the above query, we wrote the partition by over all the rows of the table to ensure that duplicates contain exact same rows. The query returned 5 rows (duplicates) from the data. Now, it is important to check further in writing query with the WHERE clause for each of those duplicate to verify if those are actually duplicates. This will save you from deleting rows that are not duplicates.

---> Removed duplicates in the data and created a new table to insert the non-duplicate data
To remove duplicates, I rewrote the above query. Then, inserted the output into a new table named layoffs_working2 containing non-duplicate rows. The query looked like:

SELECT * INTO [Learn SQL].dbo.layoffs_working2
FROM (
    SELECT *,
	ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions ORDER BY total_laid_off) AS dup_row_num
    FROM [Learn SQL].dbo.layoffs_working ) AS rem_duplicate_data
WHERE dup_row_num = 1;

SELECT *
FROM [Learn SQL].dbo.layoffs_working2;

The last query selected all data from the new table named layoffs_working2 and returned 2356 rows.
 

---> Standardized the data for example by checking for incorrect spellings and fixing them to make all data consistent.

- Trimmed the data to remove trailing space
SELECT 
	company, 
	TRIM(company)
FROM [Learn SQL].dbo.layoffs_working2;

-- Updated the table with the trimmed columns
UPDATE [Learn SQL].dbo.layoffs_working2
SET company = TRIM(company);

SELECT *
FROM [Learn SQL].dbo.layoffs_working2;

-- Checked for misspelled words in the industry column
SELECT DISTINCT industry
FROM [Learn SQL].dbo.layoffs_working2;

UPDATE [Learn SQL].dbo.layoffs_working2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

If you run the first query is this specific task, you will realized that every thing in the industry has been updated.

---> Looked at NULL and Blank values. This step helped in populating missing data where possible.
I used the query below to convert every column with 'NULL' to NULL where the data type of that column was supposed to be int or float.
UPDATE [Learn SQL].dbo.layoffs_working2
SET industry = NULL
WHERE industry = 'NULL';

This facilitated the conversion of those columns from string to int or float.


I realized that SQL Server does not allow th JOIN clause in an UPDATE statement like in MySQL. So, I had to use a proper FROM clause to achieve the same functionality.

The following steps were performed:
1. Updated all the blanks with NULL
UPDATE [Learn SQL].dbo.layoffs_working2
SET industry = NULL
WHERE industry = '';

2. Performed a self JOIN on the table to identify rows with NULL and empty rows.
SELECT l1.industry, l2.industry
FROM [Learn SQL].dbo.layoffs_working2 l1
JOIN [Learn SQL].dbo.layoffs_working2 l2
	ON l1.company = l2.company
WHERE (l1.industry IS NULL OR l1.industry = '')
AND l2.industry IS NOT NULL;

3. Updated the table by replacing the table on the left side of the JOIN with the values from the table on the right
UPDATE l1
SET l1.industry = l2.industry
FROM [Learn SQL].dbo.layoffs_working2 l1
JOIN [Learn SQL].dbo.layoffs_working2 l2
    ON l1.company = l2.company
WHERE l1.industry IS NULL
  AND l2.industry IS NOT NULL;


---> Removed unnecessary rows and columns that did not add any value to the entire dataset or that were not needed in the ETL (Extract, Transform, Load) process.
Here I removed the dup_row_num column that was created while identifying duplicates in the data. The following query was used:
ALTER TABLE [Learn SQL].dbo.layoffs_working2
DROP COLUMN dup_row_num;

Although there were still NULL values in the data, we left them for now as they could be explored in the next step which will be the exploratory data analysis.













