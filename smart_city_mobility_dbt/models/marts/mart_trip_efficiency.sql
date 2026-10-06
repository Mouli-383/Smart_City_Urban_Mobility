with trips as (

    select *
    from {{ ref('int_trip_metrics') }}

),

trip_efficiency as (

    select

        trip_distance_category,

        trip_duration_category,

        time_of_day_category,

        count(*) as total_trips,

        round(avg(trip_distance), 2) as avg_trip_distance,

        round(avg(trip_duration_minutes), 2) as avg_trip_duration_minutes,

        round(avg(average_speed_mph), 2) as avg_speed_mph,

        round(avg(revenue_per_mile), 2) as avg_revenue_per_mile,

        round(avg(total_amount), 2) as avg_trip_revenue

    from trips

    group by

        trip_distance_category,
        trip_duration_category,
        time_of_day_category

)

select *
from trip_efficiency
order by total_trips desc