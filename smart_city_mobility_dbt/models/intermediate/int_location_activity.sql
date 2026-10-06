with trips as (

    select *
    from {{ ref('int_trip_metrics') }}

),

locations as (

    select *
    from {{ ref('stg_locations') }}

),

/* =========================================
   PICKUP ACTIVITY
========================================= */

pickup_activity as (

    select

        pickup_location_id as location_id,

        count(*) as total_pickups,

        sum(total_amount) as pickup_revenue,

        avg(trip_distance) as avg_pickup_trip_distance

    from trips

    where pickup_location_id is not null

    group by pickup_location_id

),


/* =========================================
   DROPOFF ACTIVITY
========================================= */

dropoff_activity as (

    select

        dropoff_location_id as location_id,

        count(*) as total_dropoffs

    from trips

    where dropoff_location_id is not null

    group by dropoff_location_id

),


/* =========================================
   COMBINE LOCATION DATA + ACTIVITY
========================================= */

location_activity as (

    select

        /* Location Information */

        l.location_id,

        l.borough,

        l.zone,

        l.service_zone,


        /* Pickup Metrics */

        coalesce(p.total_pickups, 0)
            as total_pickups,

        coalesce(p.pickup_revenue, 0)
            as pickup_revenue,

        round(
            p.avg_pickup_trip_distance,
            2
        ) as avg_pickup_trip_distance,


        /* Dropoff Metrics */

        coalesce(d.total_dropoffs, 0)
            as total_dropoffs,


        /* Total Mobility Activity */

        coalesce(p.total_pickups, 0)
        +
        coalesce(d.total_dropoffs, 0)

        as total_location_activity


    from locations l

    left join pickup_activity p

        on l.location_id = p.location_id


    left join dropoff_activity d

        on l.location_id = d.location_id

)

select *
from location_activity