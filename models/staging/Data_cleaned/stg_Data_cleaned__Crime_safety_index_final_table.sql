with source as (

    select * from {{ source('Data_cleaned', 'Crime_safety_index_final_table') }}

),

renamed as (

    select
        city,
        country,
        crime_index,
        safety_index

    from source

)

select * from renamed