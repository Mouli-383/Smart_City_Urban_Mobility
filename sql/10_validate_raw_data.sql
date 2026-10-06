USE SmartCityMobilityDB;
GO

/* ============================================================
   PHASE 3 - RAW DATA VALIDATION
   ============================================================ */


/* ------------------------------------------------------------
   1. TOTAL RAW RECORDS
------------------------------------------------------------ */

SELECT
    COUNT_BIG(*) AS total_raw_records
FROM raw.yellow_taxi_trips;
GO


/* ------------------------------------------------------------
   2. MONTH-WISE RECORD DISTRIBUTION
------------------------------------------------------------ */

SELECT
    YEAR(pickup_datetime) AS trip_year,
    MONTH(pickup_datetime) AS trip_month,
    COUNT_BIG(*) AS total_trips
FROM raw.yellow_taxi_trips
GROUP BY
    YEAR(pickup_datetime),
    MONTH(pickup_datetime)
ORDER BY
    trip_year,
    trip_month;
GO


/* ------------------------------------------------------------
   3. CHECK CRITICAL NULL VALUES
------------------------------------------------------------ */

SELECT
    SUM(CASE WHEN vendor_id IS NULL THEN 1 ELSE 0 END) AS vendor_id_nulls,

    SUM(CASE WHEN pickup_datetime IS NULL THEN 1 ELSE 0 END) AS pickup_datetime_nulls,

    SUM(CASE WHEN dropoff_datetime IS NULL THEN 1 ELSE 0 END) AS dropoff_datetime_nulls,

    SUM(CASE WHEN pickup_location_id IS NULL THEN 1 ELSE 0 END) AS pickup_location_nulls,

    SUM(CASE WHEN dropoff_location_id IS NULL THEN 1 ELSE 0 END) AS dropoff_location_nulls,

    SUM(CASE WHEN trip_distance IS NULL THEN 1 ELSE 0 END) AS trip_distance_nulls,

    SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END) AS total_amount_nulls,

    SUM(CASE WHEN trip_duration_minutes IS NULL THEN 1 ELSE 0 END) AS trip_duration_nulls

FROM raw.yellow_taxi_trips;
GO


/* ------------------------------------------------------------
   4. CHECK TRIP DURATION ISSUES
------------------------------------------------------------ */

SELECT
    COUNT_BIG(*) AS invalid_duration_records
FROM raw.yellow_taxi_trips
WHERE trip_duration_minutes <= 0;
GO


/* ------------------------------------------------------------
   5. CHECK ZERO DISTANCE RECORDS

   NOTE:
   Zero distance records are NOT automatically deleted.
   They may represent valid taxi trips with unusual conditions.
------------------------------------------------------------ */

SELECT
    COUNT_BIG(*) AS zero_distance_records
FROM raw.yellow_taxi_trips
WHERE trip_distance = 0;
GO


/* ------------------------------------------------------------
   6. CHECK NEGATIVE TOTAL AMOUNTS

   NOTE:
   Negative amounts may represent refunds, adjustments,
   reversals, or corrections.
------------------------------------------------------------ */

SELECT
    COUNT_BIG(*) AS negative_amount_records
FROM raw.yellow_taxi_trips
WHERE total_amount < 0;
GO


/* ------------------------------------------------------------
   7. CHECK ZERO TOTAL AMOUNTS
------------------------------------------------------------ */

SELECT
    COUNT_BIG(*) AS zero_amount_records
FROM raw.yellow_taxi_trips
WHERE total_amount = 0;
GO


/* ------------------------------------------------------------
   8. CHECK DATE RANGE
------------------------------------------------------------ */

SELECT
    MIN(pickup_datetime) AS earliest_pickup_datetime,
    MAX(pickup_datetime) AS latest_pickup_datetime,

    MIN(dropoff_datetime) AS earliest_dropoff_datetime,
    MAX(dropoff_datetime) AS latest_dropoff_datetime

FROM raw.yellow_taxi_trips;
GO


/* ------------------------------------------------------------
   9. CHECK UNEXPECTED MONTHS

   Our intended source data is January through June 2025.
   We DO NOT DELETE unexpected records here.
------------------------------------------------------------ */

SELECT
    MONTH(pickup_datetime) AS trip_month,
    COUNT_BIG(*) AS total_records
FROM raw.yellow_taxi_trips
WHERE
    YEAR(pickup_datetime) <> 2025
    OR MONTH(pickup_datetime) NOT BETWEEN 1 AND 6
GROUP BY
    MONTH(pickup_datetime)
ORDER BY
    trip_month;
GO


/* ------------------------------------------------------------
   10. SAMPLE DATA CHECK
------------------------------------------------------------ */

SELECT TOP 20
    trip_id,
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    pickup_location_id,
    dropoff_location_id,
    payment_type,
    total_amount,
    trip_duration_minutes,
    trip_date,
    pickup_hour
FROM raw.yellow_taxi_trips
ORDER BY trip_id;
GO