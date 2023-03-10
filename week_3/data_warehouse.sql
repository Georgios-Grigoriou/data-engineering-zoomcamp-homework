**Code**

**Create an external table using the fhv 2019 data.**

-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `braided-case-375422.dezoomcamp.fhv_trip_data`
OPTIONS (
 format = 'CSV',
 uris = ['gs://prefect-de-zoomcampgg/data/fhv/fhv_tripdata_2019-*.csv.gz']
);

**Create a table in BQ using the fhv 2019 data (do not partition or cluster this table).** 
CREATE OR REPLACE TABLE `braided-case-375422.dezoomcamp.fhv_nonpartitioned_trip_data`
AS SELECT * FROM `braided-case-375422.dezoomcamp.fhv_trip_data`;

Question 1

-- Count of fhv trips
SELECT count(*)
FROM `<project id>.dezoomcamp.fhv_trip_data`
WHERE DATE(pickup_datetime) BETWEEN "2019-01-01" AND "2019-12-31";

Or

-- Count of fhv trips
SELECT count(*) FROM `<project id>.dezoomcamp.fhv_nonpartitioned_trip_data`;

Question 2

SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `<project id>.dezoomcamp.fhv_trip_data`;

SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `<project id>.dezoomcamp.fhv_nonpartitioned_trip_data`;


Question 3 

SELECT count(1) FROM `<project id>.dezoomcamp.fhv_nonpartitioned_trip_data`
WHERE PUlocationID is NULL and DOlocationID is NULL;

Question 5 SQL

-- Create partition table
CREATE OR REPLACE TABLE `<project id>.dezoomcamp.fhv_partitioned_trip_data_2019`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY Affiliated_base_number
AS SELECT * FROM `braided-case-375422.dezoomcamp.fhv_trip_data`;

-- WITH partitioning on pickup_datetime and clustering on Affiliated_base_number
SELECT DISTINCT Affiliated_base_number,  FROM `<project id>.dezoomcamp.fhv_nonpartitioned_trip_data`
WHERE DATE(pickup_datetime) BETWEEN '2019-03-01' AND '2019-03-31';

-- WITH partitioning on pickup_datetime and clustering on Affiliated_base_number
SELECT DISTINCT Affiliated_base_number,  FROM `<project id>.dezoomcamp.fhv_nonpartitioned_trip_data`
WHERE DATE(pickup_datetime) BETWEEN '2019-03-01' AND '2019-03-31';
