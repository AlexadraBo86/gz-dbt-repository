with 

source as (

    select * from {{ source('Data_cleaned', 'Life_expectancy_at_birth_by_country_cleaned') }}

),

renamed as (

    select
        country,
        country_code,
        age

    from source

)

select * from renamed
