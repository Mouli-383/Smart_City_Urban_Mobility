{{ config(
    materialized='view'
) }}

with source_data as (

    /*
        Read data from the RAW Snowflake layer.

        RAW Layer:
        Contains the data loaded into Snowflake after
        previous processing steps.
    */

    select *
    from {{ source('raw_data', 'yellow_taxi_trips') }}

),

cleaned as (

    select

        /* =========================================
           IDENTIFIERS
        ========================================= */

        cast(trip_id as number(38,0)) as trip_id,

        cast(vendor_id as number(38,0)) as vendor_id,


        /* =========================================
           TRIP TIMESTAMPS
        ========================================= */

        cast(pickup_datetime as timestamp_ntz) as pickup_datetime,

        cast(dropoff_datetime as timestamp_ntz) as dropoff_datetime,


        /* =========================================
           PASSENGER AND DISTANCE INFORMATION
        ========================================= */

        cast(passenger_count as number(10,0)) as passenger_count,

        cast(trip_distance as float) as trip_distance,


        /* =========================================
           LOCATION AND RATE INFORMATION
        ========================================= */

        cast(ratecode_id as number(10,0)) as rate_code_id,

        cast(pickup_location_id as number(38,0)) as pickup_location_id,

        cast(dropoff_location_id as number(38,0)) as dropoff_location_id,


        /* =========================================
           PAYMENT INFORMATION
        ========================================= */

        cast(payment_type as number(38,0)) as payment_type,


        /* =========================================
           FINANCIAL INFORMATION
        ========================================= */

        cast(fare_amount as decimal(18,2)) as fare_amount,

        cast(extra as decimal(18,2)) as extra_amount,

        cast(mta_tax as decimal(18,2)) as mta_tax,

        cast(tip_amount as decimal(18,2)) as tip_amount,

        cast(tolls_amount as decimal(18,2)) as tolls_amount,

        cast(improvement_surcharge as decimal(18,2))
            as improvement_surcharge,

        cast(total_amount as decimal(18,2)) as total_amount,

        cast(congestion_surcharge as decimal(18,2))
            as congestion_surcharge,

        cast(airport_fee as decimal(18,2)) as airport_fee,

        cast(cbd_congestion_fee as decimal(18,2))
            as cbd_congestion_fee,


        /* =========================================
           DERIVED TRIP INFORMATION
        ========================================= */

        cast(trip_duration_minutes as decimal(18,2))
            as trip_duration_minutes,

        cast(trip_date as date) as trip_date,

        cast(pickup_hour as number(10,0)) as pickup_hour

    from source_data

),

standardized as (

    select

        /* =========================================
           IDENTIFIERS
        ========================================= */

        trip_id,

        vendor_id,


        /* =========================================
           TIMESTAMPS
        ========================================= */

        pickup_datetime,

        dropoff_datetime,


        /* =========================================
           BASIC NULL HANDLING
        ========================================= */

        coalesce(passenger_count, 0) as passenger_count,

        coalesce(trip_distance, 0) as trip_distance,


        /* =========================================
           LOCATION INFORMATION
        ========================================= */

        rate_code_id,

        pickup_location_id,

        dropoff_location_id,


        /* =========================================
           PAYMENT INFORMATION
        ========================================= */

        payment_type,


        /* =========================================
           FINANCIAL INFORMATION
        ========================================= */

        coalesce(fare_amount, 0) as fare_amount,

        coalesce(extra_amount, 0) as extra_amount,

        coalesce(mta_tax, 0) as mta_tax,

        coalesce(tip_amount, 0) as tip_amount,

        coalesce(tolls_amount, 0) as tolls_amount,

        coalesce(improvement_surcharge, 0)
            as improvement_surcharge,

        coalesce(total_amount, 0) as total_amount,

        coalesce(congestion_surcharge, 0)
            as congestion_surcharge,

        coalesce(airport_fee, 0) as airport_fee,

        coalesce(cbd_congestion_fee, 0)
            as cbd_congestion_fee,


        /* =========================================
           REMOVE OBVIOUS TECHNICAL INCONSISTENCIES

           Negative distance -> NULL
           Negative trip duration -> NULL
        ========================================= */

        case
            when trip_distance >= 0
                then trip_distance
            else null
        end as cleaned_trip_distance,


        case
            when trip_duration_minutes >= 0
                then trip_duration_minutes
            else null
        end as trip_duration_minutes,


        /* =========================================
           ENSURE DATE CONSISTENCY

           If TRIP_DATE is missing,
           derive it from PICKUP_DATETIME.
        ========================================= */

        coalesce(
            trip_date,
            cast(pickup_datetime as date)
        ) as trip_date,


        /* =========================================
           ENSURE HOUR CONSISTENCY

           If PICKUP_HOUR is missing,
           derive it from PICKUP_DATETIME.
        ========================================= */

        coalesce(
            pickup_hour,
            hour(pickup_datetime)
        ) as pickup_hour

    from cleaned

)

select

    /*
        Final clean interface for downstream models
    */

    trip_id,
    vendor_id,

    pickup_datetime,
    dropoff_datetime,

    passenger_count,

    cleaned_trip_distance as trip_distance,

    rate_code_id,
    pickup_location_id,
    dropoff_location_id,

    payment_type,

    fare_amount,
    extra_amount,
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

from standardized