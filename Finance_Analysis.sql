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
FROM 'C:\Users\edwig\Documents\Courses\Challenges\Some projects\Finance\finance_fact_spends.csv'
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
FROM 'C:\Users\edwig\Documents\Courses\Challenges\Some projects\Finance\finance_dim_customers.csv'
DELIMITER ','
CSV HEADER
;

SELECT *
FROM dim_customers
; -- This returned 4000 rows and 10 columns


-------------------------------------------------------------------
-- Utilities / Common CTEs used by many queries
-------------------------------------------------------------------

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

-- -- 0. sanitized spends (treat NULL as 0) and unique customers list

-- WITH fact_spends_new AS (
--   SELECT
--     customer_id,
--     month,
--     category,
--     payment_type,
--     COALESCE(spends, 0)::NUMERIC AS spends
--   FROM fact_spends
-- ),
-- customers AS (
--   SELECT * FROM dim_customers
-- )

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
; -- This returned 384 rows with New York City leading (384), followed by Los Angeles (276), Philadelphia (234) and San Francisco (206).


-------------------------------------------------------------------
-- 2. Show the total spends for each customer
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
-- 8. List all customers who spent using Debit Card
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
ALTER TABLE dim_customers 
RENAME COLUMN age_group TO age_interval
;

SELECT 
	age_interval,
	CASE 
		WHEN age_interval = '21-24' THEN 'Youth'
		WHEN age_interval = '25-34' THEN 'Young Adult'
		WHEN age_interval = '35-45' THEN 'Adult'
		ELSE 'Senior'
	END AS age_goup
FROM dim_customers
;

ALTER TABLE dim_customers
ADD COLUMN age_group TEXT
;

UPDATE dim_customers
SET age_group = 
	CASE 
		WHEN age_interval = '21-24' THEN 'Youth'
		WHEN age_interval = '25-34' THEN 'Young Adult'
		WHEN age_interval = '35-45' THEN 'Adult'
		ELSE 'Senior'
	END 
;
SELECT *
FROM fact_spends;

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
-- 10. Highest spend by a customer in 'Food' category in October
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
-- 11. Average income of customers in each occupation
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
-- 12. All customers who spent in 'Electronics' category, including age group
-- (If you have a name column, add it to SELECT)
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
-- (computed as share of total spends within occupation)
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
-- 18.a How do spending patterns differ among customers from various income brackets (city & age group)?
-- Create income brackets (tertiles) and compute avg spend per bracket × city × age_group
-- NOTE: NTILE(3) used here (Postgres / SQL Server). For MySQL use variables or CASE logic.
-------------------------------------------------------------------
WITH cust_bracket AS (
  SELECT
    customer_id,
    average_income,
    city,
    age_group,
    NTILE(3) OVER (ORDER BY average_income) AS income_tertile  -- 1=low,2=mid,3=high
  FROM dim_customers
),
merged_spend AS (
  SELECT
    cb.income_tertile,
    cb.city,
    cb.age_group,
    s.customer_id,
    SUM(s.spends) AS total_spend_by_customer   -- total across all months/categories
  FROM cust_bracket cb
  LEFT JOIN fact_spends s ON cb.customer_id = s.customer_id
  GROUP BY cb.income_tertile, cb.city, cb.age_group, s.customer_id
)
SELECT
  income_tertile,
  city,
  age_group,
  AVG(total_spend_by_customer) AS avg_total_spend_per_customer,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_spend_by_customer) AS median_spend,
  COUNT(DISTINCT customer_id) FILTER (WHERE total_spend_by_customer IS NOT NULL) AS num_spending_customers
FROM merged_spend
GROUP BY income_tertile, city, age_group
ORDER BY income_tertile, city, age_group;


-------------------------------------------------------------------
-- 18.b Are there specific categories or cities where higher-income customers spend significantly more?
-- Compute avg spend by category × income_tertile × city; then compute difference high - low
-------------------------------------------------------------------
WITH cust_bracket AS (
  SELECT
    customer_id,
    NTILE(3) OVER (ORDER BY average_income) AS income_tertile  -- 1=low, 3=high
  FROM dim_customers
),
merged AS (
  SELECT
    cb.income_tertile,
    c.city,
    s.category,
    SUM(s.spends) AS total_spend
  FROM cust_bracket cb
  JOIN fact_spends s ON cb.customer_id = s.customer_id
  JOIN dim_customers c ON c.customer_id = s.customer_id
  GROUP BY cb.income_tertile, c.city, s.category
),
agg_by_cat AS (
  SELECT
    category,
    city,
    income_tertile,
    AVG(total_spend) AS avg_spend_by_bracket
  FROM merged
  GROUP BY category, city, income_tertile
)
-- Pivot-ish result: show low vs high differences (income_tertile 1 vs 3)
SELECT
  a.category,
  a.city,
  COALESCE(MAX(CASE WHEN a.income_tertile = 1 THEN a.avg_spend_by_bracket END),0) AS avg_spend_low,
  COALESCE(MAX(CASE WHEN a.income_tertile = 3 THEN a.avg_spend_by_bracket END),0) AS avg_spend_high,
  (COALESCE(MAX(CASE WHEN a.income_tertile = 3 THEN a.avg_spend_by_bracket END),0)
   - COALESCE(MAX(CASE WHEN a.income_tertile = 1 THEN a.avg_spend_by_bracket END),0)
  ) AS diff_high_minus_low
FROM agg_by_cat a
GROUP BY a.category, a.city
ORDER BY diff_high_minus_low DESC
LIMIT 100;  -- remove or adjust limit as needed


-------------------------------------------------------------------
-- End 
-------------------------------------------------------------------



