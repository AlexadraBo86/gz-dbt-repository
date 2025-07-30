with 

source as (

    select * from {{ source('Data_cleaned', 'Healthcare_index_by_city_cleaned') }}

),

renamed as (

    select
        city,
        healthcare_index,
        healthcare_exp_index

    from source

)

select * from renamed
