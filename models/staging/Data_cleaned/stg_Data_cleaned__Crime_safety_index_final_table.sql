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
        CASE
            WHEN LOWER(city) = 'los angeles, california' THEN 'los angeles'
            WHEN LOWER(city) = 'new york, new york' THEN 'new york'
            ELSE LOWER(city)
        END AS city,
        crime_index,
        safety_index
    from renamed
)

select * from crime_safety
