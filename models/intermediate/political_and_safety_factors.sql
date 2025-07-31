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
),

bonheur AS (
    SELECT
        country,
        city,
        year,
        rank,
        perceptions_of_corruption,
        dystopia_residual
    FROM {{ ref('mesure_bonheur_country_2024_clean') }}
    WHERE year = 2024  -- Filtrer uniquement 2024 si pertinent
)

SELECT
    idh.country,
    crime_safety.city,
    
    -- Indicateurs IDH
    idh.hdi,
    idh.ihdi,
    idh.overall_loss_due_to_inequality_perc,

    -- Corruption
    corruption.corruption_index,

    -- Criminalité
    crime_safety.crime_index,
    crime_safety.safety_index,

    -- Bonheur
    bonheur.rank,
    bonheur.ladder_score,
    bonheur.upperwhisker,
    bonheur.lowerwhisker,
    bonheur.log_gdp_per_capita,
    bonheur.social_support,
    bonheur.healthy_life_expectancy,
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