# 𝐏𝐫𝐨𝐣𝐞𝐜𝐭: 𝐃𝐚𝐭𝐚 𝐂𝐥𝐞𝐚𝐧𝐢𝐧𝐠 𝐢𝐧 𝐒𝐐𝐋 𝐒𝐞𝐫𝐯𝐞𝐫

## 𝐓𝐚𝐛𝐥𝐞 𝐨𝐟 𝐂𝐨𝐧𝐭𝐞𝐧𝐭𝐬  
1. [Introduction](#𝐈𝐧𝐭𝐫𝐨𝐝𝐮𝐜𝐭𝐢𝐨𝐧)
2. [Importance of the Project](#𝐈𝐦𝐩𝐨𝐫𝐭𝐚𝐧𝐜𝐞-𝐨𝐟-𝐭𝐡𝐞-𝐏𝐫𝐨𝐣𝐞𝐜𝐭)
3. [Data Information](#𝐃𝐚𝐭𝐚-𝐈𝐧𝐟𝐨𝐫𝐦𝐚𝐭𝐢𝐨𝐧)
4. [Task 1: Downloaded and Imported Data into SQL Server](#𝐓𝐚𝐬𝐤-𝟏-𝐃𝐨𝐰𝐧𝐥𝐨𝐚𝐝𝐞𝐝-𝐚𝐧𝐝-𝐈𝐦𝐩𝐨𝐫𝐭𝐞𝐝-𝐃𝐚𝐭𝐚-𝐢𝐧𝐭𝐨-𝐒𝐐𝐋-𝐒𝐞𝐫𝐯𝐞𝐫)
5. [Task 2: Copied the Raw Data to a New Table](#𝐓𝐚𝐬𝐤-𝟐-𝐂𝐨𝐩𝐢𝐞𝐝-𝐭𝐡𝐞-𝐑𝐚𝐰-𝐃𝐚𝐭𝐚-𝐭𝐨-𝐚-𝐍𝐞𝐰-𝐓𝐚𝐛𝐥𝐞)
6. [Task 3: Checked and Removed Duplicates](#𝐓𝐚𝐬𝐤-𝟑-𝐂𝐡𝐞𝐜𝐤𝐞𝐝-𝐚𝐧𝐝-𝐑𝐞𝐦𝐨𝐯𝐞𝐝-𝐃𝐮𝐩𝐥𝐢𝐜𝐚𝐭𝐞𝐬)
7. [Task 4: Standardized the Data by Checking for Incorrect Spellings and Fixing them to Make all Data Consistent](#𝐓𝐚𝐬𝐤-𝟒-𝐒𝐭𝐚𝐧𝐝𝐚𝐫𝐝𝐢𝐳𝐞𝐝-𝐭𝐡𝐞-𝐃𝐚𝐭𝐚-𝐛𝐲-𝐜𝐡𝐞𝐜𝐤𝐢𝐧𝐠-𝐟𝐨𝐫-𝐢𝐧𝐜𝐨𝐫𝐫𝐞𝐜𝐭-𝐬𝐩𝐞𝐥𝐥𝐢𝐧𝐠𝐬-𝐚𝐧𝐝-𝐟𝐢𝐱𝐢𝐧𝐠-𝐭𝐡𝐞𝐦-𝐭𝐨-𝐦𝐚𝐤𝐞-𝐚𝐥𝐥-𝐝𝐚𝐭𝐚-𝐜𝐨𝐧𝐬𝐢𝐬𝐭𝐞𝐧𝐭)
8. [Task 5: Looked at NULL and Blank Values](#𝐓𝐚𝐬𝐤-𝟓-𝐋𝐨𝐨𝐤𝐞𝐝-𝐚𝐭-𝐍𝐔𝐋𝐋-𝐚𝐧𝐝-𝐁𝐥𝐚𝐧𝐤-𝐕𝐚𝐥𝐮𝐞𝐬)
9. [Task 6: Removed Unnecessary Rows and Columns](#𝐓𝐚𝐬𝐤-𝟔-𝐑𝐞𝐦𝐨𝐯𝐞𝐝-𝐔𝐧𝐧𝐞𝐜𝐞𝐬𝐬𝐚𝐫𝐲-𝐑𝐨𝐰𝐬-𝐚𝐧𝐝-𝐂𝐨𝐥𝐮𝐦𝐧𝐬)

## 𝐈𝐧𝐭𝐫𝐨𝐝𝐮𝐜𝐭𝐢𝐨𝐧
This project focuses on data cleaning, a crucial step in preparing data for analysis. Mastering this process is essential for identifying trends and patterns in the data. It also simplifies the creation of dashboards and the development of reports to effectively communicate findings.

## 𝐈𝐦𝐩𝐨𝐫𝐭𝐚𝐧𝐜𝐞 𝐨𝐟 𝐭𝐡𝐞 𝐏𝐫𝐨𝐣𝐞𝐜𝐭
In this project, I focused on data cleaning to prepare a report on total layoffs across various companies in different countries. I followed the tutorial by [Alex the Analyst](https://www.youtube.com/watch?v=4UltKCnnnTA), adapting the process from MySQL to SQL Server. Despite initial challenges, I successfully completed the project. Below, I provide a step-by-step description of the data cleaning and transformation tasks performed. 

As many of you know, some functions behave differently in MySQL compared to SQL Server. This difference made the start of this project a bit challenging, but I’m proud to have overcome those hurdles and successfully completed the project. Below, I’ll walk you through the step-by-step process of cleaning and transforming the data. 

## 𝐃𝐚𝐭𝐚 𝐈𝐧𝐟𝐨𝐫𝐦𝐚𝐭𝐢𝐨𝐧
The data was downloaded from the link provided by [Alex the Analyst](https://www.youtube.com/watch?v=4UltKCnnnTA).
* Number of rows: 2361 rows  
* Number of columns: 9 columns

## 𝐓𝐚𝐬𝐤 𝟏: 𝐃𝐨𝐰𝐧𝐥𝐨𝐚𝐝𝐞𝐝 𝐚𝐧𝐝 𝐈𝐦𝐩𝐨𝐫𝐭𝐞𝐝 𝐃𝐚𝐭𝐚 𝐢𝐧𝐭𝐨 𝐒𝐐𝐋 𝐒𝐞𝐫𝐯𝐞𝐫 
Initially, I used the Import Flat File option in SQL Server to import the data I downloaded from Alex Freberg's link, but I encountered an error I hadn't seen before. To troubleshoot, I watched a detailed YouTube tutorial by [𝐓𝐚𝐢𝐊𝐮𝐩](https://lnkd.in/gBbXR8Rz), which demonstrated how to use the Import Data option instead. Following the clear steps in the video, I successfully imported the data without any issues. During this first step, I previewed the data to have a broad idea of what needs to be done using:
```
SELECT * 
FROM [Learn SQL].dbo.layoffs;
```

## 𝐓𝐚𝐬𝐤 𝟐: 𝐂𝐨𝐩𝐢𝐞𝐝 𝐭𝐡𝐞 𝐑𝐚𝐰 𝐃𝐚𝐭𝐚 𝐭𝐨 𝐚 𝐍𝐞𝐰 𝐓𝐚𝐛𝐥𝐞
> [!Note]
> Always create a copy of your raw data before starting the cleaning process. This ensures you have the original data to refer back to if you make a mistake or need to validate your changes later. It's a simple but essential practice for maintaining data integrity!

In SQL server, the command to create a table from an existing one is different from that in MySQL. To copy the table to a new one, I used the following query in SQL Server:
```
SELECT * INTO layoffs_working
FROM [Learn SQL].dbo.layoffs;
```

## 𝐓𝐚𝐬𝐤 𝟑: 𝐂𝐡𝐞𝐜𝐤𝐞𝐝 𝐚𝐧𝐝 𝐑𝐞𝐦𝐨𝐯𝐞𝐝 𝐃𝐮𝐩𝐥𝐢𝐜𝐚𝐭𝐞𝐬
Here I used `ROW_NUMBER()`, `OVER()`, `PARTITION BY`, and `ORDER BY` to identify duplicates in the data. To obtain the best results, I partitioned by all the columns in the table. The output was inserted into a new table containing non-duplicate data. 

* **Checked for duplicates**  
```
SELECT *
FROM (
    SELECT *,
		ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions ORDER BY total_laid_off) AS dup_row_num
	FROM [Learn SQL].dbo.layoffs_working ) AS rem_duplicate_data
WHERE dup_row_num > 1;
```
> [!Note]
> I first wrote the query without the `ORDER BY` clause and this generated an error after executing it. Therefore, I realized that it is necessary when using the `ROW_NUMBER()` function in SQL Server. 

In the above query, I wrote the partition by over all the rows of the table to ensure that duplicates contain the exact same rows. The query returned 5 rows (duplicates) from the data. Next, it was important to check further in writing the query with the `WHERE` clause for each of those duplicates to verify if those were actually duplicates. Doing this saves you from deleting rows that are not duplicates.

* **Removed duplicates**  
To remove duplicates, I rewrote the above query. Then, inserted the output into a new table named layoffs_working2 containing non-duplicate rows. The query looked like this:
```
SELECT * INTO [Learn SQL].dbo.layoffs_working2
FROM (
    SELECT *,
	ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions ORDER BY total_laid_off) AS dup_row_num
    FROM [Learn SQL].dbo.layoffs_working ) AS rem_duplicate_data
WHERE dup_row_num = 1;
```
* **Selected all the data from the new table**  
```
SELECT *
FROM [Learn SQL].dbo.layoffs_working2;
```
This last query selected all data from the new table named layoffs_working2 and returned 2356 rows.

## 𝐓𝐚𝐬𝐤 𝟒: 𝐒𝐭𝐚𝐧𝐝𝐚𝐫𝐝𝐢𝐳𝐞𝐝 𝐭𝐡𝐞 𝐃𝐚𝐭𝐚 𝐛𝐲 𝐜𝐡𝐞𝐜𝐤𝐢𝐧𝐠 𝐟𝐨𝐫 𝐢𝐧𝐜𝐨𝐫𝐫𝐞𝐜𝐭 𝐬𝐩𝐞𝐥𝐥𝐢𝐧𝐠𝐬 𝐚𝐧𝐝 𝐟𝐢𝐱𝐢𝐧𝐠 𝐭𝐡𝐞𝐦 𝐭𝐨 𝐦𝐚𝐤𝐞 𝐚𝐥𝐥 𝐝𝐚𝐭𝐚 𝐜𝐨𝐧𝐬𝐢𝐬𝐭𝐞𝐧𝐭.
The steps below were completed:

* **Trimmed the data to remove trailing space**  
```
SELECT 
	company, 
	TRIM(company)
FROM [Learn SQL].dbo.layoffs_working2;
```

* **Updated the table with the trimmed columns**  
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET company = TRIM(company);
```

* **Selected all the data from the updated table**  
```
SELECT *
FROM [Learn SQL].dbo.layoffs_working2;
```

* **Checked for misspelled words in the industry column**  
```
SELECT DISTINCT industry
FROM [Learn SQL].dbo.layoffs_working2;
```
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';
```

* **Checked for misspelled words in the location column**  
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET location = 'Malmo'
WHERE location LIKE 'Malmö';
```
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET location = 'Dusseldorf'
WHERE location LIKE 'Düsseldorf';
```
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET location = 'Florianopolis'
WHERE location LIKE 'Florianópolis';
```

* **Checked for misspelled words in the country column**  
```
SELECT DISTINCT country
FROM [Learn SQL].dbo.layoffs_working2;
```
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET country = 'United States'
WHERE country LIKE 'United States%';
```

* **Converted the date column to the date type**  
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET [date] = CAST([date] AS date)
WHERE [date] NOT LIKE 'NULL';
```
> [!Tip]
> You can select all the data from the table to confirm that everything has been updated accordingly.

## 𝐓𝐚𝐬𝐤 𝟓: 𝐋𝐨𝐨𝐤𝐞𝐝 𝐚𝐭 𝐍𝐔𝐋𝐋 𝐚𝐧𝐝 𝐁𝐥𝐚𝐧𝐤 𝐕𝐚𝐥𝐮𝐞𝐬 
This task helped in populating missing data where possible. I used the query below to convert every column with `'NULL'` (varchar data type) to `NULL` where the data type of that column was supposed to be int or float.
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET industry = NULL
WHERE industry = 'NULL';
```
This facilitated the conversion of those columns from string to int or float.  
I realized that SQL Server does not allow the `JOIN` clause in an `UPDATE` statement like in MySQL. So, I had to use a proper `FROM` clause to achieve the same functionality. The following steps were performed:

1. **Updated all the blanks with NULL**  
```
UPDATE [Learn SQL].dbo.layoffs_working2
SET industry = NULL
WHERE industry = '';
```

2. **Performed a self JOIN on the table to identify rows with NULL and empty rows**  
```
SELECT l1.industry, l2.industry
FROM [Learn SQL].dbo.layoffs_working2 l1
JOIN [Learn SQL].dbo.layoffs_working2 l2
	ON l1.company = l2.company
WHERE (l1.industry IS NULL OR l1.industry = '')
AND l2.industry IS NOT NULL;
```

3. **Updated the table by replacing the table on the left side of the JOIN with the values from the table on the right**
```
UPDATE l1
SET l1.industry = l2.industry
FROM [Learn SQL].dbo.layoffs_working2 l1
JOIN [Learn SQL].dbo.layoffs_working2 l2
    ON l1.company = l2.company
WHERE l1.industry IS NULL
  AND l2.industry IS NOT NULL;
```
> [!Note]
> The queries in steps 1, 2, and 3 could be written using CTEs. This was used in the video by [Alex the Analyst](https://www.youtube.com/watch?v=4UltKCnnnTA).

## 𝐓𝐚𝐬𝐤 𝟔: 𝐑𝐞𝐦𝐨𝐯𝐞𝐝 𝐔𝐧𝐧𝐞𝐜𝐞𝐬𝐬𝐚𝐫𝐲 𝐑𝐨𝐰𝐬 𝐚𝐧𝐝 𝐂𝐨𝐥𝐮𝐦𝐧𝐬 
This task served to remove rows and columns that did not add any value to the entire dataset or that would not be needed in the ETL (Extract, Transform, Load) process.
Here I removed the dup_row_num column that was created while identifying duplicates in the data. The following query was used:
```
ALTER TABLE [Learn SQL].dbo.layoffs_working2
DROP COLUMN dup_row_num;
```
The query below allowed to identify NULL in the columns named total_laid_off and percentage_laid_off. The output was 361 rows. Knowing that the raw data was 2361 rows, then 2356 after removing duplicates. Therefore, these rows cannot just be deleted, but will be anlayzed in the second part of the project while identifying trends and patterns in the entire data during the exploratory data analysis.
```
SELECT * 
FROM [Learn SQL].dbo.layoffs_working2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
```


<br/>
   
**Thank you for taking the time to read this report!**

**Please reach out for any updates.**

### Author
[Edwige Songong](https://github.com/Songonge)












