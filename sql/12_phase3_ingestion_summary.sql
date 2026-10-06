USE SmartCityMobilityDB;
GO

/* ============================================================
   PHASE 3 - FINAL INGESTION SUMMARY
   ============================================================ */


/* ------------------------------------------------------------
   OVERALL SUMMARY
------------------------------------------------------------ */

SELECT
    COUNT_BIG(*) AS total_trips,
    MIN(pickup_datetime) AS earliest_trip,
    MAX(pickup_datetime) AS latest_trip,

    COUNT(DISTINCT trip_date) AS total_trip_days,

    COUNT(DISTINCT pickup_location_id) AS unique_pickup_locations,

    COUNT(DISTINCT dropoff_location_id) AS unique_dropoff_locations

FROM raw.yellow_taxi_trips;
GO


/* ------------------------------------------------------------
   MONTH-WISE SUMMARY
------------------------------------------------------------ */

SELECT
    YEAR(pickup_datetime) AS trip_year,

    MONTH(pickup_datetime) AS trip_month,

    COUNT_BIG(*) AS total_trips,

    CAST(
        AVG(trip_distance)
        AS DECIMAL(12,2)
    ) AS average_trip_distance,

    CAST(
        AVG(trip_duration_minutes)
        AS DECIMAL(12,2)
    ) AS average_trip_duration_minutes,

    CAST(
        AVG(total_amount)
        AS DECIMAL(12,2)
    ) AS average_trip_amount

FROM raw.yellow_taxi_trips

GROUP BY
    YEAR(pickup_datetime),
    MONTH(pickup_datetime)

ORDER BY
    trip_year,
    trip_month;
GO


/* ------------------------------------------------------------
   DATA QUALITY SUMMARY
------------------------------------------------------------ */

SELECT

    COUNT_BIG(*) AS total_records,

    SUM(
        CASE
            WHEN trip_distance = 0 THEN 1
            ELSE 0
        END
    ) AS zero_distance_records,

    SUM(
        CASE
            WHEN total_amount < 0 THEN 1
            ELSE 0
        END
    ) AS negative_amount_records,

    SUM(
        CASE
            WHEN total_amount = 0 THEN 1
            ELSE 0
        END
    ) AS zero_amount_records,

    SUM(
        CASE
            WHEN trip_duration_minutes <= 0 THEN 1
            ELSE 0
        END
    ) AS invalid_duration_records,

    SUM(
        CASE
            WHEN pickup_datetime IS NULL
              OR dropoff_datetime IS NULL
            THEN 1
            ELSE 0
        END
    ) AS datetime_null_records

FROM raw.yellow_taxi_trips;
GO


/* ------------------------------------------------------------
   FINAL PHASE 3 STATUS
------------------------------------------------------------ */

SELECT
    'PHASE 3 COMPLETED SUCCESSFULLY' AS phase_status,
    COUNT_BIG(*) AS total_raw_records,
    SYSDATETIME() AS completion_timestamp
FROM raw.yellow_taxi_trips;
GO