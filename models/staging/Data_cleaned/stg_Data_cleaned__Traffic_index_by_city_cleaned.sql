with 

source as (

    select * from {{ source('Data_cleaned', 'Traffic_index_by_city_cleaned') }}

),

renamed as (

    select
        city,
        traffic_index,
        time_index_minutes,
        time_index_exp,
        inefficiency_index,
        co2_emission_index

    from source

)

select * from renamed
