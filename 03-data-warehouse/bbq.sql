-- Set up
CREATE OR REPLACE TABLE `solid-acrobat-440004-g5.ny_taxi.mv_yellow_tripdata` AS (
  SELECT *
  FROM `solid-acrobat-440004-g5.ny_taxi.yellow_tripdata`
)

-- Q1
SELECT COUNT(*) FROM `solid-acrobat-440004-g5.ny_taxi.yellow_tripdata`;

-- Q2
SELECT COUNT(DISTINCT PULocationID) FROM `solid-acrobat-440004-g5.ny_taxi.yellow_tripdata`;
SELECT COUNT(DISTINCT PULocationID) FROM `solid-acrobat-440004-g5.ny_taxi.mv_yellow_tripdata`;

-- Q4
SELECT
  COUNT(*)
FROM
  ny_taxi.mv_yellow_tripdata
WHERE
  fare_amount = 0;

-- Q5
CREATE OR REPLACE TABLE ny_taxi.yellow_tripdata_partitioned_clustered
    PARTITION BY DATE(tpep_dropoff_datetime)
    CLUSTER BY VendorID
AS
    SELECT *
    FROM ny_taxi.yellow_tripdata;

-- Q6
SELECT
  DISTINCT VendorID
FROM
  `ny_taxi.yellow_tripdata_partitioned_clustered`
WHERE
  DATE(tpep_dropoff_datetime) BETWEEN DATE('2024-03-01') AND DATE('2024-03-15');