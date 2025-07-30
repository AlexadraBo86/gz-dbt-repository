with 

source as (

    select * from {{ source('Data_cleaned', 'corruption_estimated_final_table') }}

),

renamed as (

    select
        country,
        2024

    from source

)

select * from renamed
