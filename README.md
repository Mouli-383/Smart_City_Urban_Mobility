# Smart City Urban Mobility Intelligence Platform

1. PROJECT OVERVIEW

The Smart City Urban Mobility Intelligence Platform is a data engineering and analytics project built to analyze urban taxi transportation data and generate useful mobility, demand, revenue, passenger, and trip-efficiency insights.

The project uses NYC TLC Yellow Taxi Trip Records from January to June 2025. The raw transportation data is processed using Python, loaded into SQL Server for operational storage and validation, and then loaded into Snowflake for cloud-based analytical processing.

dbt is used to transform the raw transportation data into structured analytical models and business-oriented data marts.

The main objective of the project is to transform large-scale raw taxi trip data into reliable and structured datasets that can be used to understand:

- Transportation demand
- Pickup and drop-off patterns
- Peak travel periods
- Revenue and passenger behavior
- Trip efficiency
- Location-level demand
- Urban mobility patterns


2. DATASET INFORMATION

Dataset:
NYC TLC Yellow Taxi Trip Records

Time Period:
January 2025 to June 2025

Source Data Format:
Parquet

The dataset contains individual taxi trip records with information related to:

- Vendor
- Pickup and drop-off timestamps
- Passenger count
- Trip distance
- Rate code
- Pickup location
- Drop-off location
- Payment type
- Fare amount
- Additional charges
- Tip amount
- Tolls
- Total amount
- Trip duration
- Trip date
- Pickup hour

The processed dataset is used as the primary source for the SQL Server and Snowflake data pipeline.


3. TECHNOLOGIES USED

Programming and Data Processing:
- Python
- Pandas

Database:
- Microsoft SQL Server

Cloud Data Warehouse:
- Snowflake

Transformation:
- dbt

Data Formats:
- Parquet
- CSV

Version Control:
- Git

Note:
Apache Airflow, PySpark, and Tableau were not used as part of this Smart City project implementation.


4. PROJECT ARCHITECTURE

The overall architecture follows a layered data engineering pipeline.

Source Transportation Dataset
        |
        v
Python Data Processing
        |
        v
Processed Parquet Files
        |
        v
SQL Server Raw Operational Layer
        |
        v
CSV Conversion / Data Preparation
        |
        v
Snowflake RAW Layer
        |
        v
Snowflake STAGING Layer
        |
        v
dbt Transformations
        |
        v
Analytical Models / Data Marts
        |
        v
Mobility Analytics and Reporting


5. PROJECT STRUCTURE

The project is organized into separate layers for data processing, database operations, and analytics.

Typical project components include:

- Data files
- Python processing scripts
- SQL Server scripts
- Snowflake SQL scripts
- dbt project
- Validation queries
- Analytical models
- Documentation

The project structure separates ingestion, processing, validation, storage, transformation, and analytics responsibilities.


6. DATA PROFILING

The initial dataset was profiled before loading it into the analytical environment.

The profiling process focused on identifying:

- Number of records
- Column names
- Data types
- Missing values
- Duplicate records
- Invalid trip distances
- Invalid financial values
- Invalid timestamps
- Passenger count distribution
- Payment type distribution
- Trip duration statistics
- Financial statistics
- Location validity

The profiling helped identify data quality issues before the data was used for analytical processing.


7. PYTHON DATA INGESTION

Python was used as the first processing layer of the project.

The raw NYC Yellow Taxi Parquet files were read using Python and Pandas.

The ingestion process included:

- Reading Parquet files
- Inspecting dataset structure
- Checking data types
- Combining required data
- Preparing the dataset for further processing
- Saving processed data in Parquet format

The processed files were then used for downstream SQL Server ingestion.


8. PYTHON DATA PROCESSING

Python was used to clean and prepare the transportation data before database ingestion.

The processing activities included:

- Handling missing values
- Identifying invalid records
- Checking trip distance
- Checking financial amounts
- Processing pickup and drop-off timestamps
- Calculating trip duration
- Creating trip date
- Creating pickup hour
- Preparing structured records
- Saving the processed dataset

Feature engineering was performed to create useful analytical attributes such as:

- TRIP_DURATION_MINUTES
- TRIP_DATE
- PICKUP_HOUR

These attributes were later used for mobility and demand analysis.


9. DATA VALIDATION

Data validation was performed before and after loading the data into the database environment.

Important validation checks included:

- Total row count
- Duplicate TRIP_ID values
- NULL values
- Date range validation
- Monthly record distribution
- Invalid pickup timestamps
- Invalid drop-off timestamps
- Zero or negative trip distance
- Passenger count distribution
- Negative financial values
- Payment type distribution
- Trip distance statistics
- Trip duration statistics
- Zero or negative trip duration
- Financial summaries
- Pickup location validity
- Drop-off location validity

These checks helped ensure that the data used for analytics was structurally and logically valid.


10. SQL SERVER LAYER

Microsoft SQL Server was used as the operational/raw database layer.

The processed transportation data was loaded into SQL Server before being prepared for Snowflake.

The SQL Server layer was used for:

- Data storage
- Initial database validation
- Record-level checks
- Data quality analysis
- SQL-based exploration
- Preparing data for cloud data warehouse ingestion

The SQL Server layer acted as an intermediate storage and validation layer between Python processing and Snowflake.


11. SNOWFLAKE DATA WAREHOUSE

Snowflake was used as the cloud data warehouse for analytical processing.

Database:

SMART_CITY_MOBILITY_DB

The project uses separate schemas for organizing the data:

- RAW
- STAGING
- ANALYTICS

The RAW layer contains the data loaded from the prepared CSV files.

The STAGING layer is used for cleaned and structured transformation logic.

The ANALYTICS layer contains business-oriented analytical outputs.

Snowflake Warehouse:

The project uses a Snowflake virtual warehouse for executing data loading, transformation, validation, and analytical queries.


12. SNOWFLAKE DATA INGESTION

The processed CSV files were uploaded to a Snowflake internal stage.

Internal Stage:

TAXI_RAW_STAGE

File Format:

TAXI_CSV_FORMAT

The CSV file format was configured for:

- Comma-separated values
- Header skipping
- Optional quotation
- NULL handling

The raw transportation data was loaded using COPY INTO.

The loading process follows:

CSV Files
    |
    v
TAXI_RAW_STAGE
    |
    v
COPY INTO
    |
    v
RAW.YELLOW_TAXI_TRIPS


13. SNOWFLAKE RAW DATA MODEL

The main raw transportation table is:

RAW.YELLOW_TAXI_TRIPS

Important columns include:

- TRIP_ID
- VENDOR_ID
- PICKUP_DATETIME
- DROPOFF_DATETIME
- PASSENGER_COUNT
- TRIP_DISTANCE
- RATECODE_ID
- PICKUP_LOCATION_ID
- DROPOFF_LOCATION_ID
- PAYMENT_TYPE
- FARE_AMOUNT
- EXTRA
- MTA_TAX
- TIP_AMOUNT
- TOLLS_AMOUNT
- IMPROVEMENT_SURCHARGE
- TOTAL_AMOUNT
- CONGESTION_SURCHARGE
- AIRPORT_FEE
- CBD_CONGESTION_FEE
- TRIP_DURATION_MINUTES
- TRIP_DATE
- PICKUP_HOUR

A separate location table was also created:

RAW.LOCATIONS

Important location attributes include:

- LOCATION_ID
- BOROUGH
- ZONE
- SERVICE_ZONE


14. SNOWFLAKE DATA VALIDATION

After loading the data into Snowflake, additional validation queries were executed.

The validation included:

- Row count verification
- Duplicate trip detection
- NULL checks
- Date range checks
- Monthly distribution checks
- Invalid datetime checks
- Invalid trip distance checks
- Passenger count checks
- Negative financial value checks
- Payment type analysis
- Trip distance statistics
- Trip duration statistics
- Financial summaries
- Location ID validation

This ensured that the Snowflake RAW layer contained usable transportation data before transformation.


15. DBT TRANSFORMATION

dbt was used as the transformation layer for converting raw transportation data into structured analytical models.

The transformation process separates raw data from analytical logic.

The dbt workflow includes:

RAW DATA
    |
    v
STAGING MODELS
    |
    v
INTERMEDIATE TRANSFORMATIONS
    |
    v
ANALYTICAL DATA MARTS

dbt provides a structured way to organize SQL transformations and create reusable analytical models.


16. MOBILITY OVERVIEW ANALYSIS

The project includes a city-level mobility overview mart:

MART_CITY_MOBILITY_OVERVIEW

This mart provides a high-level view of the transportation system.

It can be used to analyze metrics such as:

- Total trips
- Total passengers
- Total distance
- Total revenue
- Average trip distance
- Average trip duration
- Overall transportation activity

This provides a summarized view of the overall taxi mobility system.


17. LOCATION DEMAND ANALYSIS

The project includes:

MART_LOCATION_DEMAND

This analytical mart focuses on location-level transportation demand.

It can be used to understand:

- Pickup demand
- Drop-off demand
- Location activity
- Borough-level activity
- Zone-level demand
- High-demand transportation areas

The mart helps identify areas with higher taxi activity and supports urban mobility analysis.


18. PEAK DEMAND ANALYSIS

The project includes:

MART_PEAK_DEMAND_ANALYSIS

This mart analyzes transportation demand across time.

The analysis can be performed using attributes such as:

- Pickup date
- Pickup hour
- Trip count
- Passenger count

The objective is to identify periods with higher transportation activity.

This helps understand peak travel periods and daily mobility patterns.


19. REVENUE AND PASSENGER ANALYSIS

The project includes:

MART_REVENUE_PASSENGER_ANALYSIS

This mart focuses on the relationship between transportation activity, passengers, and revenue.

It can be used to analyze:

- Total revenue
- Fare revenue
- Tip amount
- Passenger volume
- Average fare
- Revenue patterns
- Payment behavior

This provides a business-oriented view of the transportation dataset.


20. TRIP EFFICIENCY ANALYSIS

The project includes:

MART_TRIP_EFFICIENCY

This mart focuses on understanding trip-level operational efficiency.

Important analytical metrics include:

- Trip distance
- Trip duration
- Average speed-related indicators
- Trip count
- Financial metrics
- Passenger-related metrics

The objective is to identify patterns in trip performance and transportation efficiency.


21. ANALYTICAL DATA MARTS

The major analytical marts created in the project are:

1. MART_CITY_MOBILITY_OVERVIEW

Provides overall city-level transportation metrics.

2. MART_LOCATION_DEMAND

Provides location-level demand and activity analysis.

3. MART_PEAK_DEMAND_ANALYSIS

Provides time-based transportation demand analysis.

4. MART_REVENUE_PASSENGER_ANALYSIS

Provides revenue and passenger behavior analysis.

5. MART_TRIP_EFFICIENCY

Provides trip-level efficiency analysis.

These marts convert the raw transportation data into business-friendly analytical datasets.


22. FINAL DATA FLOW AND PROJECT OUTCOME

FINAL DATA FLOW:

NYC TLC Yellow Taxi Parquet Files
        |
        v
Python + Pandas
        |
        v
Data Cleaning + Feature Engineering
        |
        v
Processed Parquet Files
        |
        v
SQL Server
        |
        v
Validation + Data Quality Checks
        |
        v
CSV Preparation
        |
        v
Snowflake Internal Stage
        |
        v
RAW.YELLOW_TAXI_TRIPS
        |
        v
STAGING Layer
        |
        v
dbt Transformations
        |
        v
Analytical Data Marts
        |
        v
Mobility Analytics

PROJECT OUTCOME:

The Smart City Urban Mobility Intelligence Platform demonstrates an end-to-end data engineering workflow for transforming large-scale transportation data into structured analytical datasets.

The project covers:

- Data ingestion using Python
- Data processing using Pandas
- Data quality validation
- SQL Server-based data storage
- Snowflake cloud data warehousing
- RAW and STAGING data layers
- dbt-based SQL transformations
- Analytical data mart creation
- Urban mobility demand analysis
- Location-level analysis
- Peak demand analysis
- Revenue and passenger analysis
- Trip efficiency analysis

The final result is a structured transportation analytics platform that converts raw NYC taxi trip records into reliable datasets for understanding urban mobility patterns and transportation operations.
