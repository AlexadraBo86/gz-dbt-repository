{{ config(materialized='view') }}

SELECT
    Country AS country,
    Linguistic_diversity_index AS linguistic_diversity_index
FROM {{ source('data_cleaned', 'Linguistic_diversity_index_by_country_cleaned') }}