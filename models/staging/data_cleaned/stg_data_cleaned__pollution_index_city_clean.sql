with 

source as (

    select * from {{ source('data_cleaned', 'pollution_index_city_clean') }}

),

renamed as (

    select
        rank,
        country,
        city,
        pollution_index,
        pollution_index_exp_

    from source

)

select * from renamed
