with trips as (

    select *
    from {{ ref('stg_yellow_taxi_trips') }}

),

trip_metrics as (

    select

        /* ===============================
           TRIP TIME
        =============================== */

        pickup_datetime,
        dropoff_datetime,
        trip_date,
        pickup_hour,


        /* ===============================
           LOCATION INFORMATION
        =============================== */

        pickup_location_id,
        dropoff_location_id,


        /* ===============================
           TRIP METRICS
        =============================== */

        passenger_count,
        trip_distance,
        trip_duration_minutes,


        /* ===============================
           PAYMENT INFORMATION
        =============================== */

        payment_type,
        rate_code_id,


        /* ===============================
           FINANCIAL METRICS
        =============================== */

        fare_amount,
        extra_amount,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        congestion_surcharge,
        airport_fee,
        cbd_congestion_fee,
        total_amount,


        /* ===============================
           CALCULATED METRICS
        =============================== */

        case

            when trip_duration_minutes > 0
             and trip_distance >= 0

            then round(
                trip_distance / (trip_duration_minutes / 60.0),
                2
            )

            else null

        end as average_speed_mph,


        case

            when fare_amount > 0

            then round(
                (tip_amount / fare_amount) * 100,
                2
            )

            else null

        end as tip_percentage,


        case

            when trip_distance > 0

            then round(
                total_amount / trip_distance,
                2
            )

            else null

        end as revenue_per_mile,


        /* ===============================
           DISTANCE CATEGORY
        =============================== */

        case

            when trip_distance is null then 'UNKNOWN'

            when trip_distance < 1 then 'SHORT'

            when trip_distance < 5 then 'MEDIUM'

            when trip_distance < 15 then 'LONG'

            else 'VERY_LONG'

        end as trip_distance_category,


        /* ===============================
           DURATION CATEGORY
        =============================== */

        case

            when trip_duration_minutes is null then 'UNKNOWN'

            when trip_duration_minutes < 10 then 'QUICK'

            when trip_duration_minutes < 30 then 'NORMAL'

            when trip_duration_minutes < 60 then 'LONG'

            else 'VERY_LONG'

        end as trip_duration_category,


        /* ===============================
           TIME OF DAY CATEGORY
        =============================== */

        case

            when pickup_hour between 0 and 5
                then 'LATE_NIGHT'

            when pickup_hour between 6 and 11
                then 'MORNING'

            when pickup_hour between 12 and 16
                then 'AFTERNOON'

            when pickup_hour between 17 and 20
                then 'EVENING_PEAK'

            when pickup_hour between 21 and 23
                then 'NIGHT'

            else 'UNKNOWN'

        end as time_of_day_category

    from trips

)

select *
from trip_metrics