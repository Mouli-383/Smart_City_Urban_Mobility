{{ config(
    materialized='view'
) }}

with source_data as (

    select *
    from {{ source('raw_data', 'locations') }}

),

cleaned as (

    select

        cast(location_id as number(38,0)) as location_id,

        nullif(trim(borough), '') as borough,

        nullif(trim(zone), '') as zone,

        nullif(trim(service_zone), '') as service_zone

    from source_data

)

select *
from cleaned