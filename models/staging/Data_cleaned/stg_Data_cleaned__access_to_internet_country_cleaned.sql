with 

source as (

    select * from {{ source('Data_cleaned', 'access_to_internet_country_cleaned') }}

),

renamed as (

    select
        country,
        country_code,
        secure_internet_servers__per_1_million_people_,
        _individuals_using_the_internet____of_population_in_2022_,
        individuals_using_the_internet____of_population_in_2023_,
        individuals_using_the_internet____of_population_in_2024_

    from source

)

select * from renamed
