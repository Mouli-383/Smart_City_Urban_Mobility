USE SmartCityMobilityDB;
GO

/* ============================================================
   PHASE 3 - RAW TABLE INDEXES
   ============================================================ */


/* ------------------------------------------------------------
   INDEX 1 - PICKUP DATETIME
------------------------------------------------------------ */

CREATE NONCLUSTERED INDEX IX_raw_yellow_taxi_pickup_datetime
ON raw.yellow_taxi_trips (pickup_datetime);
GO


/* ------------------------------------------------------------
   INDEX 2 - TRIP DATE
------------------------------------------------------------ */

CREATE NONCLUSTERED INDEX IX_raw_yellow_taxi_trip_date
ON raw.yellow_taxi_trips (trip_date);
GO


/* ------------------------------------------------------------
   INDEX 3 - PICKUP LOCATION
------------------------------------------------------------ */

CREATE NONCLUSTERED INDEX IX_raw_yellow_taxi_pickup_location
ON raw.yellow_taxi_trips (pickup_location_id);
GO


/* ------------------------------------------------------------
   INDEX 4 - DROPOFF LOCATION
------------------------------------------------------------ */

CREATE NONCLUSTERED INDEX IX_raw_yellow_taxi_dropoff_location
ON raw.yellow_taxi_trips (dropoff_location_id);
GO