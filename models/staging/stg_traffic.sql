{{ config(materialized='view') }}

SELECT
    Country AS country,
    City AS city,
    Traffic_index AS traffic_index,
    Time_index_minutes AS time_index_minutes,
    Inefficiency_index AS inefficiency_index,
    CO2_Emission_index AS co2_emission_index
FROM {{ source('data_cleaned', 'Traffic_index_by_city_cleaned') }}