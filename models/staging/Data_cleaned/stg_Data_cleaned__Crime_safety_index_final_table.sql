with 

source as (

    select * from {{ ref('stg_Data_cleaned__Crime_safety_index_final_table') }}

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
