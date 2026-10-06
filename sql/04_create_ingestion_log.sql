USE SmartCityMobilityDB;
GO

CREATE TABLE raw.ingestion_log (

    ingestion_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    source_file VARCHAR(255),

    load_start_time DATETIME2,

    load_end_time DATETIME2,

    records_loaded BIGINT,

    load_status VARCHAR(50),

    error_message VARCHAR(1000)
);
GO