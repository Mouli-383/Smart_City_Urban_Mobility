USE SmartCityMobilityDB;
GO

IF OBJECT_ID('raw.stg_yellow_taxi_trips', 'U') IS NOT NULL
    DROP TABLE raw.stg_yellow_taxi_trips;
GO

CREATE TABLE raw.stg_yellow_taxi_trips (
    VendorID INT,
    tpep_pickup_datetime DATETIME2,
    tpep_dropoff_datetime DATETIME2,
    passenger_count FLOAT,
    trip_distance FLOAT,
    RatecodeID FLOAT,
    PULocationID INT,
    DOLocationID INT,
    payment_type INT,
    fare_amount FLOAT,
    extra FLOAT,
    mta_tax FLOAT,
    tip_amount FLOAT,
    tolls_amount FLOAT,
    improvement_surcharge FLOAT,
    total_amount FLOAT,
    congestion_surcharge FLOAT,
    Airport_fee FLOAT,
    cbd_congestion_fee FLOAT,
    trip_duration_minutes FLOAT,
    trip_date DATE,
    pickup_hour INT
);
GO