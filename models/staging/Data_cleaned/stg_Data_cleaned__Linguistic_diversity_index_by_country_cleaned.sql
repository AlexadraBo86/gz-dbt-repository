with 

source as (

    select * from {{ source('Data_cleaned', 'Linguistic_diversity_index_by_country_cleaned') }}

),

renamed as (

    select
        rank_diverse,
        country,
        linguistic_diversity_index

    from source

)

select * from renamed
