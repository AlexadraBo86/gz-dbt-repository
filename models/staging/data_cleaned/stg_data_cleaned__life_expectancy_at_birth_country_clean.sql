with 

source as (

    select * from {{ source('data_cleaned', 'life_expectancy_at_birth_country_clean') }}

),

renamed as (

    select
        country,
        city,
        age

    from source

)

select * from renamed
