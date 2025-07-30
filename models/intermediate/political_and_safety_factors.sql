{{ config(materialized='table') }}

WITH idh AS (
    SELECT
        country,
        hdi,
        ihdi,
        overall_loss_due_to_inequality_perc
    FROM {{ ref('stg_Data_cleaned__IDH_by_country_final_table') }}     
),

corruption AS (
    SELECT
        country,
        corruption_index
    FROM {{ ref('stg_Data_cleaned__corruption_estimated_final_table') }}
),

crime_safety AS (
    SELECT
        country,
        city,
        crime_index,
        safety_index
    FROM {{ ref('stg_Data_cleaned__Crime_safety_index_final_table') }}
)

SELECT
    idh.country,
    crime_safety.city,
    idh.hdi,
    idh.ihdi,
    idh.overall_loss_due_to_inequality_perc,
    corruption.corruption_index,
    crime_safety.crime_index,
    crime_safety.safety_index

FROM crime_safety
LEFT JOIN idh
    ON crime_safety.country = idh.country
LEFT JOIN corruption
    ON crime_safety.country = corruption.country