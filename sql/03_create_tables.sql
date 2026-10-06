USE SmartCityMobilityDB;
GO

-- Drop tables if they already exist

IF OBJECT_ID('raw.ingestion_log', 'U') IS NOT NULL
    DROP TABLE raw.ingestion_log;
GO

IF OBJECT_ID('raw.yellow_taxi_trips', 'U') IS NOT NULL
    DROP TABLE raw.yellow_taxi_trips;
GO


-- Main transportation trips table

CREATE TABLE raw.yellow_taxi_trips (

    trip_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    vendor_id INT,

    pickup_datetime DATETIME2,

    dropoff_datetime DATETIME2,

    passenger_count FLOAT,

    trip_distance FLOAT,

    ratecode_id FLOAT,

    pickup_location_id INT,

    dropoff_location_id INT,

    payment_type INT,

    fare_amount FLOAT,

    extra FLOAT,

    mta_tax FLOAT,

    tip_amount FLOAT,

    tolls_amount FLOAT,

    improvement_surcharge FLOAT,

    total_amount FLOAT,

    congestion_surcharge FLOAT,

    airport_fee FLOAT,

    cbd_congestion_fee FLOAT,

    trip_duration_minutes FLOAT,

    trip_date DATE,

    pickup_hour INT
);
GO


-- Ingestion log table

CREATE TABLE raw.ingestion_log (

    ingestion_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    source_file VARCHAR(255) NOT NULL,

    load_start_time DATETIME2 NOT NULL,

    load_end_time DATETIME2 NULL,

    records_loaded BIGINT,

    load_status VARCHAR(50) NOT NULL,

    error_message VARCHAR(1000) NULL
);
GO


CREATE TABLE dbo.LOCATIONS (
    
    LOCATION_ID INT NOT NULL PRIMARY KEY,
    
    BOROUGH VARCHAR(100) NULL,
    
    ZONE VARCHAR(255) NULL,
    
    SERVICE_ZONE VARCHAR(100) NULL

);