# Project: Consumer Complaints Data Cleaning in PostgreSQL and Preliminary Insights 
----

## Table of Contents
1. [Introduction](#𝐈𝐧𝐭𝐫𝐨𝐝𝐮𝐜𝐭𝐢𝐨𝐧)
2. [Problem Statement](#Problem-Statement)
3. [Deliverables](#deliverables)
4. [Tech Stack](#tech-stack)
5. [Data Information](#Data-Information)
   * [Description of Each Column in the Table](#Description-of-each-column-in-the-table)
6. [Creating the Database](#Creating-the-Database)
7. [Creating the Table](#creating-the-table)
   * [Dropping the Table if it Exists](#Dropping-the-Table-if-it-Exists)
   * [Creating Columns in the Table](#Creating-Columns-in-the-Table)
8. [Inserting Values in the Table](#Inserting-Values-in-the-Table)
   * [Retrieving Data from the Table](#Retrieving-Data-from-the-Table)
9. [Creating a new Table](#Creating-a-new-Table)
   * [Retrieving Data from the New Table](#Retrieving-Data-from-the-new-Table)
<!--
10. [Part I: Data Cleaning](#part-I-data-cleaning) 
    * [Renaming Columns in the Table](#Renaming-Columns-in-the-Table)
    * [Checking and Removing Duplicates](#Checking-and-Removing-Duplicates)
      * [Checking for Duplicates](#Checking-for-Duplicates)
      * [Returning Duplicates based on One Column](#Returning-Duplicates-based-on-One-Column)
      * [Returning all Rows with Duplicates](#Returning-all-Rows-with-Duplicates)
      * [Assigning A Unique Identifier to Each Row](#Assigning-A-Unique-Identifier-to-Each-Row)
    * [Checking and Replacing NULL Values](#Checking-and-Replacing-NULL-Values)
      * [Checking for NULL Values](#Checking-for-NULL-Values)
      * [Replacing NULL Values](#Replacing-NULL-Values)
    * [Creating New Columns](#Creating-New-Columns)
      * [Adding and Populating the Column start_time](#Adding-and-Populating-the-Column-start_time)
      * [Adding and Populating the Column end_time](#Adding-and-Populating-the-Column-end_time)
      * [Adding and Populating the Column minutes_played](#Adding-and-Populating-the-Column-minutes_played)
      * [Adding and Populating the Column date_played](#Adding-and-Populating-the-Column-date_played)
11. [Part II: Answering the Business Questions](#part-II-Answering-the-Business-Questions)
    * [A. Impact of Shuffle Mode on Listening Behavior](#A-Impact-of-Shuffle-Mode-on-Listening-Behavior)
    * [B. Track Completion Rates](#B-Track-Completion-Rates)
    * [C. Platform Usage Trends](#C-Platform-Usage-Trends)
12. [Conclusion](#conclusion)
-->

## Introduction
The Consumer Complaint Database is a compilation of complaints regarding consumer financial services and products that are forwarded to businesses for resolution. After the business responds and confirms a business relationship with the customer, the complaint is published. The Consumer Complaint Database does not publish complaints that are forwarded to other regulators, such as those concerning banking institutions with assets under $10 billion. In general, the database is updated every day. 

In this project, we are focusing on cleaning the Consumer Complaints data to prepare it for analysis. 


## Problem Statement
The main problem regarding this dataset is as follows: How can financial institutions reduce unresolved complaints and improve response times to enhance customer satisfaction and regulatory compliance?  

Addressing this problem is of paramount importance because:  
1. Delayed or inadequate responses to consumer complaints can lead to compliance violations and legal penalties.  
2. Poorly handled complaints increase dissatisfaction and can lead to customer churn.  
3. Identifying bottlenecks in the complaint resolution process helps companies streamline their operations.


## Deliverables
Here are the deliverables of this project:  
1. Identify companies with the most complaints and the highest dispute rates  
2. Analyze common complaint types and trends over time
3. Assess which complaint issues remain unresolved
4. Evaluate response times and effectiveness
5. Create a dashboard to visualize company performance and consumer disputes
6. Provide data-driven recommendations for improving complaint resolution


## Tech Stack
The cleaning part of this project will be done in **PostgreSQL**. The current report provides all information related to data cleaning in PostgreSQL and the queries written to retrieve insights.


## Data Information
To get the data, it was not straightforward, as we always go ahead and download it from Kaggle. Instead, I used the **Python API** to get it. Here is how I proceeded:  
1. Visited **Kaggle**'s website and typed '**Consumer Complaints**' in the search bar. You can also use this [link](https://www.kaggle.com/datasets/selener/consumer-complaint-database).
2. Clicked on the 'Download' button. This opened the code to be used in Python, which I could copy and paste directly into a Python environment. But there are other steps to be completed before this.

### On your local computer
1. Go to the local disk on your computer.
2. Navigate to your root: `C:\Users\yourusername`
3. Create a new folder named **.kaggle**
4. Navigate to a directory on your computer where you want the file to be downloaded. For example, **Documents**, or create a new folder on your computer and name it as you want.

### On Kaggle
Go to Kaggle and get the API Key. Proceed as follows:  
1. Click on your picture on your Kaggle profile.
2. Click on Settings and scroll down until you see API.
3. Click on '**Create New Token**' (This token will be used every time you want to download any dataset from Kaggle using this method.)
4. Save this to the **.kaggle** folder you created earlier (This is a JSON file.).

### On Visual Studio (VS) Code
1. Right-click on the folder you created, which will contain the downloaded dataset, and select '**Open in Terminal**' from the menu.
2. In the terminal, type `code .` and this will open VS Code for you. 
> [!Note]
> Another way is to just launch VS Code and open the folder from your computer.  

3. Create a new file with the extension `.ipynb` (This is a Jupyter notebook.)
4. Write the following lines of code and run them:  
* Install Kaggle
```py
pip install kaggle
```
* Import Kaggle
```
import kaggle
```
* Now, we need to check if we have access to the dataset.
```
!kaggle datasets list
```
* Next, we go back to the consumer complaints page on Kaggle and copy the path (text between the double quotes) from the code I mentioned in the second bullet on the **Data information** section. Go to VS Code and write the following to download the dataset:
```
!kaggle datasets download -d utkarshx27/consumer-complaint --unzip
```
> [!Note]
> `utkarshx27/consumer-complaint` is the path copied.
> `--unzip` is added to the line of code to unzip the data as soon as it is downloaded.

You can now view the `.csv` file in your folder.

The downloaded data contained the following information:  
* Number of rows: `3585952` rows  
* Number of columns: `18` columns


### Description of Each Column in the Table
The data downloaded was stored in a .csv file. Each column in the file is described as follows.  
1. _Date received_ (DATE): The date when the consumer complaint was received.
2. _Product_ (TEXT): The specific financial product or service associated with the complaint.
3. _Sub-product_ (TEXT): Further sub-categorization of the product or service, if applicable.
4. _Issue_ (TEXT): The main issue or problem described in the consumer complaint.
5. _Sub-issue_ (TEXT): Additional details or sub-category related to the main issue.
6. _Consumer_complaint_narrative_  (TEXT): The text description provided by the consumer detailing their complaint.
7. _Company_public_response_ (TEXT): The response or statement issued by the company regarding the complaint.
8. _Company_ (TEXT): The name of the company being complained about.
9. _State_ (TEXT): The state where the consumer resides.
10. _ZIP_code_ (TEXT): The ZIP code of the consumer's location.
11. _Tags_ (TEXT): Any additional tags or labels associated with the complaint.
12. _Consumer_consent_provided_ (TEXT): Indicates whether the consumer provided consent for their complaint to be published.
13. _Submitted_via_ (TEXT): The channel or method through which the complaint was submitted.
14. _Date_sent_to_company_ (TEXT): The date when the complaint was sent to the company for response.
15. _Company_response_to_consumer_ (TEXT): The company's response or resolution to the consumer's complaint.
16. _Timely_response_ (TEXT): Indicates whether the company provided a timely response to the complaint.
17. _Consumer_disputed_ (TEXT): Indicates whether the consumer disputed the company's response.
18. _Complaint_ID_ (TEXT): A unique identifier assigned to each complaint.
	

## Creating the Database
Since I already have the database available, I will just go ahead and create my table to store the data. If not, the following query can be used: 
```
CREATE DATABASE sql_projects
;
```
In this query, **sql_projects** represents the name of the database.

## Creating the Table

### Dropping the Table if it Exists
```
DROP TABLE complaints_raw
;
```

### Creating Columns in the Table 
The query below was written to create columns in the table called **complaints_raw**, which will be populated using the downloaded table. If we were working with **MS SQL Server**, we will just import the downloaded **.csv** file without stress.
```
CREATE TABLE complaints_raw (
	date_received DATE,
	Product TEXT,
	Sub_product TEXT,
	Issue TEXT,
	Sub_issue TEXT,
	Consumer_complaint_narrative TEXT,
	Company_public_response TEXT,
	Company TEXT,
	State TEXT,
	ZIP_code TEXT,
	Tags TEXT,
	Consumer_consent_provided TEXT,
	Submited_via TEXT,
	Date_sent_to_company DATE,
	Company_response_to_consumer TEXT,
	Timely_response TEXT,
	Consumer_disputed TEXT, 
	Complaint_ID TEXT
)
;
```

### Loading the Data in the New Columns
To populate the created column with data, we used the table from the **.csv** file. The query read as follows:
```
COPY complaints_raw
FROM 'C:\Users\edwig\Documents\Courses\Kaggle Datasets\complaints.csv'
null 'NULL'
DELIMITER ','
CSV HEADER
;
```

### Retrieving all the Data from the Table
```
SELECT * 
FROM complaints_raw
;
```
This returned `3585952` rows.

## Creating a New Table 
```
CREATE TABLE complaints AS
SELECT * FROM complaints_raw
;
```
> [!Important]
> Always copy the raw data to a new table while keeping the raw data intact. Perform all cleaning and transformations on the copied table.
> The raw data can be referred to at any stage of the data cleaning or analysis process if needed.

Now, we write the following query to retrieve the data from the newly copied table.
```
SELECT * 
FROM complaints
;
```
This also returned `3585952` rows as expected.

## Exploratory Data Analysis
After previewing the data, I realized that the column named _Consumer_complaint_narrative_ was not needed in for the analysis. So, I wrote the following query to delete it.
```
ALTER TABLE complaints
DROP COLUMN consumer_complaint_narrative
; 
```

### Counting the number of companies.
```
SELECT 
	DISTINCT company,
	COUNT(*) AS total
FROM complaints
GROUP BY company
ORDER BY total DESC
;
```
This returned `6731` rows with **EQUIFAX, INC.** as the leading company

### Counting the Total Quantity for Each Product
```
SELECT 
	product,
	COUNT(*) AS total_each_product
FROM complaints
GROUP BY product
ORDER BY total_each_product DESC
;
```
This returned `18` rows, with **Credit report, credit ...** as the leading product.

### Returning the percentage of dispute
```
WITH null_from_disputes AS (
	SELECT
		COUNT(*) null_disputes 
	FROM complaints
	WHERE consumer_disputed = 'N/A'
),
total_disputes AS (
	SELECT
		COUNT(*) total_dispute
	FROM complaints
)
SELECT 
	ROUND(null_disputes * 100.0/NULLIF(total_dispute,0), 2) AS percentage_dispute
FROM null_from_disputes, total_disputes
;
```
This returned `78.57`, which is very high.

### Checking data in the _Company_response_to_consumer_ column
```
SELECT 
	Company_response_to_consumer,
	COUNT(*) AS responses
FROM complaints
GROUP BY Company_response_to_consumer
ORDER BY responses DESC
; 
```
This returned `9` rows, with **Closed with explanation** having the highest amount equal to `2,675,823`. This shows that most complaints were resolved.

### Checking for NULL Values
1. Checking for NULL values in the product column
```
SELECT *
FROM complaints
WHERE product IS NULL
;  
```
Zero row returned, indicating that there are no nulls.

2. Checking for NULL values in the _consumer_disputed_all_ column
```
SELECT 
	COUNT(*) consumer_disputed_all
FROM complaints
WHERE consumer_disputed IS NOT NULL
;
```
This returned `3585952` rows, which is the total number of rows. This means that there are no null values. The following query also returned zero.
```
SELECT 
	COUNT(*) consumer_disputed_all
FROM complaints
WHERE consumer_disputed IS NULL
; 
```

<!--
SELECT 
	DISTINCT consumer_disputed,
	COUNT(*)
FROM complaints
GROUP BY consumer_disputed
; -- This returned 3 rows with N/A = 2817594, No = 619980, Yes = 148378
-->

## Checking for the company with the highest disputes
```
SELECT 
	DISTINCT company,
	COUNT(*) consumer_disputed_all
FROM complaints
WHERE consumer_disputed LIKE 'Yes'
GROUP BY company
ORDER BY consumer_disputed_all DESC
;
```
-- This returned `2475` rows with **BANK OF AMERICA, NATIONAL ASSOCIATION** on top with the total number of `14387` disputes.

### Checking and populating empty cells in the _Company_response_to_consumer_ column
```
SELECT 
	*
FROM complaints
WHERE Company_response_to_consumer = ''
;
```
This returned `4` rows.
```
UPDATE complaints
SET Company_response_to_consumer = 'Closed with explanation'
WHERE Company_response_to_consumer = ''
;
```
This added `4` to _Company_response_to_consumer_ = 'Closed with explanation'

<!--
SELECT
	complaint_id,
	Company_response_to_consumer,
	company_public_response
FROM complaints
WHERE company_public_response = 'Company has responded to the consumer and the CFPB and chooses not to provide a public response'
; -- This returned 1386092 rows
-->

### Checking and populating empty cells in the _company_public_response_ column
```
SELECT
	DISTINCT company_public_response,
	COUNT(*)
FROM complaints
GROUP BY company_public_response
ORDER BY count DESC
;
```
This returned 12 rows with **N/A** on top with `1,981,357`. Then, we wrote the following query to retrieve empty cells. 
```
SELECT
	*
FROM complaints
WHERE company_public_response = ''
; 
```
This returned `1,981,357` rows, confirming the above number. Now we update the empty cells wit **N/A**.
```
UPDATE complaints
SET company_public_response = 'N/A'
WHERE company_public_response = ''
;
```
This updated `1,981,357` cells.

### Checking for NULL values in the _State_ column
```
SELECT
	*
FROM complaints
WHERE state = ''
;
```
This returned `41,219` rows.

Filling the empty cells with **N/A**.
```
UPDATE complaints
SET state = 'N/A'
WHERE state = ''
;
```
This query updated `41,219` cells.

### Checking for NULL values in the _Zip_code_ column
```
SELECT
	*
FROM complaints
WHERE zip_code = ''
; 
```
This returned `41,756` rows.

Filling the empty cells with **N/A**.
```
UPDATE complaints
SET zip_code = 'N/A'
WHERE zip_code = ''
; 
```
This updated `41,756` values.

### Checking for NULL values in the _Tags_ column
```
SELECT
	tags,
	COUNT(*)
FROM complaints
GROUP BY tags
; 
```

```
SELECT
	*
FROM complaints
WHERE tags = ''
;
```
This returned `3,194,575` rows.

Filling the empty cells with **N/A**.
```
UPDATE complaints
SET tags = 'N/A'
WHERE tags = ''
;
```
This updated `3,194,575` values

### Checking for NULL values in the _Sub_product_ column
```
SELECT 
	sub_product,
	COUNT(*)
FROM complaints
GROUP BY sub_product
ORDER BY count
;
```
This returned `77` rows with `235,291` nulls.

Filling the empty cells with **N/A**.
```
UPDATE complaints
SET sub_product = 'N/A'
WHERE sub_product = ''
;
```
This updated `235,291` values.

### Checking for NULL values in the _Consumer_consent_provided_ column
```
SELECT 
	*
FROM complaints
WHERE consumer_consent_provided = '' 
	OR consumer_consent_provided = 'NULL' 
	OR consumer_consent_provided IS NULL
;
```
This returned `146,563` rows.
<!--- ```
SELECT 
	DISTINCT consumer_consent_provided,
	COUNT(*)
FROM complaints
GROUP BY consumer_consent_provided
;
```
-->

Filling the empty cells with **N/A**.
```
UPDATE complaints
SET consumer_consent_provided = 'N/A'
WHERE consumer_consent_provided = ''
; 
```
This updated `146,563` values.

### Checking for NULL values in the _Sub_issue_ column
```
SELECT 
	*
FROM complaints
WHERE sub_issue = '' 
	OR sub_issue = 'NULL' 
	OR sub_issue IS NULL
; 
```
This returned 704472

<!--
SELECT 
	DISTINCT sub_issue,
	COUNT(*)
FROM complaints
GROUP BY sub_issue
;
-->

Filling the empty cells with **N/A**.
```
UPDATE complaints
SET sub_issue = 'N/A'
WHERE sub_issue = ''
; 
```
This updated `704,472` values.


### Checking for NULL values in other columns
```
SELECT
	*
FROM complaints
WHERE issue = 'NULL'
;
```
No null values found.
<!-- ```
SELECT 
	DISTINCT issue
FROM complaints
;
```
This returned 165 rows
-->

```
SELECT
	*
FROM complaints
WHERE timely_response IS NULL
;
```
No null values found.

```
SELECT 
	DISTINCT date_received
FROM complaints
WHERE date_received IS NULL
;
```
No nulls found.

```
SELECT 
	*
FROM complaints
WHERE company = '' OR company = 'NULL' OR company IS NULL
; 
```
No nulls found.

```
SELECT 
	*
FROM complaints
WHERE submitted_via = '' 
	OR submitted_via = 'NULL' 
	OR submitted_via IS NULL
; 
```
No NULL found.

```
SELECT 
	*
FROM complaints
WHERE date_sent_to_company IS NULL
;
```
No NULL found.

```
SELECT 
	*
FROM complaints
WHERE timely_response = '' 
	OR timely_response = 'NULL' 
	OR timely_response IS NULL
; 
```
No NULL found.

```
SELECT 
	*
FROM complaints
WHERE consumer_disputed = '' 
	OR consumer_disputed = 'NULL' 
	OR consumer_disputed IS NULL
; 
```
No NULL found.

```
SELECT 
	*
FROM complaints
WHERE complaint_id = '' 
	OR complaint_id = 'NULL' 
	OR complaint_id IS NULL
; 
```
No NULL found.


## Evaluating Response Time
```
SELECT 
	DISTINCT timely_response,
	COUNT(*) AS total_timely_response
FROM complaints
GROUP BY timely_response
;
```
This returned:  
* Yes: `3,533,574`
* No: `52,378`
We can see from the results that most responses were given on time.



## Checking for Duplicate Values
The _Complaint_ID_ is considered our **primary key**. So, we should check for duplicate values in it. The query reads as follows.
```
SELECT
	complaint_id,
	COUNT(*)
FROM complaints
GROUP BY complaint_id
HAVING COUNT(*) > 1
;
```
No duplicate values found.

















<!--
SELECT 
	EXTRACT(YEAR FROM date_received) year_ext
FROM complaints
GROUP BY year_ext
; -- The years range from 2011 to 2023

ALTER TABLE complaints
RENAME submited_via TO submitted_via
;

CREATE TABLE complaint_cleaned AS
SELECT *
FROM complaints
;

ALTER TABLE complaints
ADD CONSTRAINT primary_ky PRIMARY KEY (complaint_id)
;

CREATE TABLE products AS 
SELECT 
	DISTINCT product, 
	sub_product
FROM complaints
;

SELECT *
FROM products
; -- This returned 101 rows

SELECT 
	DISTINCT product
FROM products
; -- This returned 18 rows

CREATE TABLE issues AS 
SELECT 
	DISTINCT issue, 
	sub_issue
FROM complaints
;

SELECT 
	* 
FROM issues
;  -- This returned 369 rows

SELECT 
	DISTINCT issue
FROM issues
; -- This returned 165 rows

CREATE TABLE companies AS 
SELECT 
	DISTINCT company, 
	company_public_response,
	company_response_to_consumer
FROM complaints
; -- This returned 25229 rows

SELECT *
FROM companies
;-- This returned 25229 rows

SELECT 
	DISTINCT company
FROM companies
; -- This returned 6731 rows

SELECT *
FROM complaints
;

--->
