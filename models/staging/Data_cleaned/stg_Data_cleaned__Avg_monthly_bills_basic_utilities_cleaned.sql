with 

source as (

    select * from {{ source('Data_cleaned', 'Avg_monthly_bills_basic_utilities_cleaned') }}

),

renamed as (

    select
        city,
        basic_utilities_bill

    from source

)

select * from renamed
