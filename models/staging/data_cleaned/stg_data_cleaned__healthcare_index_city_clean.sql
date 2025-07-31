with 

source as (

    select * from {{ source('data_cleaned', 'healthcare_index_city_clean') }}

),

renamed as (

    select
        country,
        city,
        health_care_index,
        health_care_exp__index

    from source

)

select * from renamed
