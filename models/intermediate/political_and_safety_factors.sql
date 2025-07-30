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
)

SELECT
    idh.country,
    idh.hdi,
    idh.ihdi,
    idh.overall_loss_due_to_inequality_perc,
    corruption.corruption_index
FROM idh
LEFT JOIN corruption
    ON idh.country = corruption.country