USE SmartCityMobilityDB;
GO


/* =========================================================
   FEBRUARY 2025
   ========================================================= */

TRUNCATE TABLE raw.stg_yellow_taxi_trips;
GO

BULK INSERT raw.stg_yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-02.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

SELECT COUNT(*) AS february_staging_records
FROM raw.stg_yellow_taxi_trips;
GO

INSERT INTO raw.yellow_taxi_trips (
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    ratecode_id,
    pickup_location_id,
    dropoff_location_id,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    airport_fee,
    cbd_congestion_fee,
    trip_duration_minutes,
    trip_date,
    pickup_hour
)
SELECT
    VendorID,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    RatecodeID,
    PULocationID,
    DOLocationID,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    Airport_fee,
    cbd_congestion_fee,
    trip_duration_minutes,
    trip_date,
    pickup_hour
FROM raw.stg_yellow_taxi_trips;
GO


/* =========================================================
   MARCH 2025
   ========================================================= */

TRUNCATE TABLE raw.stg_yellow_taxi_trips;
GO

BULK INSERT raw.stg_yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-03.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

SELECT COUNT(*) AS march_staging_records
FROM raw.stg_yellow_taxi_trips;
GO

INSERT INTO raw.yellow_taxi_trips (
    vendor_id, pickup_datetime, dropoff_datetime, passenger_count,
    trip_distance, ratecode_id, pickup_location_id, dropoff_location_id,
    payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount,
    improvement_surcharge, total_amount, congestion_surcharge, airport_fee,
    cbd_congestion_fee, trip_duration_minutes, trip_date, pickup_hour
)
SELECT
    VendorID, tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count,
    trip_distance, RatecodeID, PULocationID, DOLocationID,
    payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount,
    improvement_surcharge, total_amount, congestion_surcharge, Airport_fee,
    cbd_congestion_fee, trip_duration_minutes, trip_date, pickup_hour
FROM raw.stg_yellow_taxi_trips;
GO


/* =========================================================
   APRIL 2025
   ========================================================= */

TRUNCATE TABLE raw.stg_yellow_taxi_trips;
GO

BULK INSERT raw.stg_yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-04.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

SELECT COUNT(*) AS april_staging_records
FROM raw.stg_yellow_taxi_trips;
GO

INSERT INTO raw.yellow_taxi_trips (
    vendor_id, pickup_datetime, dropoff_datetime, passenger_count,
    trip_distance, ratecode_id, pickup_location_id, dropoff_location_id,
    payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount,
    improvement_surcharge, total_amount, congestion_surcharge, airport_fee,
    cbd_congestion_fee, trip_duration_minutes, trip_date, pickup_hour
)
SELECT
    VendorID, tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count,
    trip_distance, RatecodeID, PULocationID, DOLocationID,
    payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount,
    improvement_surcharge, total_amount, congestion_surcharge, Airport_fee,
    cbd_congestion_fee, trip_duration_minutes, trip_date, pickup_hour
FROM raw.stg_yellow_taxi_trips;
GO


/* =========================================================
   MAY 2025
   ========================================================= */

TRUNCATE TABLE raw.stg_yellow_taxi_trips;
GO

BULK INSERT raw.stg_yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-05.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

SELECT COUNT(*) AS may_staging_records
FROM raw.stg_yellow_taxi_trips;
GO

INSERT INTO raw.yellow_taxi_trips (
    vendor_id, pickup_datetime, dropoff_datetime, passenger_count,
    trip_distance, ratecode_id, pickup_location_id, dropoff_location_id,
    payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount,
    improvement_surcharge, total_amount, congestion_surcharge, airport_fee,
    cbd_congestion_fee, trip_duration_minutes, trip_date, pickup_hour
)
SELECT
    VendorID, tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count,
    trip_distance, RatecodeID, PULocationID, DOLocationID,
    payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount,
    improvement_surcharge, total_amount, congestion_surcharge, Airport_fee,
    cbd_congestion_fee, trip_duration_minutes, trip_date, pickup_hour
FROM raw.stg_yellow_taxi_trips;
GO


/* =========================================================
   JUNE 2025
   ========================================================= */

TRUNCATE TABLE raw.stg_yellow_taxi_trips;
GO

BULK INSERT raw.stg_yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-06.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


SELECT COUNT(*) AS june_staging_records
FROM raw.stg_yellow_taxi_trips;
GO

INSERT INTO raw.yellow_taxi_trips (
    vendor_id, pickup_datetime, dropoff_datetime, passenger_count,
    trip_distance, ratecode_id, pickup_location_id, dropoff_location_id,
    payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount,
    improvement_surcharge, total_amount, congestion_surcharge, airport_fee,
    cbd_congestion_fee, trip_duration_minutes, trip_date, pickup_hour
)
SELECT
    VendorID, tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count,
    trip_distance, RatecodeID, PULocationID, DOLocationID,
    payment_type, fare_amount, extra, mta_tax, tip_amount, tolls_amount,
    improvement_surcharge, total_amount, congestion_surcharge, Airport_fee,
    cbd_congestion_fee, trip_duration_minutes, trip_date, pickup_hour
FROM raw.stg_yellow_taxi_trips;
GO


/* =========================================================
   FINAL VALIDATION
   ========================================================= */

SELECT COUNT(*) AS total_raw_records
FROM raw.yellow_taxi_trips;
GO

SELECT
    MONTH(trip_date) AS month_number,
    COUNT(*) AS total_trips
FROM raw.yellow_taxi_trips
GROUP BY MONTH(trip_date)
ORDER BY month_number;
GO