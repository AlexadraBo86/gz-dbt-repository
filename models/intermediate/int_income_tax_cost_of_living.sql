WITH selected_cities AS (
  SELECT *
  FROM {{ ref('stg_cost_of_living_by_city_cleaned_Otmane') }}
  WHERE City IN (
    'Casablanca', 'Johannesburg', 'Cape Town', 'Istanbul', 'Ankara',
    'New York', 'Los Angeles', 'Rio de Janeiro', 'Sao Paulo',
    'Montreal', 'Vancouver', 'Toronto', 'Mexico City', 'Cancun',
    'Sydney', 'Melbourne', 'Shanghai', 'Beijing', 'Mumbai', 'Bangalore',
    'Bangkok', 'Chiang Mai', 'Ho Chi Minh City', 'Hanoi',
    'Moscow', 'Saint Petersburg', 'Paris', 'Lyon',
    'Berlin', 'Frankfurt', 'Madrid', 'Barcelona',
    'Warsaw', 'Gdansk', 'Oslo', 'Bergen'
  )
),

joined AS (
  SELECT
    c.*,
    t.Year,
    t.income_tax_rate,
    t.gdp_per_capita_usd_2023,
    ROW_NUMBER() OVER (PARTITION BY c.Country, c.City ORDER BY t.Year DESC) AS row_num
  FROM selected_cities AS c
  LEFT JOIN {{ ref('stg_income_tax_2024') }} AS t
    ON c.Country = t.Country
)

SELECT *
FROM joined
WHERE row_num = 1