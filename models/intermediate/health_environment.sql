{{ config(materialized='table') }}

WITH

healthcare AS (
    SELECT
        *
    FROM {{ ref('stg_data_cleaned__healthcare_index_city_clean') }}
),

expectancy_at_birth AS (
    SELECT
        *
    FROM {{ ref('stg_data_cleaned__life_expectancy_at_birth_country_clean') }}
),
pollution AS (
    SELECT
        Rank as rank_pollution,
        COUNTRY as Country,
        City,
        Pollution_index,
        Pollution_Index_Exp_
    FROM {{ ref('stg_data_cleaned__pollution_index_city_clean') }}
),

bonheur AS (
    SELECT
        *
    FROM {{ ref('stg_Data_cleaned__mesure_bonheur_country_2024_clean') }}
)


SELECT
    healthcare.country,
    healthcare.city,
    
    -- healthcare
    healthcare.Health_Care_Index,
    healthcare.Health_Care_Exp__Index,
    
    -- expectancy_at_birth
    expectancy_at_birth.Age,
    
    -- pollution
    pollution.rank_pollution,
    pollution.Pollution_index,
    pollution.Pollution_Index_Exp_,
    
    -- bonheur
    bonheur.rank as rank_bonheur,
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

FROM healthcare
LEFT JOIN expectancy_at_birth
    ON healthcare.country = expectancy_at_birth.country
LEFT JOIN pollution
    ON healthcare.country = pollution.country
LEFT JOIN bonheur
    ON healthcare.country = bonheur.country
   AND healthcare.city = bonheur.city