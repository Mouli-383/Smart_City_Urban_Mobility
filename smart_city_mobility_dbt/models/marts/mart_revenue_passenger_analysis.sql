with trips as (

    select *
    from {{ ref('int_trip_metrics') }}

),

revenue_passenger_analysis as (

    select

        passenger_count,

        payment_type,

        count(*) as total_trips,

        round(sum(total_amount), 2) as total_revenue,

        round(avg(total_amount), 2) as avg_revenue_per_trip,

        round(sum(tip_amount), 2) as total_tips,

        round(avg(tip_percentage), 2) as avg_tip_percentage,

        round(avg(trip_distance), 2) as avg_trip_distance,

        round(avg(trip_duration_minutes), 2) as avg_trip_duration_minutes,

        round(avg(revenue_per_mile), 2) as avg_revenue_per_mile

    from trips

    group by

        passenger_count,
        payment_type

)

select *
from revenue_passenger_analysis
order by total_revenue desc