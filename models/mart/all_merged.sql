{{ config(materialized='table') }}

WITH politics_safety AS (
    SELECT
        INITCAP(TRIM(country)) AS country,
        INITCAP(TRIM(city)) AS city,
        hdi,
        ihdi,
        overall_loss_due_to_inequality_perc,
        corruption_index,
        crime_index,
        safety_index,
        rank AS rank_bonheur,
        ladder_score,
        upperwhisker,
        lowerwhisker,
        social_support,
        freedom_to_make_life_choices,
        generosity,
        perceptions_of_corruption,
        dystopia_residual
    FROM {{ ref('Political_and_Safety_Factors') }}
),

health_env AS (
    SELECT
        INITCAP(TRIM(country)) AS country,
        INITCAP(TRIM(city)) AS city,
        Health_Care_Index,
        Health_Care_Exp__Index,
        Age,
        rank_pollution,
        Pollution_index,
        Pollution_Index_Exp_
    FROM {{ ref('health_environment') }}
),

econ_score AS (
    SELECT
        INITCAP(TRIM(Country)) AS country,
        INITCAP(TRIM(City)) AS city,
        Year,
        income_tax_rate,
        gdp_per_capita,
        Cost_of_Living_Index,
        Rent_Index,
        Cost_of_Living_Plus_Rent_Index,
        Groceries_Index,
        Restaurant_Price_Index,
        Local_Purchasing_Power_Index
    FROM {{ ref('otmane_economics_score') }}
),

cult_env_transp AS (
    SELECT
        INITCAP(TRIM(country)) AS country,
        INITCAP(TRIM(city)) AS city,
        avg_annual_temperature,
        traffic_index,
        time_index_minutes,
        inefficiency_index,
        co2_emission_index,
        linguistic_diversity_index,
        secure_servers,
        internet_usage_2022,
        internet_usage_2023,
        internet_usage_2024
    FROM {{ ref('final_cult_env_transp') }}
)

SELECT
    ps.country,
    ps.city,

    -- Political and safety
    ps.hdi,
    ps.ihdi,
    ps.overall_loss_due_to_inequality_perc,
    ps.corruption_index,
    ps.crime_index,
    ps.safety_index,

    -- Bonheur
    ps.rank_bonheur,
    ps.ladder_score,
    ps.upperwhisker,
    ps.lowerwhisker,
    ps.social_support,
    ps.freedom_to_make_life_choices,
    ps.generosity,
    ps.perceptions_of_corruption,
    ps.dystopia_residual,

    -- Santé & environnement
    he.Health_Care_Index,
    he.Health_Care_Exp__Index,
    he.Age,
    he.rank_pollution,
    he.Pollution_index,
    he.Pollution_Index_Exp_,

    -- Économie
    eco.Year,
    eco.income_tax_rate,
    eco.gdp_per_capita,
    eco.Cost_of_Living_Index,
    eco.Rent_Index,
    eco.Cost_of_Living_Plus_Rent_Index,
    eco.Groceries_Index,
    eco.Restaurant_Price_Index,
    eco.Local_Purchasing_Power_Index,

    -- Culture, environnement, transport
    ct.avg_annual_temperature,
    ct.traffic_index,
    ct.time_index_minutes,
    ct.inefficiency_index,
    ct.co2_emission_index,
    ct.linguistic_diversity_index,
    ct.secure_servers,
    ct.internet_usage_2022,
    ct.internet_usage_2023,
    ct.internet_usage_2024

FROM politics_safety ps
LEFT JOIN health_env he
    ON ps.country = he.country AND ps.city = he.city
LEFT JOIN econ_score eco
    ON ps.country = eco.country AND ps.city = eco.city
LEFT JOIN cult_env_transp ct
    ON ps.country = ct.country AND ps.city = ct.city
