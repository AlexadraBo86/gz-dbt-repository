with 

source as (

    select * from {{ source('Data_cleaned', 'mesure_bonheur_cleaned') }}

),

renamed as (

    select
        country,
        year,
        rank,
        ladder score,
        upperwhisker,
        lowerwhisker,
        log gdp per capita,
        social support,
        healthy life expectancy,
        freedom to make life choices,
        generosity,
        perceptions of corruption,
        dystopia residual

    from source

)

select * from renamed
