{{ config(materialized='view') }}

SELECT
    Country AS country,
    City AS city,
    Year AS avg_annual_temperature
FROM {{ source('data_cleaned', 'temperature_ville_cleaned') }}