with 

source as (

    select * from {{ source('Data_cleaned', 'temperature_ville_cleaned') }}

),

renamed as (

    select
        country,
        city,
        jan,
        feb,
        mar,
        apr,
        may,
        jun,
        jul,
        aug,
        sep,
        oct,
        nov,
        dec,
        year,
        ref_

    from source

)

select * from renamed
