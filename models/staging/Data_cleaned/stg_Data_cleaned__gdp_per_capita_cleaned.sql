with 

source as (

    select * from {{ source('Data_cleaned', 'gdp_per_capita_cleaned') }}

),

renamed as (

    select
        country_name,
        year_2023

    from source

)

select * from renamed
