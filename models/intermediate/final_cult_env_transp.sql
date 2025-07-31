{{ config(materialized='view') }}

WITH temperature AS (
    SELECT * FROM {{ ref('stg_temperature') }}
),

traffic AS (
    SELECT * FROM {{ ref('stg_traffic') }}
),

linguistic AS (
    SELECT * FROM {{ ref('stg_linguistic') }}
),

internet AS (
    SELECT * FROM {{ ref('stg_internet') }}
)

SELECT
    t.country,
    t.city,
    t.avg_annual_temperature,
    tr.traffic_index,
    tr.time_index_minutes,
    tr.inefficiency_index,
    tr.co2_emission_index,
    l.linguistic_diversity_index,
    i.secure_servers,
    i.internet_usage_2022,
    i.internet_usage_2023,
    i.internet_usage_2024
FROM temperature t
LEFT JOIN traffic tr
    ON t.country = tr.country AND t.city = tr.city
LEFT JOIN linguistic l
    ON t.country = l.country
LEFT JOIN internet i
    ON t.country = i.country