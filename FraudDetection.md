# Fraud Detection Challenge – Kenya Gaming Center


* Creating the devices table
```sql
CREATE TABLE devices (
	device_id TEXT PRIMARY KEY,
	device_type TEXT,
	location TEXT
);
```
* Copying the devices table from the csv file
```sql
COPY devices 
FROM 'path to file\devices.csv'
DELIMITER ','
CSV HEADER
;
```

* Retrieving all rows from the devices table
```sql
SELECT *
FROM devices
;
```

* Creating the gaming_sessions table
```sql
CREATE TABLE gaming_sessions (
	session_id INT PRIMARY KEY,
	player_id INT,
	device_id TEXT,
	login_time TIMESTAMP,
	logout_time TIMESTAMP,
	credits_used NUMERIC,
	promo_used TEXT
);
```

* Copying the gaming_sessions table from the csv file
```sql
COPY gaming_sessions 
FROM 'path to file\gaming_sessions.csv'
DELIMITER ','
CSV HEADER
;
```

* Retrieving all rows from the gaming_sessions table
```sql
SELECT *
FROM gaming_sessions
;
```

* Creating the players table
```sql
CREATE TABLE players (
	player_id INT PRIMARY KEY,
	name TEXT,
	signup_date DATE,
	email TEXT
);
```

* Copying the players' table from the csv file
```sql
COPY players 
FROM 'path to file\players.csv'
DELIMITER ','
CSV HEADER
;
```
* Retrieving all rows from the players table
```sql
SELECT *
FROM players
;
```
<!---
SELECT 
	(logout_time - login_time) AS session_duration
FROM gaming_sessions; -->

* Detecting Overlapping Sessions
```sql
SELECT 
	s1.session_id AS session1,
	s2.session_id AS session2,
	s1.player_id,
	s1.login_time AS session1_start,
	s1.logout_time AS session1_end,
	s2.login_time AS session2_start,
	s2.logout_time AS session2_end
FROM gaming_sessions s1
JOIN gaming_sessions s2
	ON s1.player_id = s2.player_id
	AND s1.session_id < s2.session_id
	AND s1.login_time < s2.logout_time
	AND s1.logout_time > s2.login_time
;
```
This returns 3867 rows, all overlapping sessions


* Another way of writing the query to display overlap
```sql
SELECT 
	s1.session_id AS session1,
	s2.session_id AS session2,
	s1.player_id,
	s1.login_time AS session1_start,
	s1.logout_time AS session1_end,
	s2.login_time AS session2_start,
	s2.logout_time AS session2_end,
	CASE 
		WHEN s1.login_time < s2.logout_time AND s1.logout_time > s2.login_time
			THEN 'Overlap Found'
		ELSE 'No Overlap' 
	END overlap
FROM gaming_sessions s1
JOIN gaming_sessions s2
	ON s1.player_id = s2.player_id
	AND s1.session_id < s2.session_id
	AND s1.login_time < s2.logout_time
	AND s1.logout_time > s2.login_time
;
```

<!---
-- Another way of writing the query to display overlap and no overlaps
SELECT 
	s1.session_id AS session1,
	s2.session_id AS session2,
	s1.player_id,
	s1.login_time AS session1_start,
	s1.logout_time AS session1_end,
	s2.login_time AS session2_start,
	s2.logout_time AS session2_end,
	CASE 
		WHEN s1.login_time < s2.logout_time AND s1.logout_time > s2.login_time
			THEN 'Overlap Found'
		ELSE 'No Overlap' 
	END overlap_status
FROM gaming_sessions s1
JOIN gaming_sessions s2
	ON s1.player_id = s2.player_id
	AND s1.session_id < s2.session_id
; -- This returns 40915 rows with mix of overlap and no overlap

-- Counting the number of overalpping sessions
WITH overlap_count AS (
	SELECT 
		s1.session_id AS session1,
		s2.session_id AS session2,
		s1.player_id,
		s1.login_time AS session1_start,
		s1.logout_time AS session1_end,
		s2.login_time AS session2_start,
		s2.logout_time AS session2_end,
		CASE 
			WHEN s1.login_time < s2.logout_time AND s1.logout_time > s2.login_time
				THEN 'Overlap Found'
			ELSE 'No Overlap' 
		END overlap_status
	FROM gaming_sessions s1
	JOIN gaming_sessions s2
		ON s1.player_id = s2.player_id
		AND s1.session_id < s2.session_id
)
SELECT 
	COUNT(overlap_status) AS total_overlap_sessions
FROM overlap_count
WHERE overlap_status = 'Overlap Found'
; -- This returns 3867


-- ===== Identify players who have overlapping session times on different devices ===== --
SELECT 
    s1.player_id,
    s1.session_id AS session1,
    s2.session_id AS session2,
    s1.device_id AS device1,
    s2.device_id AS device2
FROM gaming_sessions s1
JOIN gaming_sessions s2 
      ON s1.player_id = s2.player_id
     AND s1.session_id < s2.session_id
     AND s1.device_id <> s2.device_id
     AND s1.login_time < s2.logout_time
     AND s2.login_time < s1.logout_time
; -- This returned 3679 rows of overlapping sessions

-- Another way of writing the solution
WITH overlap_count AS (
	SELECT 
		s1.session_id AS session1,
		s2.session_id AS session2,
		s1.player_id AS player_id,
		s1.device_id AS device1,
		s2.device_id AS device2,
		CASE 
			WHEN s1.login_time < s2.logout_time AND s1.logout_time > s2.login_time
				THEN 'Overlap Found'
			ELSE 'No Overlap' 
		END overlap_status
	FROM gaming_sessions s1
	JOIN gaming_sessions s2
		ON s1.player_id = s2.player_id
		AND s1.session_id < s2.session_id
		AND s1.device_id <> s2.device_id
)
SELECT 
	p.name,
	p.player_id,
	session1,
	session2,
	device1,
	device2,
	overlap_status
FROM players p
JOIN overlap_count oc
	ON p.player_id = oc.player_id
WHERE overlap_status = 'Overlap Found'		
; -- This returned 3679 rows of overlapping sessions

-- SELECT 
-- 	COUNT(overlap_status) AS total_overlap_sessions
-- FROM overlap_count
-- WHERE overlap_status = 'Overlap Found'
-- ; -- This returns 3867


-- ===== Detect Excessive Play Duration: Any session greater than 5h is excessive ===== --
SELECT 
	(logout_time - login_time) AS time_interval
FROM gaming_sessions;

-- This returns the hours_played in hour with seconds
SELECT 
	session_id,
	player_id,
	login_time,
    logout_time,
	ROUND(EXTRACT(EPOCH FROM (logout_time - login_time)) / 3600, 3) AS hours_played -- Converting the timestamp into hour with seconds
FROM gaming_sessions
WHERE (logout_time - login_time) > INTERVAL '5 hours'
ORDER BY hours_played ASC
; -- This returned 5888 rows 

-- Another way to write the query. This returns the hours_played in seconds
SELECT 
    session_id,
    player_id,
    login_time,
    logout_time,
    ROUND(EXTRACT(EPOCH FROM (logout_time - login_time)), 0)  AS hours_played
FROM gaming_sessions
WHERE (logout_time - login_time) > INTERVAL '5 HOURS'
ORDER BY hours_played ASC
; -- This returned 5888 rows


-- ===== Finding sessions lasting more than 10 hours ===== --
SELECT 
	session_id,
	player_id,
	login_time,
    logout_time,
	-- Converting convert the INTERVAL to seconds and then divide by 3600 to get hours0
	ROUND(EXTRACT(EPOCH FROM (logout_time - login_time)) / 3600, 3) AS hours_played 
FROM gaming_sessions
WHERE (logout_time - login_time) > INTERVAL '10 hours'
ORDER BY hours_played ASC
; -- This returned 3156 rows


-- ===== Detect Promo Abuse ===== --
-- Filling the NULL values with 0 in the credits_used column
UPDATE gaming_sessions
SET credits_used = 0
WHERE credits_used IS NULL
;

-- Sessions where promo was used but no credits were consumed
SELECT
    session_id,
    player_id,
    promo_used
FROM gaming_sessions
WHERE promo_used = 'Yes'
  AND credits_used = 0
; -- This returned 1356 rows

-- Sessions where promo was used and credits were consumed
SELECT
    session_id,
    player_id,
    promo_used,
	credits_used
FROM gaming_sessions
WHERE promo_used = 'Yes'
  AND credits_used <> 0
; -- This returned 1356 rows

-- Multiple promo sessions in the same day with No credits_used
SELECT
    player_id,
	DATE(login_time) AS session_date,
    COUNT(*) AS promos_used
FROM gaming_sessions
WHERE promo_used = 'Yes'
AND credits_used = 0
GROUP BY player_id, DATE(login_time)
HAVING COUNT(*) > 1
; -- This returned 133 rows

-- Multiple promo sessions in the same day 
SELECT
    player_id,
	DATE(login_time) AS session_date,
    COUNT(*) AS promos_used
FROM gaming_sessions
WHERE promo_used = 'Yes'
GROUP BY player_id, DATE(login_time)
HAVING COUNT(*) > 1
; -- This returned 488 rows with player_id 318 having 3 counts as top.

-- Multiple promo sessions in the same day with credits_used
```
SELECT
    player_id,
	DATE(login_time) AS session_date,
    COUNT(*) AS promos_used
FROM gaming_sessions
WHERE promo_used = 'Yes'
AND credits_used <> 0
GROUP BY player_id, DATE(login_time)
HAVING COUNT(*) > 1
; 
```
This returned 138 rows 

* Number of promos used by each player regardless of the same day.
```
SELECT 
	player_id,
	COUNT(*) AS usage_count
FROM gaming_sessions
WHERE promo_used = 'Yes'
GROUP BY player_id
ORDER BY usage_count DESC
;
```
This returned 768 rows with player_id 103 having 13 counts as top


* Find players who used promo credits more than twice during the week
```
WITH weekly_promo AS (
    SELECT
        player_id,
        TO_CHAR(login_time, 'YYYY-IW') AS week_id,
        COUNT(*) AS promo_count
    FROM gaming_sessions
    WHERE promo_used = 'Yes'
    GROUP BY player_id, week_id
)
SELECT *
FROM weekly_promo
WHERE promo_count > 2
ORDER BY promo_count DESC
;
```
This returned `388` rows with player_id 103 having 9 promo_counts as top followed by `527(8)` and `567(7)`


## Summary Report
* 3867 overlapping sessions were detected out of 8091 sessions in total.
* 3679 players had overlapping session times on different devices.
* 5888 rows were returned. Note that excessive play duration was considered to be any session greater than 5h.
* 3156 sessions lasted more than 10 hours.
* Promo abuse was considered for multiple sessions where the promo was used on the same day. This returned 133 rows.
* 388 players were found to have used promo credits more than twice during the week. -->





