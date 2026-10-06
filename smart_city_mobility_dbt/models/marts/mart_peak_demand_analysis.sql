with trips as (

    select *
    from {{ ref('int_trip_metrics') }}

),

peak_demand as (

    select

        trip_date,

        pickup_hour,

        time_of_day_category,

        count(*) as total_trips,

        sum(passenger_count) as total_passengers,

        round(avg(trip_distance), 2) as avg_trip_distance,

        round(avg(trip_duration_minutes), 2) as avg_trip_duration_minutes,

        round(sum(total_amount), 2) as total_revenue,

        round(avg(average_speed_mph), 2) as avg_speed_mph

    from trips

    group by

        trip_date,
        pickup_hour,
        time_of_day_category

)

select *
from peak_demand
order by
    trip_date,
    pickup_hour