with location_activity as (

    select *
    from {{ ref('int_location_activity') }}

),

location_demand as (

    select

        location_id,

        borough,

        zone,

        service_zone,

        total_pickups,

        total_dropoffs,

        total_location_activity,

        round(pickup_revenue, 2) as pickup_revenue,

        avg_pickup_trip_distance,

        case

            when total_location_activity >= 100000
                then 'VERY_HIGH_DEMAND'

            when total_location_activity >= 50000
                then 'HIGH_DEMAND'

            when total_location_activity >= 10000
                then 'MEDIUM_DEMAND'

            when total_location_activity > 0
                then 'LOW_DEMAND'

            else 'NO_ACTIVITY'

        end as demand_category

    from location_activity

)

select *
from location_demand
order by total_location_activity desc