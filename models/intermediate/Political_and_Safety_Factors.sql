{{ config(materialized='table') }}

SELECT
    initcap(country) AS country,
    initcap(city) AS city,
    hdi,
    ihdi,
    overall_loss_due_to_inequality_perc,
    corruption_index,
    crime_index,
    safety_index,
    rank,
    ladder_score,
    upperwhisker,
    lowerwhisker,
    social_support,
    freedom_to_make_life_choices,
    generosity,
    perceptions_of_corruption,
    dystopia_residual
FROM {{ ref('political_and_safety_factors') }}