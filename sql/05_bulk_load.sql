USE SmartCityMobilityDB;
GO

-- Start fresh

TRUNCATE TABLE raw.yellow_taxi_trips;

DELETE FROM raw.ingestion_log;
GO


-- ============================================================
-- JANUARY 2025
-- ============================================================

BULK INSERT raw.yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-01.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- FEBRUARY 2025
-- ============================================================

BULK INSERT raw.yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-02.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- MARCH 2025
-- ============================================================

BULK INSERT raw.yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-03.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- APRIL 2025
-- ============================================================

BULK INSERT raw.yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-04.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- MAY 2025
-- ============================================================

BULK INSERT raw.yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-05.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- JUNE 2025
-- ============================================================

BULK INSERT raw.yellow_taxi_trips
FROM 'C:\Users\ACIAGO\Desktop\Smart_City_Urban_Mobility_Intelligence\data\sql_load\yellow_tripdata_2025-06.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO









USE SmartCityMobilityDB;
GO

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'raw'
  AND TABLE_NAME = 'yellow_taxi_trips'
ORDER BY ORDINAL_POSITION;
GO