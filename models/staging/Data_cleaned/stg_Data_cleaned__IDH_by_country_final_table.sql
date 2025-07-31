with 

source as (

    select * from {{ ref('stg_Data_cleaned__IDH_by_country_final_table') }}

),

renamed as (

    select
        country,
        hdi,
        ihdi,
        overall_loss_corrected AS overall_loss_due_to_inequality_perc

    from source

)

select * from renamed
