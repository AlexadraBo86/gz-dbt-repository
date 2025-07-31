SELECT
  t.Year,
  t.income_tax_rate,
  t.gdp_per_capita_usd_2023 AS gdp_per_capita,
  t.Country,
  t.City,
  t.Cost_of_Living_Index,
  t.Rent_Index,
  t.Cost_of_Living_Plus_Rent_Index,
  t.Groceries_Index,
  t.Restaurant_Price_Index,
  t.Local_Purchasing_Power_Index
FROM {{ ref('int_income_tax_cost_of_living') }} AS t