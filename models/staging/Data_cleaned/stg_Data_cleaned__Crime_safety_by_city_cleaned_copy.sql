with 

source as (

    select * from {{ source('Data_cleaned', 'Crime_safety_by_city_cleaned_copy') }}

),

renamed as (

    select
        city,
        crime_index,
        safety_index

    from source

)

select * from renamed
