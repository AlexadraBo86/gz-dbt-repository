{{ config(materialized='view') }}

SELECT
    Country AS country,
    Country_Code AS country_code,
    `Secure_Internet_servers__per_1_million_people_` AS secure_servers,
    `_Individuals_using_the_Internet____of_population_in_2022_` AS internet_usage_2022,
    `Individuals_using_the_Internet____of_population_in_2023_` AS internet_usage_2023,
    `Individuals_using_the_Internet____of_population_in_2024_` AS internet_usage_2024
FROM {{ source('data_cleaned', 'access_to_internet_country_cleaned') }}