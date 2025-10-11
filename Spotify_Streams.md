# Project: Cleaning Spotify Streams Data in PostgreSQL
----

## Table of Contents
1. [Introduction](#𝐈𝐧𝐭𝐫𝐨𝐝𝐮𝐜𝐭𝐢𝐨𝐧)
2. [Problem Statement](#Problem-Statement)
3. [Business Questions](#business-questions)
   * [Impact of Shuffle Mode on Listening Behavior](#Impact-of-Shuffle-Mode-on-Listening-Behavior)
   * [Track Completion Rates](#Track-Completion-Rates)
   * [Platform Usage Trends](#Platform-Usage-Trends)
4. [Tech Stack](#tech-stack)
5. [Data Information](#Data-Information)
   * [Description of Each Column](#Description-of-each-column)
6. [Creating the Database](#Creating-the-Database)
7. [Creating the Table](#creating-the-table)
   * [Dropping the Table if it Exists](#Dropping-the-Table-if-it-Exists)
   * [Creating Columns in the Table](#Creating-Columns-in-the-Table)
8. [Inserting Values in the Table](#Inserting-Values-in-the-Table)
   * [Retrieving Data from the Table](#Retrieving-Data-from-the-Table)
9. [Creating a new Table](#Creating-a-new-Table)
   * [Retrieving Data from the New Table](#Retrieving-Data-from-the-new-Table)
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


## Introduction
This project focuses on cleaning Spotify Streams data to prepare it for analysis. All the tasks are completed in PostgreSQL, one of the most powerful databases.

## Problem Statement
Spotify wants to enhance user engagement by optimizing the shuffle mode and improving track completion rates. To achieve this, they need to understand how shuffle mode affects listening behavior, identify patterns in track interruptions, and explore platform-specific performance trends.

## Business Questions  

### Impact of Shuffle Mode on Listening Behavior
Here, the aim is to answer the following questions:  
1. Do users play a more diverse range of tracks when shuffle mode is enabled?  
2. What percentage of tracks played in shuffle mode are interrupted (reason_end)?
3. Which platforms have the highest shuffle mode usage?

### Track Completion Rates
Here, the aim is to answer the following questions:  
1. What percentage of tracks are stopped early versus completed?  
2. Are there specific tracks or artists with consistently high interruption rates?  
3. Does the platform or shuffle mode influence track completion rates?

### Platform Usage Trends
Here, the aim is to answer the following questions:  
1. Which platforms have the longest average playback duration?
2. Are there specific hours or days when platform usage peaks?


## Tech Stack
This project will use two tech stacks: **PostgreSQL** and **Power BI**. This report provides all information related to data cleaning in PostgreSQL, while another report will focus on analyzing the data in **POWER BI** and building an interactive dashboard.  
**PostgreSQL** was used because it supports different data types such as _TIMESTAMP_ and _BOOLEAN_ (which are data types of some of the columns in the datasets), unlike other databases, which need external tools to manipulate such data types.

## Data Information
The data provided contained the following information:  
* Number of rows: 149860 rows  
* Number of columns: 11 columns
[Link to the dataset](https://drive.google.com/file/d/1009ZQdqIQV1-TNqNt1rXENK4zFWM_55u/view?usp=drive_link)

### Description of Each Column
The data downloaded was stored in a .csv file. Each column in the file is described as follows.  
1. _track_url_ (TEXT): Spotify URI that uniquely identifies each track in the form of "spotify:track:<base-62 string>"  		 						
2. _ts_ (TIMESTAMP): Timestamp indicating when the track stopped playing in UTC (Coordinated Universal Time)								
3. _platform_ (TEXT): Platform used when streaming the track
4. _ms_played_ (BIGINT): Number of milliseconds the stream was played
5. _track_name_ (TEXT): Name of the track
6. _artist_name_ (TEXT): Name of the artist
7. _album_name_ (TEXT): Name of the album
8. _reason_start_ (TEXT): Why the track started
9. _reason_end_ (TEXT): Why the track ended
10. _shuffle_ (BOOLEAN): TRUE or FALSE depending on whether shuffle mode was used when playing the track
11. _skipped_ (BOOLEAN): TRUE or FALSE depending on if the user skipped to the next song								

## Creating the Database
This task is to create a database in PostgreSQL to store the new table that will contain the dataset. The query is as follows.
```sql
CREATE DATABASE sql_projects
;
```
In this query, **sql_projects** represents the name of the database.

## Creating the Table
This task involves creating a table to store the data. To begin with, it is necessary to drop the table if it already exists. This is to avoid any conflict.

### Dropping the Table if it Exists
```sql
DROP TABLE spotify_history
;
```

### Creating Columns in the Table 
In this task, several columns with their data types were created in the table named spotify_history. The query is given below.
```sql
CREATE TABLE spotify_history (
	spotify_track_url TEXT,
	ts TIMESTAMP,
	platform TEXT,
	ms_played BIGINT,
	track_name TEXT,
	artist_name TEXT,
	album_name TEXT,
	reason_start TEXT,
	reason_end TEXT,
	shuffle BOOLEAN,
	skipped BOOLEAN
);
```
In this query, **spotify_history** represents the name of the table.

## Inserting Values in the Table
Since the data was already contained in a .csv file, the query below was written to load the data in the table named **spotify_history** in PostgreSQL.
```sql
COPY spotify_history 
FROM 'your_path\spotify_history.csv'
DELIMITER ','
CSV HEADER
;
```
🔗 [Back to TOC](#-table-of-contents)
### Retrieving all the Data from the Table
Here, we write a query to retrieve all the data from the table named spotify_history. This is necessary to see if all the data were loaded correctly.
```sql
SELECT *
FROM spotify_history
;
```
This returned 149860 rows.

## Creating a New Table 
It is important to always keep the raw data and copy it to a new table to do the cleaning and transformation. This way, we can refer to that initial table at any stage of the project if we need more information. So, the table named **spotify_history** was copied to a new table named **spotify_streams** to perform the cleaning. The query below was used.
```sql
CREATE TABLE spotify_streams AS
	SELECT * 
	FROM spotify_history
;
```
After creating the new table named **spotify_streams** from the initial table, we then wrote the query below to retrieve all the data.
```sql
SELECT *
FROM spotify_streams
; 
```
This returned 149860 rows.

## Part 1: Data Cleaning

### Renaming Columns in the Table
The column named **spotify_track_url** was renamed to **track_url** using the query below.
```sql
ALTER TABLE spotify_streams
RENAME COLUMN spotify_track_url TO track_url
;
```

### Checking and Removing Duplicates

#### Checking for Duplicates
To check for duplicate values in the table, I used the `ROW_NUMBER()` window function and partitioned by all the columns. The reason behind partitioning by all columns was to ensure that rows counted as duplicates will have the same entries; otherwise, some rows may be skipped. The query reads as follows.
```sql
SELECT 
	track_url,
	ROW_NUMBER() OVER (PARTITION BY
		track_url, ts, platform, ms_played, track_name, artist_name,
		album_name, reason_start, reason_end, shuffle, skipped
	) AS row_num
FROM spotify_streams
;
```

#### Returning Duplicates based on One Column
After checking for duplicates using the above query, it is time to check and return the **track_url** column having `row_num > 1`, which will be counted as duplicate values.
```
SELECT 
	track_url FROM (
		SELECT
			track_url,
			ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name,
			artist_name, album_name, reason_start, reason_end, shuffle, skipped
		) AS row_num
		FROM spotify_streams
	) track
WHERE row_num > 1
;
```
This returned **1782** rows as duplicates.

<!--- ```sql
SELECT 
	track_url,
	COUNT(*)
FROM spotify_streams
GROUP BY track_url
HAVING COUNT(*) > 1
;
``` --->

#### Returning all Rows with Duplicates
Now, we return all rows that have the same entries in all columns more than once, which duplicate values that must be deleted.
```sql
SELECT 
	track_url, ts, platform, ms_played, track_name, artist_name, 
	album_name, reason_start, reason_end, shuffle, skipped,
	COUNT(*)
FROM spotify_streams
GROUP BY track_url, ts, platform, ms_played, track_name, artist_name, 
	album_name, reason_start, reason_end, shuffle, skipped
HAVING COUNT(*) > 1
;
```
This returned 1782 rows.  

> [!Important]
> Although the above query shows that there are 1782 rows as duplicates, it is always advised to understand why these are duplicates and double-check some of these rows to ensure that they are actually duplicate values before deleting them.


<!-- Creating new columns start_time (=ts)), stop_time (=(ts + ms_played/1000) * INTERVAL '1 second'), and minutes_played (=ms_played/60000.0) to explore the data.
-- This is also to confirm that the duplicate rows returned earlier are actually duplicate values.
-- ts + (ms_played/1000) * INTERVAL '1 second' converts the ts to seconds and stores it to stop_time.
-- ms_played/60000.0 converts ms_played to minutes and stores it to minutes_played.
```sql
SELECT 
	track_url,
	ts,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, artist_name, album_name, reason_start, reason_end, shuffle, skipped) AS row_num
FROM spotify_streams
;
``` -->

#### Assigning A Unique Identifier to Each Row
To facilitate the deleting process and ensure that we delete only duplicate rows from our table, we assign a unique number to each row in the table using `ctid`. Then, we can return rows with duplicate values before deleting them. The query reads as follows.
```sql
SELECT 
	ctid,
	ROW_NUMBER() OVER (PARTITION BY
		track_url, ts, platform, ms_played, track_name,	artist_name,
		album_name, reason_start, reason_end, shuffle, skipped
	) AS row_num
FROM spotify_streams
;
```
> [!Note]
> The **ctid** column gives a unique number to each row. So anywhere there is `row_num > 2` will be a duplicate, and we will delete them.


* **Returning rows with duplicate values based on the ctid column**
```sql
SELECT 
	ctid
FROM (
	SELECT 
		ctid,
		ROW_NUMBER() OVER (PARTITION BY
			track_url, ts, platform, ms_played, track_name, artist_name,
			album_name, reason_start, reason_end, shuffle, skipped
		) AS row_num
	FROM spotify_streams
) 
WHERE row_num > 1
;
```
This returned 1782 rows, confirming what we saw earlier.


#### Deleting Duplicate Values 
Now that we have identified rows with duplicate values and inspected as many of them to confirm that they are really duplicate values, we can delete these rows from the data without any doubt. The query is as follows.
```sql
DELETE FROM spotify_streams
WHERE ctid IN (
	SELECT 
		ctid
	FROM (
		SELECT 
			ctid,
			ROW_NUMBER() OVER (PARTITION BY
				track_url, ts, platform, ms_played, track_name,	artist_name,
				album_name, reason_start, reason_end, shuffle, skipped
			) AS row_num
		FROM spotify_streams
	) dup_rows
	WHERE row_num > 1
)
;
```
This deleted `1782` rows. 

> [!Note]
> Instead of assigning a unique identifier to each row as we did using **ctid** and deleting duplicate values based on that ctid column, we could have started by writing different queries as shown below to return all rows with duplicate values.
```sql
SELECT 
	row_num FROM (
		SELECT
			track_url,
			ROW_NUMBER() OVER (PARTITION BY
				track_url, ts, platform, ms_played, track_name, artist_name,
				album_name, reason_start, reason_end, shuffle, skipped
			) AS row_num
		FROM spotify_streams
	) dup_rows
WHERE row_num > 1
;
```
Then, use the following query to copy all rows without duplicate values where `row_num = 1` to a new table named **spotify_streams_1**. Therefore, the other tasks will be completed based on the data in this new table.
```sql
SELECT * INTO spotify_streams_1
FROM (
	SELECT
		*, 
		ROW_NUMBER() OVER (PARTITION BY
			track_url, ts, platform, ms_played, track_name, artist_name,
			album_name, reason_start, reason_end, shuffle, skipped
		) AS row_num
	FROM spotify_streams
	) rem_dup
WHERE row_num = 1
;
```

Using this second method, you will have to delete the **row_num** column from the table since it will not be needed further. This can be done using the query below.
```sql
ALTER TABLE spotify_streams_1
DROP COLUMN row_num
;
```

### Checking and Replacing NULL Values
In this task, we explore and query the data further to check for NULL values in the data and populate them wherever possible. 

> [!Note]
> Before deleting or replacing NULL Values, you should understand the behavior of each column concerning other columns.

#### Checking for NULL Values
The queries below were written to check for NULL values.
```sql
SELECT
  *
FROM spotify_streams
WHERE track_url IS NULL
	OR ts IS NULL OR platform IS NULL 
	OR ms_played IS NULL OR track_name IS NULL 
	OR artist_name IS NULL OR album_name IS NULL 
	OR reason_start IS NULL OR reason_end IS NULL 
	OR shuffle IS NULL OR skipped IS NULL
;
```
This returned **212** rows. 


* **Checking for NULL values in some columns**
```sql
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE track_url IS NULL
	OR ts IS NULL OR platform IS NULL 
	OR ms_played IS NULL OR track_name IS NULL 
	OR artist_name IS NULL OR album_name IS NULL 
	OR reason_start IS NULL OR reason_end IS NULL 
	OR shuffle IS NULL OR skipped IS NULL
;
```
This also returned **212** rows. After writing the above two queries and exploring the data further, we realized that the *reason_start* and *reason_end* were the ones with NULL Values.


* **Checking details for a specific track_url**  
```sql
SELECT 
	track_url,
	platform,
	track_name,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE track_url = '0Cng3O0fIHllQx3S78RvmL'
;
```

* **Returning distinct values for the reason_start column**  
This task was done to further explore the reason_start column to understand why there are so many NULLS in the column.
```sql
SELECT 
	DISTINCT reason_start
FROM spotify_streams
;
```

* **Checking for NULL values in the reason_start and reason_end columns**    
```sql
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE 
	reason_start IS NULL 
	OR reason_end IS NULL 
ORDER BY track_url
;
```
This also returned **212** rows.


* **Checking for NULL values in the reason_start column**
```sql
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE reason_start IS NULL 
;
```
This returned **143** rows.


* **Checking for NULL values in the reason_end column**
```sql
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE reason_end IS NULL 
;
```
This returned **117** rows.  

Since we now know the number of NULL values in the *reason_start* and *reason_end* columns, we can now base ourselves on the entries in these columns to populate NULL values. The queries below were written in that regard.


* **Checking for unknown values in the reason_start column**  
```sql
SELECT 
	*
FROM spotify_streams
WHERE reason_start = 'unknown' 
;
```
This returned **23** rows.


* **Checking for unknown values in the reason_end column**  
```sql
SELECT *
FROM spotify_streams
WHERE reason_end = 'unknown' 
;
```
This returned **267** rows.


* **Checking for NULL values for a specific track_url**  
```sql
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE track_url = '5Ux410GeRXrojeP0vUPx6v'
;
```
This returned **10** rows.  

Since there is not enough data (far less than 100), and we do not have much information on the NULL values, we cannot do anything here other than replace these NULL values in the *reason_start* and *reason_end* columns with 'unknown'. Check the query below.

#### Replacing NULL Values
With the information we now know regarding entries in the *reason_start* and *reason_end* columns, we can go ahead and fill them with _unknown_. The query is written as follows. 
```sql
UPDATE spotify_streams
SET
	reason_start =
		CASE 
			WHEN reason_start IS NULL THEN 'unknown' 
			ELSE reason_start 
		END,
	reason_end = 
		CASE 
			WHEN reason_end IS NULL THEN 'unknown' 
			ELSE reason_end 
		END
;
```
This updated **143** rows in the _reason_start_ column and **117** rows in the _reason_end_ column.  


* **Returning all rows from cleaned data**  
```sql
SELECT *
FROM spotify_streams
;
```
This returned **148078** rows in total.

### Creating New Columns
In this task, we created new columns in the table. These columns will be useful during the analysis of the data and also aid in uncovering insights and providing recommendations.

#### Adding and Populating the Column start_time

1. **Adding a column named start_time**
This is done by using the `ALTER TABLE` statement, which is used to modify the structure of an existing table. 
```sql
ALTER TABLE spotify_streams
ADD COLUMN start_time TIME
;
```

2. **Populating the column start_time**
Here, we populate the _start_time_ column using the time extracted from the _ts_ column.
```sql
UPDATE spotify_streams
SET start_time = ts::TIME
;
```

#### Adding and Populating the Column end_time

1. **Adding a column named end_time**  
```sql
ALTER TABLE spotify_streams
ADD COLUMN end_time TIME
;
```

2. **Populating the column end_time**  
Here, we populate the _end_time_ column using both the _ts_ and the _ms_played_ columns. First, the _ms_played_ column is converted to seconds using `(ms_played/1000) * INTERVAL '1 second'` before adding it to the _ts_ column. Next, the time is extracted from the result to populate the _end_time_ column.
```sql
UPDATE spotify_streams
SET end_time = (ts + (ms_played/1000) * INTERVAL '1 second')::TIME
;
```

#### Adding and Populating the Column minutes_played

1. **Adding a column named minutes_played**  
```sql
ALTER TABLE spotify_streams
ADD COLUMN minutes_played NUMERIC
;
```

2. **Populating the column minutes_played**
Here, we populate the column named _minutes_played_ using the _ms_played_ column and converting it to minutes. The query is as follows.
```sql
UPDATE spotify_streams
SET minutes_played = ROUND(ms_played/60000.0, 2) 
;
```

#### Adding and Populating the Column date_played

1. **Adding a column named date_played**
```sql
ALTER TABLE spotify_streams
ADD COLUMN date_played DATE
;
```

2. **Populating the column date_played**  
To populate the column named _date_played_, we used the _ts_ column and extracted the date from it.
```sql
UPDATE spotify_streams
SET date_played = ts::DATE
;
```

## Part II: Answering the Business Questions
In this second part, we answer the business questions highlighted earlier. The answers provided here will be useful in the recommendations.

### A. Impact of Shuffle Mode on Listening Behavior 
The first question to address here is:  

#### 1. Do users play a more diverse range of tracks when shuffle mode is enabled?  
First, we write a query to check the number of tracks with and without shuffle. Note that the shuffle column only contains the Boolean values True and False. The former refers to the shuffle mode being enabled and the second is when the shuffle is not enabled. The query is given below.
```sql
SELECT 
	shuffle AS mode,
	COUNT(DISTINCT track_url) AS unique_tracks
FROM spotify_streams
GROUP BY shuffle
;
``` 
This returned:  
* **False**: 10432
* **True**: 11095  

Now, we write a query to find the average plays when shuffle mode is enabled. 
```sql
SELECT 
	CASE 
		WHEN shuffle = 'true' 
		THEN 'is_enabled' 
		ELSE 'not_enable' 
	END AS shuffle_mode,
	COUNT(DISTINCT track_url) AS unique_tracks,
	COUNT(*) AS all_tracks,
	ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT track_url), 2) AS avg_plays
FROM spotify_streams
GROUP BY shuffle
;
```
This returned:  
* **For shuffle mode not enabled**:
  * all tracks: 36948
  * unique tracks: 10432
  * average plays: 3.54  

* **For shuffle mode enabled**:
  * all tracks: 111130
  * unique tracks: 11095
  * average plays: 10.02  

From these results, we can conclude that more tracks are listened to when shuffle mode is enabled.

The second question to address here is: 

#### 2. What percentage of tracks played in shuffle mode are interrupted (reason_end)?
Here, we are interested in seeing the number of tracks interrupted when shuffle mode was enabled. For that to be done, we first inspect the _reason_end_ column, which contains information about the track ended. First, we write a query to return all distinct entries from the _reason_end_ column as follows.
```sql
SELECT
	DISTINCT reason_end
FROM spotify_streams
;
```
This returned **15** rows.

Now, we write a query to check the amount of completed and interrupted tracks with shuffle mode enabled as follows.
```sql
SELECT 
	DISTINCT reason_end,
	CASE 
		WHEN reason_end = 'trackdone' 
		THEN 'completed'
		ELSE 'interrupted'
	END AS reason_end_mode,
	COUNT(DISTINCT track_url) AS unique_tracks,
	COUNT(*) AS all_tracks,
	ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT track_url), 2) AS avg_plays
FROM spotify_streams
WHERE shuffle = 'true'
GROUP BY reason_end
;
```
The results show that out of **148078** columns in total,  
* **For completed tracks with shuffle mode enabled**:  
  * all tracks: 51143
  * unique tracks: 8368  

* **For interrupted tracks with shuffle mode enabled**:  
  * all tracks: 59987
  * unique tracks: 13851

<!--- SELECT *
FROM spotify
WHERE reason_end = 'trackdone' AND shuffle = 'true'
; -- This returned 51143 rows --->

To complete this question, we wrote a query to return the percentage of tracks interrupted when shuffle mode was enabled. The query reads as follows.
```sql
SELECT 
	CASE 
		WHEN ms_played / 60000 < 1 THEN 'short (<1 min)'
		WHEN ms_played / 60000 BETWEEN 1 AND 3 THEN 'medium(1-3)'
		ELSE 'Long (>3 min)'
	END AS length_of_track,
	COUNT(CASE 
		WHEN reason_end <> 'trackdone' 
		THEN 1
	END) AS interrupted,
	COUNT(*) AS total,
	ROUND(COUNT(CASE 
		WHEN reason_end <> 'trackdone' 
		THEN 1
	END) * 100.0 / NULLIF(COUNT(*), 0), 2) AS interrupted_rate
FROM spotify_streams
-- WHERE shuffle = 'true'
GROUP BY 
CASE 
	WHEN ms_played / 60000 < 1 THEN 'short (<1 min)'
	WHEN ms_played / 60000 BETWEEN 1 AND 3 THEN 'medium(1-3)'
	ELSE 'Long (>3 min)'
END
;
```
It can be seen that:  
* **For short tracks (<1 minute)**: out of 51316 tracks in total, 50631 were interrupted, giving a percentage of **98.67%**.
* **For medium tracks (between 1 and 3 minutes)**: out of 42429 tracks in total, 8398 were interrupted, giving a percentage of **19.79%**.
* **For long tracks (>3 minutes)**: out of 17385 tracks in total, 958 were interrupted, giving a percentage of **5.51%**.  

The third and last question to address here is:

#### 3. Which platforms have the highest shuffle mode usage? 
First, we write a query to return all distinct platforms as given by:
```sql
SELECT
	DISTINCT platform
FROM spotify_streams
;
```
This returned **6** rows with Android, Cast to device, IOS, Mac, Web player, and Windows.  

The next thing to do is to write another query to count the number of shuffles for each platform when the shuffle mode is enabled. The query reads as follows.
```sql
SELECT 
	DISTINCT platform,
	COUNT(shuffle)
FROM spotify_streams
WHERE shuffle = 'true'
GROUP BY platform
;
```
Lastly, we write a query to return the platform with the highest shuffle mode usage.
```sql
-- Solution 1
SELECT 
	platform,
	COUNT(
		CASE
			WHEN shuffle = 'true' 
			THEN 1 
		END
	) AS shuffle_count,
	COUNT(*) AS total,
	ROUND(COUNT(
		CASE
			WHEN shuffle = 'true' 
			THEN 1 
		END
	) * 100.0 / NULLIF(COUNT(*), 0), 2) AS shuffle_percentage
FROM spotify_streams
GROUP BY platform
ORDER BY shuffle_percentage DESC
;
```

```sql
-- Solution 2
WITH cte AS (
	SELECT 
		platform,
		COUNT(
			CASE
				WHEN shuffle = 'true' 
				THEN 1 
			END
		) AS shuffle_count,
		COUNT(*) AS total
	FROM spotify_streams
	GROUP BY platform
)
SELECT 
	platform,
	shuffle_count,
	total,
	ROUND(shuffle_count * 100.0 / total, 2) AS shuffle_percentage
FROM cte
ORDER BY shuffle_percentage DESC
;
```
From this query, the results read as follows:  
* Android: out of 139002 tracks in total, 107369 were shuffled, giving a percentage of **77.24%**.
* IOS: out of 3048 tracks in total, 2110 were shuffled, giving a percentage of **69.23%**.
* Windows: out of 1690 tracks in total, 1007 were shuffled, giving a percentage of **59.59%**.
* Mac: out of 1176 tracks in total, 639 were shuffled, giving a percentage of **54.34%**.
* Cast to device: out of 2981 tracks in total, 5 were shuffled, giving a percentage of **0.17%**.
* Web player: out of 181 tracks in total, no track was shuffled, giving a percentage of **0.00%**. 

Clearly, Android was the platform with the highest shuffle mode usage.


### B. Track Completion Rates 
The first question to be answered here is:

#### 1. What percentage of tracks are stopped early versus completed?
Here we write a query to determine the percentage of completed played tracks and that of interrupted tracks. The query reads as follows:
```sql
WITH cte AS (
	SELECT 
		COUNT(
			CASE 
				WHEN reason_end <> 'trackdone' 
				THEN 1
			END
		) AS stopped_early,
		COUNT(*) AS total,
		COUNT(
			CASE 
				WHEN reason_end = 'trackdone'
				THEN 1
			END
		) AS completed
FROM spotify_streams
)
SELECT 
	stopped_early,
	completed,
	ROUND(stopped_early * 100.0 / NULLIF(total, 0), 2) AS percent_stopped_early,
	ROUND(completed * 100.0 / NULLIF(total, 0), 2) AS percent_completed
FROM cte
;
```
This query returned the following results:  
* **For interrupted tracks**: 71896 with a percentage of 48.55%
* **For completed tracks**: 76182 with a percentage of 51.45%

The second question to be addressed here is:

#### 2. Are there specific tracks or artists with consistently high interruption rates?
Here, we write queries to return the tracks or artists with a higher percentage of interruptions.  

##### a) For Artists 
```sql
WITH cte AS (
	SELECT 
		artist_name,
		SUM(ms_played) AS mins,
		COUNT(*) AS total,
		COUNT(
			CASE 
				WHEN reason_end <> 'trackdone' 
				THEN 1
			END
		) AS interruption_count,
		ROUND(COUNT(
			CASE 
				WHEN reason_end <> 'trackdone' 
				THEN 1
			END
		) * 100.0 / NULLIF(COUNT(*), 0), 2) AS percent_rate
	FROM spotify_streams
	GROUP BY artist_name
)
SELECT *
FROM cte
WHERE total = interruption_count 
	AND total > 10
ORDER BY interruption_count DESC
;
```
In this query, we returned the artists with a total interruption greater than 10. The results are the following:  
* Les Misérables - International Cast: Number of interruptions: 15
* El Bebeto: Number of interruptions: 13
* Deorro: Number of interruptions: 13
* Fetty Wap: Number of interruptions: 12  

##### b) For Tracks
```sql
WITH cte AS (
	SELECT 
		track_name,
		SUM(ms_played) AS mins,
		COUNT(*) AS total,
		COUNT(
			CASE 
				WHEN reason_end <> 'trackdone' 
				THEN 1
			END
		) AS interruption_count,
		ROUND(COUNT(
			CASE 
				WHEN reason_end <> 'trackdone' 
				THEN 1
			END
		) * 100.0 / NULLIF(COUNT(*), 0), 2) AS percent_rate
	FROM spotify_streams
	GROUP BY track_name
)
SELECT *
FROM cte
WHERE total = interruption_count 
	AND total > 10
ORDER BY interruption_count DESC
;
```
In this query, we returned the tracks with a total interruption greater than 10. The results are the following:  
* Sister Ray - International Cast: Number of interruptions: 40
* My Mind Is Ramblin: Number of interruptions: 31
* Komm gib mir deine Hand - Remastered 2009: Number of interruptions: 25
* The Bed: Number of interruptions: 23
* Spaceman - Live From The Royal Albert Hall / 2009: Number of interruptions: 13
* As Long As You Love Me: Number of interruptions: 12
* Weird Fishes/ Arpeggi: Number of interruptions: 11  

So, the answer is **Yes**. There are specific tracks or artists with consistently high interruption rates.  

The third question to be addressed here is:

#### 3. Does the platform or shuffle mode influence track completion rates?
```sql
SELECT 
	platform,
	shuffle,
	COUNT(DISTINCT track_url) AS unique_tracks,
	ROUND(COUNT(
		CASE
			WHEN reason_end = 'trackdone' 
			THEN 1
		END
	) * 100.0 / NULLIF(COUNT(*), 0), 2) AS percent_rate
FROM spotify_streams
GROUP BY platform, shuffle
ORDER BY percent_rate DESC
;
```
From this query, we could see that when shuffle mode is enabled, the track completion rate is lower than when shuffle mode is not enabled, as shown in the table below.
| platform	| shuffle	| unique_tracks	     | percent_rate |
|:--------------|:--------------|:--------------|:--------------|
| mac 	| FALSE	|259	|91.06 |
| mac	| TRUE	 | 531	| 89.83 |
| cast to device |	FALSE	 | 1603	 | 77.32 |
| windows	| FALSE	 | 586	| 69.4 |
| iOS	| TRUE	| 1286	| 68.72 |
| android	| FALSE	| 9463	| 66.94 |
| iOS	| FALSE	 | 789	| 57.25 | 
| windows 	|	TRUE	| 870	| 45.88 |
| android	| TRUE	| 10522	 | 45.32 |
| web player	| FALSE	| 156	| 34.81 |
| cast to device	| TRUE |	5 |	20 |


### C. Platform Usage Trends
In this last part, we analyze the platform usage trends. The first question to be addressed is:  

#### 1. Which platforms have the longest average playback duration?
```sql
SELECT 
	platform,
	-- SUM(ms_played) AS mins,
	COUNT(*) AS total,
	COUNT(
		CASE
			WHEN reason_end = 'backbtn' 
			THEN 1
		END
	) AS payback_count,
	ROUND(AVG(ms_played), 2) AS avg_playback
FROM spotify_streams
GROUP BY platform
ORDER BY avg_playback DESC
;
```
The query returned the results shown in the table below:
| platform	| total	| playback_count	     | avg_playback |
|:--------------|:--------------|:--------------|:--------------|
| mac 	| 1176	| 1	| 214208.29 |
| cas to device	| 2981	 | 17	| 184353.44 |
| ios |	3048	 | 36	 | 165010.20 |
| windows	| 1690	 | 9	| 138198.18 |
| android	| 139002	| 2087	| 125412.10 |
| web player	| 181	| 3	| 108554.36 |

From the above table, if we look at the average playback (milliseconds), we will conclude that Mac is the platform with the longest average playback duration. However, looking at the total number of tracks played and the playback count, Android has the longest average playback duration.

The second question to be addressed here is:

#### Are there specific hours or days when platform usage peaks?
##### a) Peak Usage by Hour
```sql
SELECT 
    EXTRACT(HOUR FROM  ts) AS hour_peak, 
    platform, 
    COUNT(*) AS usage_count
FROM spotify_streams
GROUP BY 
	platform,
	hour_peak
ORDER BY 
	platform ASC,
	usage_count DESC
-- LIMIT 10
;
```
The results show the following:  
* For Android: Usage peaks at night.
* For Cast to device: Usage peaks late in the afternoon.
* For IOS: Usage peaks early in the evening.
* For Mac: Usage peaks late in the afternoon.
* For Web player: There is no specific peak time.
* For Windows: Usage peaks early in the morning.  

##### b) Peak Usage by Day
```sql
SELECT 
    EXTRACT(DOW FROM ts) AS day_of_week, 
    platform, 
    COUNT(*) AS usage_count
FROM spotify_streams
GROUP BY 
	platform, 
	day_of_week
ORDER BY 
	platform ASC, 
	usage_count DESC
; 
```
The results show the following:  
* For Android: Usage peaks on Fridays, followed by Wednesdays. Sundays have less usage.
* For Cast to device: Usage peaks on Tuesdays, followed by Thursdays. Sundays have less usage.
* For IOS: Usage peaks on Wednesdays, followed by Fridays. Saturdays have less usage.
* For Mac: Usage peaks on Wednesdays, followed by Tuesdays. Sundays have less usage.
* For Web player: Usage peaks on Mondays, followed by Tuesdays. Wednesdays and Fridays have lower usage.
* For Windows: Usage peaks on Fridays, followed by Thursdays. Sundays have less usage.  


##### c) Peak Hour for Each Platform
```sql
WITH platform_peak AS (
    SELECT 
        platform, 
        DATE_TRUNC('hour', ts) AS hour, 
        COUNT(*) AS usage_count,
        RANK() OVER (PARTITION BY platform ORDER BY COUNT(*) DESC) AS rnk
    FROM spotify_streams
    GROUP BY platform, hour
)
SELECT platform, hour, usage_count
FROM platform_peak
WHERE rnk = 1
ORDER BY usage_count DESC
;
```
The results show the following:  
* For Android: Usage peaks at 10 P.M.
* For Cast to device: Usage peaks at 01 A.M.
* For IOS: Usage peaks at 02 A.M.
* For Mac: Usage peaks at 03 A.M.
* For Web player: Usage peaks at 10 P.M.
* For Windows: Usage peaks at 1 A.M. 


## Conclusion
This project involved cleaning the Spotify Streams dataset to prepare it for analysis on another platform. The following tasks were completed:  
* Renaming columns for consistency  
* Removing duplicate values
* Populating NULL values based on the entries in the column
* Creating new columns to deeply understand the data
* Answering business questions  

From the above tasks, we could uncover the following insights:  
* Most tracks are interrupted when shuffle mode is enabled
* **Android** is the platform with the highest shuffle mode usage, while **Web player** has the lowest shuffle mode usage, followed by **Cast to device**.
* The percentage of completed tracks is 51.45% compared to 48.55% for interrupted tracks.
* The artist named **Les Misérables - International Cast** and the track named **Sister Ray** both have the highest number of interruptions.
* The shuffle mode influences the track completion rates: when shuffle mode is enabled, the track completion rate is lower than when shuffle mode is not enabled.
* **Android** has the longest average playback duration and the highest usage count.
* The usage peak differs from one platform to another.  

Now that the data is cleaned, we can proceed with the analysis in Power BI.

Follow this [link](https://github.com/Songonge/Power-BI-Projects/tree/main/Spotify%20Songs%20Analysis%202023) to view the dashboard and the full report.



<br/>
   
**Thank you for taking the time to read this report!**

**Please reach out for any updates.**

### Author
[Edwige Songong](https://github.com/Songonge)  



