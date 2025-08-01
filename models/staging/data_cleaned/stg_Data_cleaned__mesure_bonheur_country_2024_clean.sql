with 

source as (

    select * from {{ source('data_cleaned', 'mesure_bonheur_country_2024_clean') }}

),

renamed as (

    select
        country,
        city,
        year,
        rank,
        ladder_score,
        upperwhisker,
        lowerwhisker,
        log_gdp_per_capita,
        social_support,
        healthy_life_expectancy,
        freedom_to_make_life_choices,
        generosity,
        perceptions_of_corruption,
        dystopia_residual

    from source

)

select * from renamed
