USE SmartCityMobilityDB;
GO

TRUNCATE TABLE raw.stg_yellow_taxi_trips;
GO

BULK INSERT raw.stg_yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-01.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

SELECT COUNT(*) AS staging_records
FROM raw.stg_yellow_taxi_trips;
GO