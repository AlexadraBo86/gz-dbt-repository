with 

source as (

    select * from {{ ref('stg_Data_cleaned__corruption_estimated_final_table') }} 

),

renamed as (

    select
        country,
        `2024` AS corruption_index

    from source

)

select * from renamed
