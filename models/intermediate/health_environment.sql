{{ config(materialized='table') }}

WITH

healthcare AS (
    SELECT
        INITCAP(TRIM(country)) AS country,
        INITCAP(TRIM(city)) AS city,
        MAX(Health_Care_Index) AS Health_Care_Index,
        MAX(Health_Care_Exp__Index) AS Health_Care_Exp__Index
    FROM {{ ref('stg_data_cleaned__healthcare_index_city_clean') }}
    GROUP BY 1, 2
),

expectancy_at_birth AS (
    SELECT
        INITCAP(TRIM(country)) AS country,
        MAX(Age) AS Age
    FROM {{ ref('stg_data_cleaned__life_expectancy_at_birth_country_clean') }}
    GROUP BY 1
),

pollution AS (
    SELECT
        INITCAP(TRIM(COUNTRY)) AS country,
        INITCAP(TRIM(City)) AS city,
        AVG(Rank) AS rank_pollution,
        AVG(Pollution_index) AS Pollution_index,
        AVG(Pollution_Index_Exp_) AS Pollution_Index_Exp_
    FROM {{ ref('stg_data_cleaned__pollution_index_city_clean') }}
    GROUP BY 1, 2
),

bonheur AS (
    SELECT
        INITCAP(TRIM(country)) AS country,
        INITCAP(TRIM(city)) AS city,
        rank AS rank_bonheur,
        ladder_score,
        upperwhisker,
        lowerwhisker,
        log_gdp_per_capita,
        social_support,
        healthy_life_expectancy,
        freedom_to_make_life_choices,
        generosity,
        perceptions_of_corruption,
        dystopia_residual,
        ROW_NUMBER() OVER (PARTITION BY INITCAP(TRIM(country)), INITCAP(TRIM(city)) ORDER BY year DESC) AS rn
    FROM {{ ref('stg_Data_cleaned__mesure_bonheur_country_2024_clean') }}
    WHERE year = 2024
)

SELECT DISTINCT
    healthcare.country,
    healthcare.city,

    healthcare.Health_Care_Index,
    healthcare.Health_Care_Exp__Index,

    expectancy_at_birth.Age,

    pollution.rank_pollution,
    pollution.Pollution_index,
    pollution.Pollution_Index_Exp_,

    bonheur.rank_bonheur,
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
   AND healthcare.city = pollution.city

LEFT JOIN bonheur
    ON healthcare.country = bonheur.country
   AND healthcare.city = bonheur.city
   AND bonheur.rn = 1
