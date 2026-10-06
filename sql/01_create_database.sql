SELECT @@SERVERNAME AS server_name;

SELECT @@VERSION AS sql_server_version;

USE master;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'SmartCityMobilityDB'
)
BEGIN
    CREATE DATABASE SmartCityMobilityDB;
END;
GO

USE SmartCityMobilityDB;
GO