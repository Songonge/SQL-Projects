```sql
-- Creating the database
CREATE DATABASE "Finance Projects"
;

DROP TABLE fact_spends;

CREATE TABLE fact_spends(
    customer_id TEXT,
    month TEXT,
    category TEXT,
    payment_type TEXT,
    spend NUMERIC
);

COPY fact_spends 
FROM 'path to your file'
DELIMITER ','
CSV HEADER
;

SELECT *
FROM fact_spends
; -- This returned 864000 rows and 5 columns

DROP TABLE dim_customers;

CREATE TABLE dim_customers(
    customer_id TEXT PRIMARY KEY,
	age_group TEXT,
	city	TEXT,
	state	TEXT,
	postal_code TEXT,
	region TEXT,
	occupation TEXT,
	gender TEXT,
	marital_status TEXT,
	monthly_income NUMERIC
);

COPY dim_customers
FROM 'path to your file'
DELIMITER ','
CSV HEADER
;

SELECT *
FROM dim_customers
; -- This returned 4000 rows and 10 columns


-------------------------------------------------------------------
-- Checking for NULL Values in the fact_spend table
-------------------------------------------------------------------

SELECT *
FROM fact_spends 
WHERE customer_id IS NULL OR
	month IS NULL OR
	category IS NULL OR
	payment_type IS NULL OR
	spend IS NULL
;	-- No NULL values found


-------------------------------------------------------------------
-- 1. Get all customers who are married.
-------------------------------------------------------------------
-- 1a: List of married customers
SELECT 
	COUNT(*)
FROM dim_customers
WHERE marital_status = 'Married'
; -- This returned 3136 Customers

-- 1b: Total number of customers in each city
SELECT
  city,
  COUNT(*) AS num_customers
FROM dim_customers
GROUP BY city
ORDER BY num_customers DESC
; -- This returned 384 rows with New York City leading (384), followed by Los Angeles (276), Philadelphia (234), and San Francisco (206).


-------------------------------------------------------------------
-- 2. Show the total spend for each customer
-------------------------------------------------------------------
SELECT 
	customer_id,
	SUM(spend)
FROM fact_spends
GROUP BY customer_id
; -- This returned 4000 rows.

-- Another way to write the query
SELECT
  c.customer_id,
  COALESCE(SUM(s.spend), 0) AS total_spends
FROM dim_customers c
LEFT JOIN fact_spends s ON c.customer_id = s.customer_id
GROUP BY c.customer_id
; -- This returned the same result.


-------------------------------------------------------------------
-- 3. Show all customers who spent in the 'Electronics' category
-------------------------------------------------------------------
SELECT 
	DISTINCT customer_id
FROM fact_spends
WHERE category = 'Electronics'
; -- This returned 4000 rows.

-- Another way to write the query
SELECT DISTINCT c.*
FROM dim_customers c
JOIN fact_spends s ON c.customer_id = s.customer_id
WHERE s.category = 'Electronics';


-------------------------------------------------------------------
-- 4. Find the average spend for each payment type
-------------------------------------------------------------------
SELECT
	payment_type,
	ROUND(AVG(spend), 0) AS avg_spend
FROM fact_spends
GROUP BY payment_type
ORDER BY avg_spend DESC
;


-------------------------------------------------------------------
-- 5. Total amount spent by each customer in the month of May
-------------------------------------------------------------------
SELECT
	customer_id,
	SUM(spend) AS amount_spend_may
FROM fact_spends
WHERE month = 'May'
GROUP BY customer_id
ORDER BY amount_spend_may DESC
;


-------------------------------------------------------------------
-- 6. Number of customers in each occupation
-------------------------------------------------------------------
SELECT 
	occupation,
	COUNT(customer_id) AS cust_occ_count
FROM dim_customers
GROUP BY occupation
ORDER BY cust_occ_count DESC;
;


-------------------------------------------------------------------
-- 7. Details of customers in the age group '25-34'
-------------------------------------------------------------------
SELECT *
FROM dim_customers
WHERE age_group = '25-34';


-------------------------------------------------------------------
-- 8. List all customers who used using Debit Card
-------------------------------------------------------------------
SELECT 
	DISTINCT c.customer_id
FROM dim_customers c
JOIN fact_spends s
	ON c.customer_id = s.customer_id
WHERE payment_type = 'Debit Card'
;


-------------------------------------------------------------------
-- 9. Total spend for each age group in the Entertainment category
-------------------------------------------------------------------
-- Renaming the age_group column to age_interval
ALTER TABLE dim_customers 
RENAME COLUMN age_group TO age_interval
;

-- Putting age_interval into groups
SELECT 
	age_interval,
	CASE 
		WHEN age_interval = '21-24' THEN 'Youth'
		WHEN age_interval = '25-34' THEN 'Young Adult'
		WHEN age_interval = '35-45' THEN 'Adult'
		ELSE 'Senior'
	END AS age_group
FROM dim_customers
;

-- Adding the age_group column to the dim_customers table
ALTER TABLE dim_customers
ADD COLUMN age_group TEXT
;

-- Filling the age_group column based on the age_interval column
UPDATE dim_customers
SET age_group = 
	CASE 
		WHEN age_interval = '21-24' THEN 'Youth'
		WHEN age_interval = '25-34' THEN 'Young Adult'
		WHEN age_interval = '35-45' THEN 'Adult'
		ELSE 'Senior'
	END 
;

-- Determining total spend for each age group in the Entertainment category
SELECT 
	c.age_group,
	SUM(s.spend) AS total_spend_entertainment
FROM fact_spends s 
JOIN dim_customers c
	ON s.customer_id = c.customer_id
WHERE category = 'Entertainment'
Group BY age_group
ORDER BY total_spend_entertainment DESC
;


-------------------------------------------------------------------
-- 10. The highest spend by a customer in the 'Food' category in October
-------------------------------------------------------------------
-- Total per customer in Food during October, then top 1
SELECT 
	customer_id,
	category,
	SUM(spend) AS total_spend_food
FROM fact_spends 
WHERE category = 'Food' 
	AND month = 'October'
Group BY customer_id, category
ORDER BY total_spend_food DESC
LIMIT 1
;


-------------------------------------------------------------------
-- 11. The average income of customers in each occupation
-------------------------------------------------------------------
SELECT *
FROM dim_customers;
SELECT 
	occupation,
	COUNT(customer_id),
	ROUND(AVG(monthly_income), 0) AS avg_income
FROM dim_customers 
GROUP BY occupation
;


-------------------------------------------------------------------
-- 12. All customers who spent in the 'Electronics' category, including the age group
-------------------------------------------------------------------
SELECT 
	DISTINCT c.customer_id,
	c.age_group,
	c.gender,
  	c.city,
  	c.occupation,
  	c.monthly_income
FROM dim_customers c
JOIN fact_spends s
	ON c.customer_id = s.customer_id
WHERE s.category = 'Electronics'
;


-------------------------------------------------------------------
-- 13. Total spend for each city
-------------------------------------------------------------------
SELECT
	c.city,
  	SUM(s.spend) AS total_spend
FROM fact_spends s
JOIN dim_customers c 
	ON s.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_spend DESC;


-------------------------------------------------------------------
-- 14. Average income of customers who spent on 'Entertainment' in July
-------------------------------------------------------------------
SELECT
	COUNT(DISTINCT c.customer_id),
  	ROUND(AVG(c.monthly_income), 0) AS avg_income
FROM dim_customers c
JOIN fact_spends s
	ON c.customer_id = s.customer_id 
WHERE s.category = 'Entertainment' 
	AND month = 'July'
ORDER BY avg_income DESC
;

SELECT
	AVG(c.monthly_income) AS avg_income_ent_july,
	COUNT(DISTINCT c.customer_id) AS num_customers
FROM dim_customers c
WHERE c.customer_id IN (
	SELECT 
  		DISTINCT customer_id
  	FROM fact_spends
  	WHERE category = 'Entertainment' 
  		AND month = 'July'
);


-------------------------------------------------------------------
-- 16. Total spend per customer by age group and category
-------------------------------------------------------------------
SELECT
	c.age_group,
	s.category,
	SUM(s.spend) AS total_spend
FROM fact_spends s
LEFT JOIN dim_customers c
	ON s.customer_id = c.customer_id
Group BY age_group, category
;

-- Another way to write the query
SELECT
  c.age_group,
  s.category,
  SUM(s.spend) AS total_spend
FROM fact_spends s
JOIN dim_customers c ON s.customer_id = c.customer_id
GROUP BY c.age_group, s.category
;


-------------------------------------------------------------------
-- 17.a For each occupation, average monthly spend by payment type across months
-------------------------------------------------------------------
-- Step 1: compute monthly spend per customer & payment_type
WITH month_payment_type AS (
	SELECT 
		customer_id,
		month,
		payment_type,
		SUM(spend) AS total_spend
	FROM fact_spends
	GROUP BY customer_id, month, payment_type
)
-- Step 2: join occupation and compute average monthly spend per occupation/payment_type
SELECT
	c.occupation,
	mpt.payment_type,
	ROUND(AVG(mpt.total_spend), 0) AS avg_monthly_spend
FROM month_payment_type mpt 
JOIN dim_customers c
	ON c.customer_id = mpt.customer_id
GROUP BY c.occupation, mpt.payment_type
ORDER BY c.occupation, avg_monthly_spend DESC
;

-- Another way to write the query
-- Step 1: compute monthly spend per customer & payment_type
WITH cust_month_payment AS (
  SELECT
    customer_id,
    month,
    payment_type,
    SUM(spend) AS monthly_spend
  FROM fact_spends
  GROUP BY customer_id, month, payment_type
)
-- Step 2: join occupation and compute average monthly spend per occupation/payment_type
SELECT
  c.occupation,
  cmp.payment_type,
  AVG(cmp.monthly_spend) AS avg_monthly_spend,
  COUNT(DISTINCT cmp.customer_id) AS distinct_customers_months
FROM cust_month_payment cmp
JOIN dim_customers c ON cmp.customer_id = c.customer_id
GROUP BY c.occupation, cmp.payment_type
ORDER BY c.occupation, avg_monthly_spend DESC;


-------------------------------------------------------------------
-- 17.b Identify preferred payment type in each occupation group
-- (computed as a share of total spends within occupation)
-------------------------------------------------------------------
WITH occ_payment AS (
	SELECT
    	c.occupation,
    	s.payment_type,
    	SUM(s.spend) AS total_spend
  	FROM fact_spends s
  	JOIN dim_customers c 
	  	ON s.customer_id = c.customer_id
  	GROUP BY c.occupation, s.payment_type
),
occ_totals AS (
	SELECT 
		occupation, 
		SUM(total_spend) AS occ_total_spend
  	FROM occ_payment
  	GROUP BY occupation
)
SELECT
	op.occupation,
  	op.payment_type,
  	op.total_spend,
  	ROUND(op.total_spend / ot.occ_total_spend, 2) AS pct_share_within_occupation
FROM occ_payment op
JOIN occ_totals ot 
	ON op.occupation = ot.occupation
ORDER BY op.occupation, pct_share_within_occupation DESC;


-------------------------------------------------------------------
-- End 
-------------------------------------------------------------------

```

