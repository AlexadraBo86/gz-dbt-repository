SELECT
  -- Correction des noms de pays
  CASE
    WHEN Country = 'Viet Nam' THEN 'Vietnam'
    WHEN Country = 'Russian Federation' THEN 'Russia'
    WHEN Country = 'Turkiye' THEN 'Turkey'
    ELSE Country
  END AS Country,

  Year,
  Income_tax_rate,
  gdp_per_capita_usd_2023
FROM `z-score-467307.Data_cleaned.income_tax_cleaned`