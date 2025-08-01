# Project: Transportation and Logistics Analysis
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
   * [Loading Data into the Table](Loading-Data-in-the-Table)
8. [Data Cleaning](#Data-Cleaning)
   * [Checking for Duplicate Values](#Checking-for-duplicate-values)
   * [Checking and Filling NULL Values](#Checking-and-filling-NULL-values)
9. [Answering Questions from the Deliverables](#Answering-Questions-from-the-Deliverables)
   * [Retrieving Data from the New Table](#Retrieving-Data-from-the-new-Table)


## Introduction
The Transportation and Logistics Analysis was launched by FP20 Analytics as Challenge 24. It invited data enthusiasts to explore and derive actionable insights from a real-world logistics tracking dataset, featuring shipment records, GPS tracking, vehicle information, and transportation distances.  
The current report provides the data cleaning steps and responds to the questions asked for the challenge.


## Problem Statement
Shipment delays cause disruptions, and as a result, many industries suffer from not delivering goods on time. The question is, how do we help companies solve this issue of delay?

Knowing that in today's fast-paced supply chain industry, it is crucial to optimize shipment efficiency, reduce delivery times, and enhance operational visibility for total success, it is imperative to analyze historical data to uncover insights that will help the industry solve the issue while enhancing customer satisfaction. 


## Deliverables
1. Top Routes: What are the most common shipment routes and their average distances?
2. Delivery Times: Which routes have the longest delivery times?
3. Peak Shipments: When are the busiest booking and delivery dates?
4. Delays Analysis: What factors contribute to shipment delays?
5. Supplier Trends: Which suppliers handle the most shipments, and do some have higher delays?
6. Customer Insights: Which customers receive the most shipments, and do they experience delays?
7. Material Movement: What are the most frequently shipped materials, and do certain materials have longer delivery times?
8. Bottlenecks: Where are the most common shipment delays based on GPS data?
9. Predicting Delays: Can you build a model to predict shipment delays?
10. Route Optimization: What strategies can improve transportation efficiency?


## Tech Stack
The cleaning part of this project will be done in **PostgreSQL**.


## Data Information


The downloaded data contained the following information:  
* Number of rows: `3585` rows  
* Number of columns: `288` columns


### Description of Each Column in the Table
The data downloaded was stored in a .csv file. Each column in the file is described as follows.  
1. _GpsProvider_ (TEXT): GPS service provider tracking the vehicle.
2. _Booking_ID_ (TEXT): Unique identifier for each booking.
3. _Shipment_Type_ (TEXT): Indicates whether the shipment is a Market (spot booking) or Regular (contract-based) trip.
4. _Booking_Date_ (TIMESTAMP): The date and time when the booking was created.
5. _Vehicle_Registration_ (TEXT): The unique registration number of the vehicle used for transportation.
6. _Origin_Location_ (TEXT): The initial point from which the shipment starts.
7. _Destination_Location_ (TEXT): The final destination where the shipment is to be delivered.
8. _Origin_Loc_Latitude_ (NUMERIC): Latitude of the origin location.
9. _Origin_Loc_Longitude_ (NUMERIC): Longitude of the origin location.
10. _Destination_Loc_Latitude_ (NUMERIC): Latitude of the destination location.
11. _Destination_Loc_Longitude_ (NUMERIC): Longitude of the destination location.
12. _Data_Ping_Time_ (TIME): The timestamp of the last recorded GPS data ping from the vehicle.
13. _Planned_ETA_ (TIME): The expected time of arrival at the destination as per the trip plan.
14. _Current_Location_ (TEXT): The most recent known location of the vehicle.
15. _Actual_Eta_ (TIMESTAMP): The actual time of arrival at the destination.
16. _Current_Loc_Latitude_ (NUMERIC): The latitude of the vehicle’s current location.
17. _Current_Loc_Longitude_ (NUMERIC): The longitude of the vehicle’s current location.
18. _Ontime_ (TEXT): Indicates whether the vehicle arrived on time (Yes/No).
19. _Trip_Start_Date_ (TIMESTAMP): The actual start date and time of the trip.
20. _Trip_End_Date_ (TIMESTAMP): The estimated date and time of Arrival
21. _Transportation_Distance_Km_ (NUMERIC): The total distance covered by the vehicle during the trip in kilometers.
22. _Vehicle_Type_ (TEXT): The type of vehicle used for the shipment (e.g., 32 FT Truck, Tata Ace, Multi-Axle).
23. _Min_Km_Per_Day_ (BIGINT): The minimum distance the vehicle is expected to cover in a single day.
24. _Driver_Name_ (TEXT): The name of the driver assigned to the trip.
25. _Driver_Mobile_No_ (TEXT): The contact number of the driver.
26. _Customer_Name_Code_ (TEXT): The name of the customer receiving the shipment.
27. _Supplier_Name_Code_ (TEXT): The name of the supplier sending the shipment.
28. _Material_Shipped_ (TEXT): A description of the materials being transported in the shipment.
	

## Creating the Database
Since I already have the database available, I will just go ahead and create my table to store the data. If not, the following query can be used: 
```sql
CREATE DATABASE sql_projects
;
```
In this query, **sql_projects** represents the name of the database.

## Creating the Table

### Dropping the Table if it Exists

```sql
DROP TABLE transportation_raw
;
```

### Creating the table
```sql
CREATE TABLE transportation_raw (
	gps_provider TEXT,
    booking_id TEXT,
    shipment_type TEXT,
    booking_date TIMESTAMP,
    vehicle_registration TEXT,
    origin_location TEXT,
    destination_location TEXT,
    origin_loc_latitude NUMERIC,
    origin_loc_longitude NUMERIC,
    destination_loc_latitude NUMERIC,
    destination_loc_longitude NUMERIC,
    data_ping_time TIME,
    planned_eta TIME,
    current_location TEXT,
    actual_eta TIMESTAMP,
    current_loc_latitude NUMERIC,
    current_loc_longitude NUMERIC,
    ontime TEXT,
    trip_start_date TIMESTAMP,
    trip_end_date TIMESTAMP,
    transportation_distance_km NUMERIC,
    vehicle_type TEXT,
    min_km_per_day BIGINT,
    driver_name TEXT,
    driver_mobile_no TEXT,
    customer_name_code TEXT,
    supplier_name_code TEXT,
    material_shipped TEXT
)
;
```

### Loading Data Into the Table 
Here, we load data into the table from the .csv file.
```sql
COPY transportation_raw
FROM 'your_path\transportation.csv'
null 'NULL'
DELIMITER ','
CSV HEADER
;
```

### Retrieving all the data from the table named spotify_history
```sql
SELECT * 
FROM transportation_raw
;
```

### Creating a new table named transportation as a copy of the table transportation_raw, where to perform the cleaning.
```sql
DROP TABLE transportation
;
```

```sql
CREATE TABLE transportation AS
SELECT * 
FROM transportation_raw
;
```

```sql
SELECT * 
FROM transportation
;
```

## Data Cleaning

### Checking for Duplicate Values
```sql
SELECT 
	booking_id,
	COUNT(*) AS total
FROM transport
GROUP BY booking_id
HAVING COUNT(*) > 1
;
```

```sql
SELECT 
	booking_id
FROM (
	SELECT
		booking_id, 
		ROW_NUMBER() OVER (PARTITION BY
			booking_id,
			gps_provider,
		    	shipment_type,
		    	booking_date,
		   	vehicle_registration,
		    	origin_location,
		    	destination_location,
		    	origin_loc_latitude,
		    	origin_loc_longitude,
		    	destination_loc_latitude,
		    	destination_loc_longitude,
		    	data_ping_time,
		    	planned_eta,
		    	current_location,
		    	actual_eta,
		    	current_loc_latitude,
		    	current_loc_longitude,
		    	ontime,
		    	trip_start_date,
		    	trip_end_date,
		    	transportation_distance_km,
		    	vehicle_type,
		    	min_km_per_day,
		    	driver_name,
		    	driver_mobile_no,
		    	customer_name_code,
		    	supplier_name_code,
		    	material_shipped
		) AS row_num
	FROM transport
	) dup
WHERE row_num > 1
; 
```
No duplicate values found.


### Checking and Filling NULL Values
```sql
SELECT *
FROM transportation
WHERE gps_provider IS NULL OR
	booking_id IS NULL OR
    	shipment_type IS NULL OR
    	booking_date IS NULL OR
    	vehicle_registration IS NULL OR
    	origin_location IS NULL OR
    	destination_location IS NULL OR
    	origin_loc_latitude IS NULL OR
    	origin_loc_longitude IS NULL OR
    	destination_loc_latitude IS NULL OR
    	destination_loc_longitude IS NULL OR
    	data_ping_time IS NULL OR
    	planned_eta IS NULL OR
    	current_location IS NULL OR
    	actual_eta IS NULL OR
    	current_loc_latitude IS NULL OR
    	current_loc_longitude IS NULL OR
    	ontime IS NULL OR
    	trip_start_date IS NULL OR
    	trip_end_date IS NULL OR
    	transportation_distance_km IS NULL OR
    	vehicle_type IS NULL OR
    	min_km_per_day IS NULL OR
    	driver_name IS NULL OR
    	driver_mobile_no IS NULL OR
    	customer_name_code IS NULL OR
    	supplier_name_code IS NULL OR
    	material_shipped IS NULL
;
```

#### Checking for NULL values in the _min_km_per_day_ column.
```sql
SELECT 
	DISTINCT min_km_per_day
FROM transportation
;
```

```sql
UPDATE transportation
SET min_km_per_day = 0
WHERE min_km_per_day IS NULL OR min_km_per_day NOT IN (250, 275);
;
```

```sql
SELECT 
	COUNT(min_km_per_day)
FROM transportation
WHERE min_km_per_day = 275

UNION

SELECT 
	COUNT(min_km_per_day)
FROM transportation
WHERE min_km_per_day = 250

UNION

SELECT 
	COUNT(min_km_per_day)
FROM transportation
WHERE min_km_per_day = 0
;
```

#### Copying the table to a new table
```sql
CREATE TABLE transport AS
SELECT *
FROM transportation
;
```

Retrieving the data from the newly copied table.
```sql
SELECT *
FROM transport
;
```


#### Filling blank or NULL values in the _min_km_per_day_ column with a random selection between 250 and 275.
```sql
UPDATE transport
SET min_km_per_day = CASE 
    WHEN random() < 0.5 THEN 250  
    ELSE 275  
END
WHERE min_km_per_day NOT IN (250, 275)
; 
```
This updated `2645` rows.

```sql
SELECT 
	DISTINCT min_km_per_day
FROM transport
;
```

#### Checking for NULL values in the _vehicle_type_ column
```sql
SELECT 
	vehicle_type,
	COUNT(vehicle_type) AS total
FROM transport
GROUP BY vehicle_type
ORDER BY total DESC
;
```

```sql
SELECT 
	COUNT(
    CASE
      WHEN vehicle_type IS NULL
      THEN 1
    END
  ) AS total
FROM transport
;
```

```sql
SELECT 
	booking_id,
	COUNT(*) AS total
FROM transport
GROUP BY booking_id
HAVING COUNT(*) > 1
;
```

```sql
SELECT 
	*
FROM transport
WHERE booking_id = 'MVCV0000759/082021'
;
```

```sql
SELECT 
	*
FROM transport
WHERE booking_id = 'MVCV0000798/082021'
;
```

<!--
```sql
-- SELECT 
-- 	*
-- FROM transportation
-- WHERE current_location = 'Null'
-- ;
```
-->

```sql
SELECT
	booking_id, shipment_type,
	booking_date, vehicle_registration,
	origin_location, destination_location,
	origin_loc_latitude, origin_loc_longitude,
	destination_loc_latitude, destination_loc_longitude,
	data_ping_time,	planned_eta,
	current_location, actual_eta,
	current_loc_latitude, current_loc_longitude,
	ontime,	trip_start_date, trip_end_date,
	transportation_distance_km,	vehicle_type,
	min_km_per_day,	driver_name, driver_mobile_no,
	customer_name_code,	supplier_name_code,
	material_shipped,	
	COUNT(*) AS total
FROM transport
GROUP BY
	booking_id, shipment_type,
	booking_date, vehicle_registration,
	origin_location, destination_location,
	origin_loc_latitude, origin_loc_longitude,
	destination_loc_latitude, destination_loc_longitude,
	data_ping_time,	planned_eta,
	current_location, actual_eta,
	current_loc_latitude, current_loc_longitude,
	ontime,	trip_start_date, trip_end_date,
	transportation_distance_km, vehicle_type,
	min_km_per_day,	driver_name, driver_mobile_no,
	customer_name_code, supplier_name_code,
	material_shipped,
HAVING COUNT(*) > 1
;
```

```sql
SELECT
	booking_id,	
	COUNT(*) AS total
FROM transport
GROUP BY booking_id
HAVING COUNT(*) > 1
;
```

```sql
SELECT 
	ctid,
	ROW_NUMBER() OVER (PARTITION BY 
	booking_id, shipment_type,
	booking_date, vehicle_registration,
	origin_location, destination_location,
	origin_loc_latitude, origin_loc_longitude,
	destination_loc_latitude, destination_loc_longitude,
	data_ping_time,	planned_eta,
	current_location, actual_eta,
	current_loc_latitude, current_loc_longitude,
	ontime,	trip_start_date, trip_end_date,
	transportation_distance_km, vehicle_type,
	min_km_per_day,	driver_name, driver_mobile_no,
	customer_name_code, supplier_name_code,
	material_shipped
	) AS row_num
FROM transport
;
```

```sql
SELECT 
	ctid
FROM (
	SELECT 
		ctid,
		ROW_NUMBER() OVER (PARTITION BY 
		booking_id, shipment_type,
		booking_date, vehicle_registration,
		origin_location, destination_location,
		origin_loc_latitude, origin_loc_longitude,
		destination_loc_latitude, destination_loc_longitude,
		data_ping_time,	planned_eta,
		current_location, actual_eta,
		current_loc_latitude, current_loc_longitude,
		ontime,	trip_start_date, trip_end_date,
		transportation_distance_km, vehicle_type,
		min_km_per_day,	driver_name, driver_mobile_no,
		customer_name_code, supplier_name_code,
		material_shipped) AS row_num
	FROM transport
) 
WHERE row_num > 1
;
```

<!--
```sql
-- ALTER TABLE transport
-- ADD CONSTRAINT booking_key PRIMARY KEY (booking_id)
-- ;
```
-->

#### Setting the _booking_id_ column as a PRIMARY KEY
```sql
-- Checking for entries for one of the duplicated _booking_id_
SELECT 
	*
FROM transport
WHERE booking_id = 'MVCV0000759/082021'
;
```

```sql
SELECT 
	material_shipped,
	COUNT(*)
FROM transport
WHERE material_shipped LIKE '%Rectifier%'
GROUP BY material_shipped
;
```
```sql
DELETE FROM transport
WHERE booking_id = 'MVCV0000759/082021' AND material_shipped = 'Rectifier'
;
```

#### Checking for entries for the other duplicated _booking_id_
```sql
SELECT *
FROM transport
WHERE booking_id = 'MVCV0000798/082021'
;
```

```sql
SELECT 
	DISTINCT material_shipped,
	COUNT(*)
FROM transport
WHERE material_shipped LIKE 'Iut Part'
	OR material_shipped LIKE '%Sol. Re%'
	OR material_shipped LIKE 'Solenoid Switch'
GROUP BY material_shipped
;
```

```sql
SELECT 
	booking_id,
	customer_name_code,
	material_shipped,
	COUNT(*)
FROM transport
WHERE customer_name_code LIKE 'Hi-Tech%' AND material_shipped LIKE 'Iut Part'
	OR customer_name_code LIKE 'Rico Auto%' AND material_shipped LIKE '%Sol. Re%'
	OR customer_name_code LIKE 'Talbros%' AND material_shipped LIKE 'Solenoid Switch'
GROUP BY 
  booking_id, 
  customer_name_code, 
  material_shipped
;
```

<!--
```sql
-- SELECT 
-- 	gps_provider,
-- 	COUNT(*)
-- FROM transport
-- WHERE material_shipped LIKE '%Rectifier%'
-- GROUP BY gps_provider
-- ;
```
-->

### Checking for NULL values in the entire table
```sql
SELECT *
FROM transport
WHERE gps_provider IS NULL OR
	booking_id IS NULL OR
    	shipment_type IS NULL OR
    	booking_date IS NULL OR
	vehicle_registration IS NULL OR
    	origin_location IS NULL OR
    	destination_location IS NULL OR
    	origin_loc_latitude IS NULL OR
    	origin_loc_longitude IS NULL OR
    	destination_loc_latitude IS NULL OR
    	destination_loc_longitude IS NULL OR
    	data_ping_time IS NULL OR
    	planned_eta IS NULL OR
    	current_location IS NULL OR
    	actual_eta IS NULL OR
    	current_loc_latitude IS NULL OR
    	current_loc_longitude IS NULL OR
    	ontime IS NULL OR
    	trip_start_date IS NULL OR
    	trip_end_date IS NULL OR
    	transportation_distance_km IS NULL OR
    	vehicle_type IS NULL OR
    	min_km_per_day IS NULL OR
    	driver_name IS NULL OR
    	driver_mobile_no IS NULL OR
    	customer_name_code IS NULL OR
    	supplier_name_code IS NULL OR
    	material_shipped IS NULL
; 
```
This returned `933` rows.

#### Checking for NULL values in the _current_location_ column
```sql
SELECT DISTINCT current_location
FROM transport
-- WHERE 
-- current_location = 'Null'
ORDER BY current_location ASC
; 
```
This returned `12` rows.

```sql
SELECT
	current_location
FROM transport
WHERE current_location LIKE '????, Nashik - Pune Hwy, Chimbali, Maharashtra 412105, India'
;
```

#### Updating inconsistent names in the current_location column
```sql
UPDATE transport
SET current_location = 'Unnamed Road, Nashik - Pune Hwy, Chimbali, Maharashtra 412105, India'
WHERE current_location = '????, Nashik - Pune Hwy, Chimbali, Maharashtra 412105, India'
;
```

```sql
UPDATE transport
SET current_location = 'Unnamed Road, Diara Sector, Bilaspur, Himachal Pradesh 174001, India'
WHERE current_location = '???? ???, Diara Sector, Bilaspur, Himachal Pradesh 174001, India'
;
```

```sql
UPDATE transport
SET current_location = 'Unnamed Road, Pune - Pandharpur Rd, Maharashtra 415528, India'
WHERE current_location = '?Pune - Pandharpur Rd, Maharashtra 415528, India'
;
```

```sql
UPDATE transport
SET current_location = 'Unknown'
WHERE current_location = 'Null'
; 
```
This updated `12` rows.

```sql
SELECT *
FROM transport
;
```

```sql
SELECT *
FROM transport
WHERE 
	min_km_per_day IS NULL OR
    	driver_name IS NULL OR
    	driver_mobile_no IS NULL OR
    	customer_name_code IS NULL OR
    	supplier_name_code IS NULL OR
    	material_shipped IS NULL
;
```

### Filling NULL values in the _gps_provider_ column
```sql
UPDATE transport
SET gps_provider = 'Unknown'
WHERE gps_provider = 'Null'
;
```

#### Checking for NULL values in the _gps_provider_ column
```sql
SELECT 
	data_ping_time, 
	COUNT(*) AS total
FROM transport
GROUP BY data_ping_time
ORDER BY total DESC
;
```

#### Filling NULL values in the _gps_provider_ column
```sql
UPDATE transport
SET data_ping_time = '00:05:09'
WHERE data_ping_time IS NULL 
;
```

#### Checking for NULL values in the _actual_eta_ column
```sql
SELECT 
	actual_eta, 
	COUNT(*) AS total
FROM transport
GROUP BY actual_eta
ORDER BY total DESC
;
```

#### Filling NULL values in the actual_eta column
```sql
UPDATE transport
SET actual_eta = CAST(
	CASE 
		WHEN random() < 0.5 THEN '2020-08-04 21:38:00' 
		WHEN random() BETWEEN 0.5 AND 1 THEN '2020-06-18 17:19:00' 
		WHEN random() > 1 THEN '2020-07-31 13:13:00'
	END AS TIMESTAMP)
WHERE actual_eta IS NULL
;
```

#### Checking for NULL values in the _transportation_distance_km_ column

```sql
SELECT
	DISTINCT transportation_distance_km,
	COUNT(*) AS total
FROM transport
GROUP BY transportation_distance_km
ORDER BY total DESC
;
```

```sql
SELECT *
FROM transport
WHERE gps_provider = 'Consent Track'
;
```

```sql
ALTER TABLE transport
ALTER transportation_distance_km TYPE NUMERIC
;
```

#### Filling NULL values in the _transportation_distance_km_ column
```sql
SELECT 
	COALESCE(transportation_distance_km, (
		SELECT 
			ROUND(AVG(transportation_distance_km), 1)
		FROM transport 
		WHERE gps_provider = 'Consent Track'
		)
	) AS transportation_distance_km
FROM transport
;
```

```sql
UPDATE transport
SET transportation_distance_km = (
		SELECT 
			ROUND(AVG(transportation_distance_km), 1)
		FROM transport 
		WHERE gps_provider = 'Consent Track'
		)
WHERE transportation_distance_km IS NULL 
;
```


#### Checking for NULL values in the _transportation_distance_km_ column
```sql
SELECT 
	DISTINCT vehicle_type,
	COUNT(*) AS total
FROM transport
GROUP BY vehicle_type
ORDER BY total DESC
;  
```
This returned `39` rows with `763` NULL values.

```sql
SELECT *
FROM transport
WHERE vehicle_type IS NULL
; 
```
This returned `763` rows.

```sql
SELECT 
	gps_provider,
	booking_id,
	vehicle_type,
	COUNT(*) AS total
FROM transport
WHERE vehicle_type IS NULL
GROUP BY
	gps_provider,
	booking_id,
	vehicle_type
ORDER BY total DESC
;  
```
This returned `761` to,ws most of them being Vamosys gps_provider.

```sql
SELECT 
	gps_provider,
	COUNT(*) AS total
FROM transport
WHERE vehicle_type IS NULL
GROUP BY gps_provider
ORDER BY total DESC
;  
```
This returned `12` rows with `600` Vamosys gps_provider.

```sql
SELECT 
	*
FROM transport
WHERE gps_provider = 'Vamosys' AND vehicle_type = '32 FT Multi-Axle 14MT - HCV'
;
```

```sql
SELECT 
	DISTINCT vehicle_type,
	COUNT(*) AS total
FROM transport
-- WHERE gps_provider = 'Vamosys' 
GROUP BY vehicle_type
ORDER BY total DESC
--AND vehicle_type = '32 FT Multi-Axle 14MT - HCV'
;
```

```sql
UPDATE transport
SET vehicle_type = '32 FT Multi-Axle 14MT - HCV'
WHERE vehicle_type IS NULL AND gps_provider = 'Vamosys'
;
```

```sql
UPDATE transport
SET vehicle_type = '32 FT Multi-Axle 14MT - HCV'
WHERE vehicle_type IS NULL AND gps_provider = 'Vamosys'
;
```

```sql
SELECT 
	vehicle_type,
	COUNT(*) AS total
FROM transport
WHERE gps_provider = 'Consent Track' --AND vehicle_type = 'MVCV0000798/082021'
GROUP BY 
	vehicle_type
ORDER BY total DESC
;
```

```sql
UPDATE transport
SET vehicle_type = '40 FT 3XL Trailer 35MT'
WHERE vehicle_type IS NULL AND gps_provider = 'Consent Track'
;
```

```sql
SELECT 
	vehicle_type,
	COUNT(*) AS total
FROM transport
WHERE gps_provider = 'Virstempo' --AND vehicle_type = 'MVCV0000798/082021'
GROUP BY 
	vehicle_type
ORDER BY total DESC
;
```

```sql
SELECT *
FROM transport
WHERE gps_provider = 'Virstempo'
; 
```
This returned `14` rows with _vehicle_type_ all NULL values.

```sql
UPDATE transport
SET vehicle_type = 'Unknown'
WHERE vehicle_type IS NULL AND gps_provider = 'Virstempo'
;
```

```sql
SELECT *
FROM transport
WHERE gps_provider = 'Bhiwadidelhiroadline'
;
```

```sql
UPDATE transport
SET vehicle_type = 'Unknown'
WHERE vehicle_type IS NULL AND gps_provider = 'Bhiwadidelhiroadline'
;
```

```sql
SELECT *
FROM transport
WHERE gps_provider = 'Beecon'
; -- This returned 33 rows with vehicle_type all NULL values
```

```sql
UPDATE transport
SET vehicle_type = '32 FT Multi-Axle 14MT - HCV'
WHERE vehicle_type IS NULL AND gps_provider = 'Beecon'
;
```

```sql
SELECT *
FROM transport
WHERE gps_provider = 'Krc Logistics'
; 
```

```sql
UPDATE transport
SET vehicle_type = '32 FT Multi-Axle 14MT - HCV'
WHERE vehicle_type IS NULL AND gps_provider = 'Krc Logistics'
;
```

```sql
SELECT *
FROM transport
WHERE gps_provider = 'Nimble'
;
```

```sql
UPDATE transport
SET vehicle_type = '32 FT Multi-Axle 14MT - HCV'
WHERE vehicle_type IS NULL AND gps_provider = 'Nimble'
;
```

```sql
SELECT *
FROM transport
WHERE gps_provider = 'Wabcotrans'
;
```

```sql
UPDATE transport
SET vehicle_type = 'Unknown'
WHERE vehicle_type IS NULL AND gps_provider = 'Wabcotrans'
;
```

```sql
SELECT *
FROM transport
WHERE vehicle_type IS NULL
;
```

```sql
SELECT *
FROM transport
WHERE gps_provider = 'Dhillongoods'
	OR gps_provider = 'Manual'
	OR gps_provider = 'Apace_Transco'-- Bally Logistics'
; 
```
This returned `13` rows with _vehicle_type_ all NULL values.

```sql
UPDATE transport
SET vehicle_type = '32 FT Multi-Axle 14MT - HCV'
WHERE gps_provider = 'Dhillongoods'
	OR gps_provider = 'Manual'
	OR gps_provider = 'Apace_Transco'-- Bally Logistics'
;
```

```sql
UPDATE transport
SET vehicle_type = '32 FT Multi-Axle 14MT - HCV'
WHERE vehicle_type IS NULL AND gps_provider = 'Bally Logistics'
;
```

```sql
SELECT 
	DISTINCT vehicle_type,
	COUNT(*) AS total
FROM transport
GROUP BY vehicle_type
ORDER BY total DESC
;
```

```sql
UPDATE transport
SET vehicle_type = '32 FT Multi-Axle 14MT - HCV'
WHERE vehicle_type ='Unknown'
;
```

```sql
SELECT *
FROM transport
;
```

```sql
SELECT 
	DISTINCT driver_mobile_no,
	COUNT(*) AS total
FROM transport
-- WHERE driver_mobile_no = 'NA'
GROUP BY driver_mobile_no
ORDER BY total DESC
;
```

```sql
UPDATE transport
SET driver_mobile_no = 'Unknown'
WHERE driver_mobile_no ='NA'
;
```

```sql
SELECT DISTINCT shipment_type
FROM transport
;
```

```sql
CREATE TABLE transport_new AS
SELECT * 
FROM transport
;
```

```sql
SELECT * 
FROM transport_new
;
```

#### Splitting the origin_location column into three columns representing the town, city, and state
```sql
SELECT
	origin_location,
	SPLIT_PART(origin_location, ',', 1) AS origin_town,
	SPLIT_PART(origin_location, ',', 2) AS origin_city,
	SPLIT_PART(origin_location, ',', 3) AS origin_state
FROM transport_new
;
```

<!--
```sql
-- ALTER TABLE transport_new
-- DROP COLUMN origin_town, 
-- DROP COLUMN origin_city, 
-- DROP COLUMN origin_state
-- ;
```
-->

```sql
ALTER TABLE transport_new
ADD COLUMN origin_loc_town TEXT, 
ADD COLUMN origin_loc_city TEXT, 
ADD COLUMN origin_loc_state TEXT
;
```

```sql
UPDATE transport_new
SET 
	origin_loc_town = SPLIT_PART(origin_location, ',', 1),
	origin_loc_city = SPLIT_PART(origin_location, ',', 2),
	origin_loc_state = SPLIT_PART(origin_location, ',', 3)
;
```

```sql
ALTER TABLE transport_new
ADD COLUMN destination_loc_town TEXT, 
ADD COLUMN destination_loc_city TEXT, 
ADD COLUMN destination_loc_state TEXT
;
```

```sql
UPDATE transport_new
SET 
	destination_loc_town = SPLIT_PART(destination_location, ',', 1),
	destination_loc_city = SPLIT_PART(destination_location, ',', 2),
	destination_loc_state = SPLIT_PART(destination_location, ',', 3)
;
```

```sql
ALTER TABLE transport_new
ADD COLUMN current_loc_country TEXT 
;
```

```sql
UPDATE transport_new
SET current_loc_country = RIGHT(current_location, 5)
;
```

```sql
UPDATE transport_new
SET destination_loc_town = 'Hosur - Thally Rd, Near By Karnoor Village, Tamil Nadu 635110, India'
WHERE current_location = 'Block No. 1 Survey No. 466,467,468,469, Plot No. 474, 485, Hosur - Thally Rd, Near By Karnoor Village, Tamil Nadu 635110, India'
;
```

```sql
UPDATE transport_new
SET destination_loc_town = 'Keshav Rd, Meerut, Uttar Pradesh 250103, India'
WHERE current_location = 'Keshav Rd, Panchvati Enclave, Sector 4, Mda, Meerut, Uttar Pradesh 250103, India'
;
```

```sql
UPDATE transport_new
SET destination_loc_town = 'Golf Links Rd, Ghaziabad, Uttar Pradesh 201001, India'
WHERE current_location = 'Golf Links Rd, Pandav Nagar, Uttar Pradesh 201001, India'
;
```

```sql
UPDATE transport_new
SET destination_loc_town = '17, Ghaziabad, Uttar Pradesh 201003, India'
WHERE current_location = '17, Mainapur, Uttar Pradesh 201003, India'
;
```

```sql
UPDATE transport_new
SET destination_loc_town = 'Outer Ring Road, Bengaluru, Karnataka 560043, India'
WHERE current_location = 'No 13/14 Royal Chambers, 3rd Floor, Dodda Banaswadi, Outer Ring Road, Near Vijaya Bank Colony., Annaiah Reddy Layout, Dodda Banaswadi, Bengaluru, Karnataka 560043, India'
;
```

```sql
ALTER TABLE transport_new
ADD COLUMN current_loc_road TEXT,
ADD COLUMN current_loc_city TEXT, 
ADD COLUMN current_loc_state TEXT, 
ADD COLUMN current_loc_country TEXT, 
ADD COLUMN current_loc_t1 TEXT, 
ADD COLUMN current_loc_t2 TEXT, 
ADD COLUMN current_loc_t3 TEXT,
ADD COLUMN current_loc_t4 TEXT
;
```

```sql
ALTER TABLE transport_new
DROP COLUMN current_loc_road,
DROP COLUMN current_loc_city, 
DROP COLUMN current_loc_state, 
DROP COLUMN current_loc_country, 
DROP COLUMN current_loc_t1, 
DROP COLUMN current_loc_t2, 
DROP COLUMN current_loc_t3,
DROP COLUMN current_loc_t4
;
```

<!--
```sql
-- UPDATE transport_new
-- SET 
-- 	current_loc_town = SPLIT_PART(origin_location, ',', 1),
-- 	current_loc_city = SPLIT_PART(origin_location, ',', 2),
-- 	current_loc_state = SPLIT_PART(origin_location, ',', 3)
-- ;
```
-->

```sql
UPDATE transport_new
SET
	current_loc_road = SPLIT_PART(current_location, ',', 1),
	current_loc_city = SPLIT_PART(current_location, ',', 2),
	current_loc_state = SPLIT_PART(current_location, ',', 3),
	current_loc_country = SPLIT_PART(current_location, ',', 4),
	current_loc_t1 = SPLIT_PART(current_location, ',', 5),
	current_loc_t2 = SPLIT_PART(current_location, ',', 6),
	current_loc_t3 = SPLIT_PART(current_location, ',', 7),
	current_loc_t4 = SPLIT_PART(current_location, ',', 8) 
;
```

<!--
```sql
-- DROP TABLE location
-- ;
-- CREATE TABLE location AS
-- SELECT
-- 	current_location,
-- 	SPLIT_PART(current_location, ',', 1) AS road,
-- 	SPLIT_PART(current_location, ',', 2) AS city,
-- 	SPLIT_PART(current_location, ',', 3) AS state,
-- 	SPLIT_PART(current_location, ',', 4) AS t1,
-- 	SPLIT_PART(current_location, ',', 5) AS t2,
-- 	SPLIT_PART(current_location, ',', 6) AS t3,
-- 	SPLIT_PART(current_location, ',', 7) AS t4,
-- 	SPLIT_PART(current_location, ',', 8) AS t5
-- FROM transport_new
-- ;
```
-->

```sql
UPDATE transport_new
SET current_loc_state = 'Tamil Nadu 635110'
WHERE current_loc_state = '468' AND current_loc_road = 'Block No. 1 Survey No. 466'
;
```

```sql	
SELECT *
FROM transport_new
;
```

## Answering Questions from the Deliverables

### Top Routes: Most Common Shipment Routes and Their Average Distances
```sql
SELECT 
    origin_location, 
    destination_location, 
    COUNT(*) AS total_shipments, 
    ROUND(
		  AVG(transportation_distance_km), 2
	  ) AS avg_distance
FROM transport_new
GROUP BY 
	origin_location, 
	destination_location
ORDER BY total_shipments DESC, avg_distance DESC
-- LIMIT 10
;
```


### Delivery Times: Routes with the Longest Delivery Times
```sql
SELECT 
  origin_location, 
  destination_location, 
  ROUND(
    AVG(
      EXTRACT(
        EPOCH FROM (trip_end_date - trip_start_date)
      )/3600
	  ), 2
  ) AS avg_delivery_time_hours
FROM transport_new
GROUP BY 
	origin_location, 
	destination_location
ORDER BY avg_delivery_time_hours DESC
LIMIT 10
;
```

### Peak Shipments: Busiest Booking and Delivery Dates

#### Busiest Booking Dates
```sql
SELECT 
	TO_CHAR(booking_date, 'Day') AS day_name,
    COUNT(*) AS total_bookings
FROM transport_new
GROUP BY booking_date
ORDER BY total_bookings DESC
LIMIT 10
;
```

<!--
-- WITH cte AS (
-- SELECT 
-- 	TO_CHAR(booking_date, 'Day') AS day_name,
--     COUNT(*) AS total_bookings
-- FROM transport_new
-- GROUP BY booking_date
-- ORDER BY total_bookings DESC
-- -- LIMIT 10
-- )
-- SELECT 
-- 	day_name,
--     total_bookings
-- FROM cte 
-- GROUP BY day_name, total_bookings
-- ORDER BY total_bookings DESC
-- ; -->

#### Busiest Delivery Dates
```sql
SELECT 
    DATE(trip_end_date) AS delivery_day, 
    COUNT(*) AS total_deliveries
FROM transport_new
GROUP BY delivery_day
ORDER BY total_deliveries DESC
LIMIT 10
;
```

### Delays Analysis: Factors Contributing to Shipment Delays
```sql
SELECT 
    vehicle_type, 
    shipment_type, 
    ROUND(AVG(EXTRACT(
		EPOCH FROM (actual_eta - (actual_eta::date + planned_eta)::timestamp))/3600), 2
	) AS avg_delay_hours,
    COUNT(*) AS delayed_shipments
FROM transport_new
WHERE actual_eta > (actual_eta::date + planned_eta)::timestamp
GROUP BY vehicle_type, shipment_type
ORDER BY avg_delay_hours DESC
;
```

### Supplier Trends: Top Suppliers and Their Delay Rates
```sql
SELECT 
    supplier_name_code, 
    COUNT(*) AS total_shipments,
    SUM(
		CASE 
			WHEN actual_eta > (actual_eta::date + planned_eta)::timestamp 
			THEN 1 
			ELSE 0 
		END
	) AS delayed_shipments,
    ROUND(
		(SUM(
			CASE WHEN actual_eta > (actual_eta::date + planned_eta)::timestamp 
			THEN 1 
				ELSE 0 
			END
		) * 100.0) / COUNT(*), 2
	) AS delay_percentage
FROM transport_new
GROUP BY supplier_name_code
ORDER BY total_shipments DESC
LIMIT 10
;
```

### Customer Insights: Top Customers and Their Delay Experience
```sql
SELECT 
    customer_name_code, 
    COUNT(*) AS total_shipments,
    SUM(
		CASE 
			WHEN actual_eta > (actual_eta::date + planned_eta)::timestamp 
			THEN 1 
			ELSE 0 
		END
		) AS delayed_shipments,
    ROUND((
	SUM(
		CASE
			WHEN actual_eta > (actual_eta::date + planned_eta)::timestamp 
			THEN 1 
			ELSE 0 
		END
	) * 100.0) / COUNT(*), 2
) AS delay_percentage
FROM transport_new
GROUP BY customer_name_code
ORDER BY total_shipments DESC
LIMIT 10
;
```

### Material Movement: Most Frequently Shipped Materials and Delivery Times
```sql
SELECT 
	material_shipped, 
    	COUNT(*) AS total_shipments, 
    	ROUND(
		AVG(
			EXTRACT(EPOCH FROM (trip_end_date - trip_start_date))/3600
		), 2
	) AS avg_delivery_time_hours
FROM transport_new
GROUP BY material_shipped
ORDER BY total_shipments DESC
LIMIT 10
;
```

### Bottlenecks: Most Common Shipment Delays Based on GPS Data
```sql
SELECT 
	current_location, 
    	COUNT(*) AS delay_occurrences,
    	ROUND(
		AVG(
			EXTRACT(EPOCH FROM (actual_eta - (actual_eta::date + planned_eta)::timestamp ))/3600
		), 2
	) AS avg_delay_hours
FROM transport_new
WHERE actual_eta > (actual_eta::date + planned_eta)::timestamp 
GROUP BY current_location
ORDER BY delay_occurrences DESC
LIMIT 10
;
```

### Predicting Delays: To build a model predicting shipment delays, first extract key features:
```sql
SELECT 
    transportation_distance_km,
    vehicle_type,
    shipment_type,
    EXTRACT(HOUR FROM booking_date) AS booking_hour,
    EXTRACT(DOW FROM booking_date) AS booking_day,
    EXTRACT(HOUR FROM trip_start_date) AS start_hour,
    EXTRACT(DOW FROM trip_start_date) AS start_day,
    CASE 
		WHEN actual_eta > (actual_eta::date + planned_eta)::timestamp 
		THEN 1 
		ELSE 0 
	END AS is_delayed
FROM transport_new
;
```

### Route Optimization: Strategies for Efficiency

A key optimization is finding routes where the actual distance deviates from the expected:
```sql
SELECT 
	origin_location, 
    	destination_location, 
    	ROUND(AVG(transportation_distance_km), 2) AS avg_distance,
    	ROUND(AVG(
		EXTRACT(EPOCH FROM (trip_end_date - trip_start_date))/3600), 2
	) AS avg_delivery_time_hours
FROM transport_new
GROUP BY origin_location, destination_location
HAVING COUNT(*) > 5
ORDER BY avg_delivery_time_hours, avg_distance DESC
LIMIT 10
;
```

```sql
SELECT *
FROM transport_new
;
```

```sql
DROP TABLE customers
;
```

```sql
CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	customer_name TEXT,
	full_address TEXT
);
```

```sql
INSERT INTO customers
(customer_id, customer_name, full_address)
VALUES
(1, 'Jane Smith', '456 Maple Ave., San Francisco, CA, 44102'),
(2, 'Emily Davis', '321 Pine Ln., Miami, FL, 33130'),
(3, 'Olivia Wong', '555 Ocean Blvd, Santa Monica, CA, 90210'),
(4, 'Julia Lopez', '789 Oak Rd, Houston, TX, 77005'),
(5, 'Anna Jones', '1001 Cedar Dr., Dallas, TX, 75001')
;
```

```sql
SELECT *
FROM customers
;
```

```sql
ALTER TABLE customers
ADD COLUMN street TEXT,
ADD COLUMN city TEXT,
ADD COLUMN state TEXT,
ADD COLUMN postal_code TEXT
;
```

```sql
UPDATE customers
SET
	street = SPLIT_PART(full_address, ',', 1),
	city = SPLIT_PART(full_address, ',', 2),
	state = SPLIT_PART(full_address, ',', 3),
	postal_code = SPLIT_PART(full_address, ',', 4)
;
```

```sql
ALTER TABLE customers
DROP COLUMN full_address
;
```
[comment]: <> (This is a comment, it will not be included)



