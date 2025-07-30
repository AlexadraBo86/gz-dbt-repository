with 

source as (

    select * from {{ source('Data_cleaned', 'income_tax_cleaned') }}

),

renamed as (

    select
        gdp_per_capita_usd_2023,
        country,
        year,
        income_tax_rate

    from source

)

select * from renamed
