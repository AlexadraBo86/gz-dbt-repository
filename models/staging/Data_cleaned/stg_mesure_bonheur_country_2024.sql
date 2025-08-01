{{ config(materialized='view') }}

with source as (

    select
        COUNTRY as country,
        CITY as city,
        YEAR as year,
        Rank as rank,
        Ladder_score as ladder_score,
        upperwhisker,
        lowerwhisker,
        Log_GDP_per_capita as log_gdp_per_capita,
        Social_support as social_support,
        Healthy_life_expectancy as healthy_life_expectancy,
        Freedom_to_make_life_choices as freedom_to_make_life_choices,
        Generosity as generosity,
        Perceptions_of_corruption as perceptions_of_corruption,
        Dystopia_residual as dystopia_residual

    from `z-score-467307.Data_cleaned.mesure_bonheur_country_2024_clean`

)

select * from source