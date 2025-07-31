WITH base AS (
  SELECT *
  FROM `z-score-467307.Data_cleaned.Cost_of_living_by_city_cleaned_Otmane`
),

-- Nettoyage des noms de ville
cleaned AS (
  SELECT
    Country,
    REGEXP_REPLACE(City, r',\s*[A-Z]{2}$', '') AS City,
    Cost_of_Living_Index,
    Rent_Index,
    Cost_of_Living_Plus_Rent_Index,
    Groceries_Index,
    Restaurant_Price_Index,
    Local_Purchasing_Power_Index
  FROM base
)

SELECT * FROM cleaned

UNION ALL

-- Ajout manuel de Berlin
SELECT 
  'Germany' AS Country,
  'Berlin' AS City,
  66.0 AS Cost_of_Living_Index,
  34.8 AS Rent_Index,
  52.4 AS Cost_of_Living_Plus_Rent_Index,
  60.4 AS Groceries_Index,
  63.9 AS Restaurant_Price_Index,
  134.1 AS Local_Purchasing_Power_Index