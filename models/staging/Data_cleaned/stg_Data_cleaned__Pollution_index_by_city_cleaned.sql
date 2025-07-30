with 

source as (

    select * from {{ source('Data_cleaned', 'Pollution_index_by_city_cleaned') }}

),

renamed as (

    select
        city,
        pollution_index,
        pollution_index_exp_

    from source

)

select * from renamed
