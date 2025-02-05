# Project: Data Cleaning for Spotify Streams 

## Table of Content
1. [Introduction](#𝐈𝐧𝐭𝐫𝐨𝐝𝐮𝐜𝐭𝐢𝐨𝐧)
2. [Problem Statement](#Problem-Statement)
3. [Business Questions](#business-questions)
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
10. [Renaming Columns in the Table](#Renaming-Columns-in-the-Table)
11. [Checking and Removing Duplicates](#Checking-and-Removing-Duplicates)
    * [Checking for Duplicates](#Checking-for-Duplicates)
    * [Returning Duplicates based one Column](#Returning-Duplicates-based-on-One-Column)
    * [Returning all Rows with Duplicates](#Returning-all-Rows-with-Duplicates)
    * [Assigning A Unique Identifier to Each Row](#Assigning-A-Unique-Identifier-to-Each-Row)
12. [Checking and Replacing NULL Values](#Checking-and-Replacing-NULL-Values)
    * [Checking for NULL Values](#Checking-for-NULL-Values)
    * [Replacing NULL Values](#Replacing-NULL-Values)
13. [Creating New Columns](#Creating-New-Columns)
    * [Adding and Populating the Column start_time](#Adding-and-Populating-the-Column-start_time)
    * [Adding and Populating the Column end_time](#Adding-and-Populating-the-Column-end_time)
    * [Adding and Populating the Column minutes_played](#Adding-and-Populating-the-Column-minutes_played)
    * [Adding and Populating the Column date_played](#Adding-and-Populating-the-Column-date_played)
15. [𝐂𝐨𝐧𝐜𝐥𝐮𝐬𝐢𝐨𝐧](#𝐂𝐨𝐧𝐜𝐥𝐮𝐬𝐢𝐨𝐧)

## Introduction
This project focuses on cleaning Spotify Streams data to prepare it for analysis. All the tasks are completed in PostgreSQL, one of the most powerful databases.

## Problem Statement
Spotify wants to enhance user engagement by optimizing shuffle mode and improving track completion rates. To achieve this, they need to understand how shuffle mode affects listening behavior, identify patterns in track interruptions, and explore platform-specific performance trends.

## Business Questions  
The entire project focuses on analyzing the impact of shuffle mode on listening behavior. Therefore, it aims to answer the following questions:
1. Do users play a more diverse range of tracks when shuffle mode is enabled?  
2. What percentage of tracks played in shuffle mode is interrupted (reason_end)?
3. Which platforms have the highest shuffle mode usage?

## Tech Stack
This project will use two tech stacks: **PostgreSQL** and **Power BI**. This report provides all information related to data cleaning in PostgreSQL, while another report will focus on analyzing the data in **POWER BI** and building an interactive dashboard.  
**PostgreSQL** was used because it supports different data types such as _TIMESTAMP_ and _BOOLEAN_ (which are data types of some of the columns in the datasets) unlike other databases which need external tools to manipulate such data types.

## Data Information
The data provided contained the following information:  
* Number of rows: 149860 rows  
* Number of columns: 11 columns
[Link to the dataset](https://drive.google.com/file/d/1009ZQdqIQV1-TNqNt1rXENK4zFWM_55u/view?usp=drive_link)

### Description of Each Column
The data downloaded was stored in a .csv file. Each column in the file is described as follows.  
1. _track_url_ (TEXT):	Spotify URI that uniquely identifies each track in the form of "spotify:track:<base-62 string>"  		 						
2. _ts_ (TIMESTAMP): Timestamp indicating when the track stopped playing in UTC (Coordinated Universal Time)								
3. _platform_ (TEXT): Platform used when streaming the track
4. _ms_played_ (BIGINT):	Number of milliseconds the stream was played
5. _track_name_ (TEXT): Name of the track
6. _artist_name_ (TEXT):	Name of the artist
7. _album_name_ (TEXT): Name of the album
8. _reason_start_ (TEXT): Why the track started
9. _reason_end_ (TEXT): Why the track ended
10. _shuffle_ (BOOLEAN): TRUE or FALSE depending on if shuffle mode was used when playing the track
11. _skipped_ (BOOLEAN): TRUE or FALSE depending on if the user skipped to the next song								

## Creating the Database
This task is to create a database in PostgreSQL where to store the new table that will contain the dataset. The query is as follows.
```
CREATE DATABASE sql_projects
;
```
In this query, **sql_projects** represents the name of the database.

## Creating the Table
This task involves creating a table where to store the data. To begin with, it is necessary to drop the table if it already exists. This is to avoid any conflict.

### Dropping the Table if it Exists
```
DROP TABLE spotify_history
;
```

### Creating Columns in the Table 
In this task, several columns with their data types were created in the table named spotify_history. The query is given below.
```
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
```
COPY spotify_history 
FROM 'C:\Users\edwig\Documents\Courses\SQL\SQL Projects\Spotify Streaming Analysis\spotify_history.csv'
DELIMITER ','
CSV HEADER
;
```

### Retrieving all the Data from the Table
Here, we write a query to retrieve all the data from the table named spotify_history. This is necessary to see if all the data were loaded correctly.
```
SELECT *
FROM spotify_history
;
```
This returned 149860 rows.

## Creating a New Table 
It is important to always keep the row data and copy it to a new table where to do the cleaning and transformation. This way, we can refer to that initial table at any stage of the project if we need more information. So, the table named **spotify_history** was copied to a new table named **spotify_streams** where to perform the cleaning. The query below was used.
```
CREATE TABLE spotify_streams AS
SELECT * 
FROM spotify_history
;
```
After creating the new table named **spotify_streams** from the initial table, we then wrote the query below to retrieve all the data.
```
SELECT *
FROM spotify_streams
; 
```
This returned 149860 rows.

## Renaming Columns in the Table
The column named **spotify_track_url** was renamed to **track_url** using the query below.
```
ALTER TABLE spotify_streams
RENAME COLUMN spotify_track_url TO track_url
;
```

## Checking and Removing Duplicates

### Checking for Duplicates
To check for duplicate values in the table, I used the `ROW_NUMBER()` window function and partitioned by all the columns. The reason behind partitioning by all columns was to ensure that rows counted as duplicates will have the same entries, otherwise, some rows may be skipped. The query reads as follows.
```
SELECT 
	track_url,
	ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, artist_name, album_name, reason_start, reason_end, shuffle, skipped) AS row_num
FROM spotify_streams
;
```

### Returning Duplicates based on one Column
After checking for duplicates using the above query, it is time to check and return the **track_url** column having `row_num > 1` which will be counted as duplicate values.
```
SELECT 
	track_url FROM (
		SELECT
			track_url,
			ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, artist_name, album_name, reason_start, reason_end, shuffle, skipped) AS row_num
		FROM spotify_streams
	) track
WHERE row_num > 1
;
```
This returned **1782** rows as duplicates.

<!--- ```
SELECT 
	track_url,
	COUNT(*)
FROM spotify_streams
GROUP BY track_url
HAVING COUNT(*) > 1
;
``` --->

### Returning all Rows with Duplicates
Now, we return all rows that have the same entries in all columns more than once which duplicate values that must be deleted.
```
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
```
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

### Assigning A Unique Identifier to Each Row
To facilitate the deleting process and ensure that we delete only duplicate rows from our table, we assign a unique number to each row in the table using `ctid`. Then, we can return rows with duplicate values before deleting them. The query reads as follows.
```
SELECT 
	ctid,
	ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, artist_name, album_name, reason_start, reason_end, shuffle, skipped) AS row_num
FROM spotify_streams
;
```
> [!Note]
> The **ctid** column gives a unique number to each row. So anywhere there is `row_num > 2` will be a duplicate and we will delete them.


* **Returning rows with duplicate values based on the ctid column**
```
SELECT 
	ctid
FROM (
	SELECT 
		ctid,
		ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, artist_name, album_name, reason_start, reason_end, shuffle, skipped) AS row_num
	FROM spotify_streams
) 
WHERE row_num > 1
;
```
This returned 1782 rows confirming what we saw earlier.


### Deleting Duplicate Values 
Now that we have identified rows with duplicate values and inspected as many of them to confirm that they are really duplicate values, we can delete these rows from the data without any doubt. The query is as follows.
```
DELETE FROM spotify_streams
WHERE ctid IN (
	SELECT 
		ctid
	FROM (
		SELECT 
			ctid,
			ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, artist_name, album_name, reason_start, reason_end, shuffle, skipped) AS row_num
		FROM spotify_streams
	) 
	WHERE row_num > 1
)
;
```
This deleted 1782 rows. 

> [!Note]
> Instead of assigning a unique identifier to each row as we did using **ctid** and deleting duplicate values based on that ctid column, we could have started by writing different queries as shown below to return all rows with duplicate values.
```
SELECT 
	row_num FROM (
		SELECT
			track_url,
			ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, artist_name, album_name, reason_start, reason_end, shuffle, skipped) AS row_num
		FROM spotify_streams
	) dup_rows
WHERE row_num > 1
)
;
```
Then, use the following query to copy all rows without duplicate values where `row_num = 1` to a new table named **spotify_streams_1**. Therefore, the other tasks will be completed based on the data in this new table.
```
SELECT * INTO spotify_streams_1
FROM (
	SELECT
		*, 
		ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, artist_name, album_name, reason_start, reason_end, shuffle, skipped) AS row_num
	FROM spotify_streams
	) rem_dup
WHERE row_num = 1
;
```

Using this second method, you will have to delete the **row_num** column from the table since it will not be needed further. This can be done using the query below.
```
ALTER TABLE spotify_streams_1
DROP COLUMN row_num
;
```

## Checking and Replacing NULL Values
In this task, we explore and query the data further to check for NULL values in the data and populate them wherever possible. 

> [!Note]
> Before deleting or replacing NULL Values, you should understand the behavior of each column with respect to other columns.

### Checking for NULL Values
The queries below were written to check for NULL values.
```
SELECT
  *
FROM spotify_streams
WHERE track_url IS NULL OR ts IS NULL OR platform IS NULL 
	OR ms_played IS NULL OR track_name IS NULL 
	OR artist_name IS NULL OR album_name IS NULL 
	OR reason_start IS NULL OR reason_end IS NULL 
	OR shuffle IS NULL OR skipped IS NULL
;
```
This returned **212** rows. 


* **Checking for NULL values in some columns**
```
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE track_url IS NULL OR ts IS NULL OR platform IS NULL 
	OR ms_played IS NULL OR track_name IS NULL 
	OR artist_name IS NULL OR album_name IS NULL 
	OR reason_start IS NULL OR reason_end IS NULL 
	OR shuffle IS NULL OR skipped IS NULL
;
```
This also returned 212 rows. After writing the above two queries and exploring the data further, we realized that the *reason_start* and *reason_end* were the ones with NULL Values.


* **Checking details for a specific track_url**  
```
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
```
SELECT 
	DISTINCT reason_start
FROM spotify_streams
;
```

* **Checking for NULL values in the reason_start and reason_end columns**    
```
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
This also returned 212 rows.


* **Checking for NULL values in the reason_start column**
```
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE 
	reason_start IS NULL 
;
```
This returned **143** rows.


* **Checking for NULL values in the reason_end column**
```
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000.0) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE 
	reason_end IS NULL 
;
```
This returned **117** rows.  

Since we now know the number of NULL values in the *reason_start* and *reason_end* columns, we can now base ourselves on the entries in these columns to populate NULL values. The queries below were written in that regard.


* **Checking for unknown values in the reason_start column**  
```
SELECT 
	*
FROM spotify_streams
WHERE 
	reason_start = 'unknown' 
;
```
This returned **23** rows.


* **Checking for unknown values in the reason_end column**  
```
SELECT 
	*
FROM spotify_streams
WHERE 
	reason_end = 'unknown' 
;
```
This returned **267** rows.


* **Checking for NULL values for a specific track_url**  
```
SELECT 
	track_url,
	ts AS start_time,
	(ts + (ms_played/1000) * INTERVAL '1 second') AS stop_time,
	ROUND(ms_played/60000.0, 2) AS minutes_played,
	reason_start, reason_end, shuffle, skipped
FROM spotify_streams
WHERE 
	track_url = '5Ux410GeRXrojeP0vUPx6v'
;
```
This returned 10 rows.  

Since there is not enough data (far less than 100), and we do not have much information on the NULL values, we cannot do anything here other than replace these NULL values in the *reason_start* and *reason_end* columns with 'unknown'. Check the query below.

### Replacing NULL Values
With the information we now know regarding entries in the *reason_start* and *reason_end* columns, we can go ahead and fill them with _unknown_. The query is written as follows. 
```
UPDATE spotify_streams
SET reason_start =
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
```
SELECT 
	*
FROM spotify_streams
;
```
This returned **148078** rows in total.

## Creating New Columns
In this task, we created new columns in the table. These columns will be useful during the analysis of the data and also aid in uncovering insights and providing recommendations.

### Adding and Populating the Column start_time

1. **Adding a column named start_time**
This is done by using the command `ALTER TABLE`. 
```
ALTER TABLE spotify_streams
ADD COLUMN start_time TIME
;
```

2. **Populating the column start_time**
Here, we populate the _start_time_ column using the time extracted from the _ts_ column.
```
UPDATE spotify_streams
SET start_time = ts::TIME
;
```

### Adding and Populating the Column end_time

1. **Adding a column named end_time**  
```
ALTER TABLE spotify_streams
ADD COLUMN end_time TIME
;
```

2. **Populating the column end_time**  
Here, we populate the _end_time_ column using both the _ts_ and the _ms_played_ columns. First, the _ms_played_ column is converted to seconds using `(ms_played/1000) * INTERVAL '1 second'` before adding it to the _ts_ column. Next, the time is extracted from the result to populate the _end_time_ column.
```
UPDATE spotify_streams
SET end_time = (ts + (ms_played/1000) * INTERVAL '1 second')::TIME
;
```

### Adding and Populating the Column minutes_played

1. **Adding a column named minutes_played**  
```
ALTER TABLE spotify_streams
ADD COLUMN minutes_played NUMERIC
;
```

2. **Populating the column minutes_played**
Here we populate the column named _minutes_played_ using the _ms_played_ column and converting it to minutes. The query is as follows.
```
UPDATE spotify_streams
SET minutes_played = ROUND(ms_played/60000.0, 2) 
;
```

### Adding and Populating the Column date_played

1. **Adding a column named date_played**
```
ALTER TABLE spotify_streams
ADD COLUMN date_played DATE
;
```

2. **Populating the column date_played**  
To Populate the column named _date_played_ we used the _ts_ column and extracted the date from it.
```
UPDATE spotify_streams
SET date_played = ts::DATE
;
```

## Conclusion
This project involved cleaning the Spotify Streams dataset to prepare it for analysis on another platform. The following tasks were completed:  
* Renaming columns for consistency  
* Removing duplicate values
* Populating NULL values
* Creating new columns

Now that the data is cleaned, we can proceed with the analysis.



<br/>
   
**Thank you for taking the time to read this report!**

**Please reach out for any updates.**

### Author
[Edwige Songong](https://github.com/Songonge)  



