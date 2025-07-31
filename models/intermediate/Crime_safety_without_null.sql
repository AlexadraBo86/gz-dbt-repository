{{ config(materialized='table') }}

with source as (
    select * 
    from {{ source('Data_cleaned', 'Crime_safety_index_final_table') }}
),

renamed as (
    select
        country,
        city,
        crime_index,
        safety_index
    from source
),

crime_safety as (
    select
        country,
        -- Nettoyage spécifique des noms de villes
        case
            when lower(city) = 'los angeles, california' then 'los angeles'
            when lower(city) = 'new york, new york' then 'new york'
            else lower(city)
        end as city,
        crime_index,
        safety_index
    from renamed
)

select * from crime_safety