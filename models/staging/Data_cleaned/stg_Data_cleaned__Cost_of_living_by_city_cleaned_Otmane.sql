with 

source as (

    select * from {{ source('Data_cleaned', 'Cost_of_living_by_city_cleaned_Otmane') }}

),

renamed as (

    select
        country,
        city,
        cost_of_living_index,
        rent_index,
        cost_of_living_plus_rent_index,
        groceries_index,
        restaurant_price_index,
        local_purchasing_power_index

    from source

)

select * from renamed
