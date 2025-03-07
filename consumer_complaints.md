<!---
DROP TABLE complaints_raw
;

-- Creating the table
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

-- Loading the data in the table from the .csv file
COPY complaints_raw
FROM 'C:\Users\edwig\Documents\Courses\Kaggle Datasets\complaints.csv'
null 'NULL'
DELIMITER ','
CSV HEADER
;

SELECT * 
FROM complaints_raw
;

CREATE TABLE complaints AS
SELECT * FROM complaints_raw
;

SELECT * 
FROM complaints
; -- This returned 3585952 rows

SELECT 
	company,
	COUNT(*) AS total
FROM complaints
GROUP BY company
ORDER BY total DESC
; -- This returned 6731 rows with EQUIFAX, INC as the leading company

SELECT 
	DISTINCT company,
	COUNT(complaint_id) AS total_complaints
FROM complaints
GROUP BY company
ORDER BY total_complaints DESC
;  -- This returned 6731 rows with EQUIFAX, INC as the leading company

SELECT 
	COUNT(complaint_id) AS total_complaints
FROM complaints
;  -- This returned 3585952 rows

SELECT *
FROM complaints
WHERE product IS NULL
;  -- Zero row returned

SELECT 
	product,
	COUNT(*) AS total_each_product
FROM complaints
GROUP BY product
ORDER BY total_each_product DESC
; -- This returned 18 rows

SELECT 
	COUNT(*) consumer_disputed_all
FROM complaints
WHERE consumer_disputed IS NOT NULL
; -- This returned 3585952 rows which is the total number of rows
-- meaning that there are no null values

SELECT 
	COUNT(*) consumer_disputed_all
FROM complaints
WHERE consumer_disputed IS NULL
; -- Zero row returned

SELECT 
	DISTINCT consumer_disputed,
	COUNT(*)
FROM complaints
GROUP BY consumer_disputed
; -- This returned 3 rows with N/A = 2817594, No = 619980, Yes = 148378

SELECT 
	DISTINCT company,
	COUNT(*) consumer_disputed_all
FROM complaints
WHERE consumer_disputed LIKE 'Yes'
GROUP BY company
ORDER BY consumer_disputed_all DESC
; -- This returned 2475 rows with "BANK OF AMERICA, NATIONAL ASSOCIATION" on top with 14387 disputes.

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
; -- This returned 78.57

SELECT 
	Company_response_to_consumer,
	COUNT(*) AS responses
FROM complaints
GROUP BY Company_response_to_consumer
ORDER BY responses DESC
; -- This returned 9 rows

SELECT 
	*
FROM complaints
WHERE Company_response_to_consumer = ''
; -- This returned 4 rows

UPDATE complaints
SET Company_response_to_consumer = 'Closed with explanation'
WHERE Company_response_to_consumer = ''
; -- This added 4 to Company_response_to_consumer = 'Closed with explanation'

SELECT
	complaint_id,
	Company_response_to_consumer,
	company_public_response
FROM complaints
WHERE company_public_response = 'Company has responded to the consumer and the CFPB and chooses not to provide a public response'
; -- This returned 1386092 rows

SELECT
	*
FROM complaints
WHERE company_public_response = ''
; -- This returned 1981357 rows

SELECT
	DISTINCT company_public_response,
	COUNT(*)
FROM complaints
GROUP BY company_public_response
ORDER BY count DESC
;

UPDATE complaints
SET company_public_response = 'N/A'
WHERE company_public_response = ''
; -- This updated 1981357 values

SELECT
	*
FROM complaints
WHERE issue = 'NULL'
; -- No null values found

SELECT 
	DISTINCT issue
FROM complaints
; -- This returned 165 rows

SELECT
	*
FROM complaints
WHERE timely_response IS NULL
; -- No null values found

SELECT 
	DISTINCT timely_response,
	COUNT(*) AS total_timely_response
FROM complaints
GROUP BY timely_response
; -- This returned Yes: 3533574 and No: 52378

-- This is to check for duplicates
SELECT
	complaint_id,
	COUNT(*)
FROM complaints
GROUP BY complaint_id
HAVING COUNT(*) > 1
; -- No duplicate values found

ALTER TABLE complaints
DROP COLUMN consumer_complaint_narrative
; -- We do not need this column in the analysis.

SELECT
	*
FROM complaints
WHERE state = ''
; -- This returned 41219 rows

UPDATE complaints
SET state = 'N/A'
WHERE state = ''
; -- This updated 41219 values

SELECT
	*
FROM complaints
WHERE zip_code = ''
; -- This returned 41756 rows

UPDATE complaints
SET zip_code = 'N/A'
WHERE zip_code = ''
; -- This updated 41756 values

SELECT
	tags,
	COUNT(*)
FROM complaints
GROUP BY tags
; 

SELECT
	*
FROM complaints
WHERE tags = ''
; -- This returned 3194575 rows

UPDATE complaints
SET tags = 'N/A'
WHERE tags = ''
; -- This updated 3194575 values

SELECT 
	EXTRACT(YEAR FROM date_received) year_ext
FROM complaints
GROUP BY year_ext
; -- The years range from 2011 till 2023

SELECT 
	DISTINCT date_received
FROM complaints
WHERE date_received IS NULL
; -- No nulls found

SELECT 
	sub_product,
	COUNT(*)
FROM complaints
GROUP BY sub_product
ORDER BY count
; -- This returned 77 rows with 235291 nulls

UPDATE complaints
SET sub_product = 'N/A'
WHERE sub_product = ''
; -- This updated 235291 values

SELECT 
	*
FROM complaints
WHERE company = '' OR company = 'NULL' OR company IS NULL
; -- No nulls found

SELECT 
	*
FROM complaints
WHERE consumer_consent_provided = '' 
	OR consumer_consent_provided = 'NULL' 
	OR consumer_consent_provided IS NULL
; -- This returned 146563

SELECT 
	DISTINCT consumer_consent_provided,
	COUNT(*)
FROM complaints
GROUP BY consumer_consent_provided
;

UPDATE complaints
SET consumer_consent_provided = 'N/A'
WHERE consumer_consent_provided = ''
; -- This updated 146563 values

SELECT 
	*
FROM complaints
WHERE sub_issue = '' 
	OR sub_issue = 'NULL' 
	OR sub_issue IS NULL
; -- This returned 704472

SELECT 
	DISTINCT sub_issue,
	COUNT(*)
FROM complaints
GROUP BY sub_issue
;

UPDATE complaints
SET sub_issue = 'N/A'
WHERE sub_issue = ''
; -- This updated 704472 values

ALTER TABLE complaints
RENAME submited_via TO submitted_via
;

SELECT 
	*
FROM complaints
WHERE submitted_via = '' 
	OR submitted_via = 'NULL' 
	OR submitted_via IS NULL
; -- No NULL found

SELECT 
	*
FROM complaints
WHERE date_sent_to_company IS NULL
; -- No NULL found

SELECT 
	*
FROM complaints
WHERE timely_response = '' 
	OR timely_response = 'NULL' 
	OR timely_response IS NULL
; -- No NULL found

SELECT 
	*
FROM complaints
WHERE consumer_disputed = '' 
	OR consumer_disputed = 'NULL' 
	OR consumer_disputed IS NULL
; -- No NULL found

SELECT 
	*
FROM complaints
WHERE complaint_id = '' 
	OR complaint_id = 'NULL' 
	OR complaint_id IS NULL
; -- No NULL found

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
