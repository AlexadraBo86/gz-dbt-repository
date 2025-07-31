{{ config(materialized='table') }}

WITH idh AS (
    SELECT
        LOWER(TRIM(country)) AS country,
        hdi,
        ihdi,
        overall_loss_due_to_inequality_perc
    FROM {{ ref('stg_Data_cleaned__IDH_by_country_final_table') }}
),

corruption AS (
    SELECT
        LOWER(TRIM(country)) AS country,
        corruption_index
    FROM {{ ref('stg_Data_cleaned__corruption_estimated_final_table') }}
)
,
crime_safety AS (
    SELECT
        LOWER(TRIM(country)) AS country,
        LOWER(TRIM(city)) AS city,
        crime_index,
        safety_index
    FROM {{ ref('Crime_safety') }}

bonheur AS (
    SELECT
        LOWER(TRIM(country)) AS country,
        LOWER(TRIM(city)) AS city,
        year,
        rank,
        ladder_score,
        upperwhisker,
        lowerwhisker,
        social_support,
        freedom_to_make_life_choices,
        generosity,
        perceptions_of_corruption,
        dystopia_residual
    FROM {{ ref('stg_Data_cleaned__mesure_bonheur_country_2024_clean') }}
)

SELECT
    idh.country,
    crime_safety.city,
    idh.hdi,
    idh.ihdi,
    idh.overall_loss_due_to_inequality_perc,
    corruption.corruption_index,
    crime_safety.crime_index,
    crime_safety.safety_index,
    bonheur.rank,
    bonheur.ladder_score,
    bonheur.upperwhisker,
    bonheur.lowerwhisker,
    bonheur.social_support,
    bonheur.freedom_to_make_life_choices,
    bonheur.generosity,
    bonheur.perceptions_of_corruption,
    bonheur.dystopia_residual

FROM crime_safety
LEFT JOIN idh
    ON crime_safety.country = idh.country
LEFT JOIN corruption
    ON crime_safety.country = corruption.country
LEFT JOIN bonheur
    ON crime_safety.country = bonheur.country
    AND crime_safety.city = bonheur.city