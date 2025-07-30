with 

source as (

    select * from {{ source('Data_cleaned', 'corruption_estimated_cleaned') }}

),

renamed as (

    select
        country,
        code,
        `2011`,
        `2012`,
        `2013`,
        `2014`,
        `2015`,
        `2016`,
        `2017`,
        `2018`,
        `2019`,
        `2020`,
        `2021`,
        `2022`,
        `2023`,
        `2024`

    from source

)

select * from renamed
