USE SmartCityMobilityDB;
GO


-- 1. Total records

SELECT
    COUNT(*) AS total_trip_records
FROM raw.yellow_taxi_trips;
GO


-- 2. Monthly record counts

SELECT
    YEAR(pickup_datetime) AS trip_year,
    MONTH(pickup_datetime) AS trip_month,
    COUNT(*) AS total_trips
FROM raw.yellow_taxi_trips
GROUP BY
    YEAR(pickup_datetime),
    MONTH(pickup_datetime)
ORDER BY
    trip_year,
    trip_month;
GO


-- 3. Ingestion logs

SELECT *
FROM raw.ingestion_log
ORDER BY ingestion_id;
GO


-- 4. Missing critical values

SELECT

    SUM(CASE WHEN pickup_datetime IS NULL THEN 1 ELSE 0 END)
        AS missing_pickup_datetime,

    SUM(CASE WHEN dropoff_datetime IS NULL THEN 1 ELSE 0 END)
        AS missing_dropoff_datetime,

    SUM(CASE WHEN pickup_location_id IS NULL THEN 1 ELSE 0 END)
        AS missing_pickup_location,

    SUM(CASE WHEN dropoff_location_id IS NULL THEN 1 ELSE 0 END)
        AS missing_dropoff_location

FROM raw.yellow_taxi_trips;
GO


-- 5. Invalid timestamp records

SELECT
    COUNT(*) AS invalid_timestamp_records
FROM raw.yellow_taxi_trips
WHERE dropoff_datetime <= pickup_datetime;
GO


-- 6. Invalid duration records

SELECT
    COUNT(*) AS invalid_duration_records
FROM raw.yellow_taxi_trips
WHERE trip_duration_minutes <= 0;
GO


-- 7. Date range

SELECT

    MIN(pickup_datetime) AS first_trip,

    MAX(pickup_datetime) AS last_trip,

    MIN(trip_date) AS first_trip_date,

    MAX(trip_date) AS last_trip_date

FROM raw.yellow_taxi_trips;
GO