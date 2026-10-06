with trips as (

    select *
    from {{ ref('int_trip_metrics') }}

),

daily_mobility as (

    select

        trip_date,

        count(*) as total_trips,

        count(distinct pickup_location_id) as active_pickup_locations,

        count(distinct dropoff_location_id) as active_dropoff_locations,

        sum(passenger_count) as total_passengers,

        round(avg(trip_distance), 2) as avg_trip_distance,

        round(avg(trip_duration_minutes), 2) as avg_trip_duration_minutes,

        round(avg(average_speed_mph), 2) as avg_trip_speed_mph,

        round(sum(total_amount), 2) as total_revenue,

        round(avg(total_amount), 2) as avg_revenue_per_trip,

        round(sum(tip_amount), 2) as total_tips,

        round(avg(tip_percentage), 2) as avg_tip_percentage

    from trips

    group by trip_date

)

select *
from daily_mobility
order by trip_date