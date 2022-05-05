{{
  config(
    materialized='view'
  )
}}

SELECT
  *
FROM
  {{ ref('mart_gold_medal_by_usa') }}
WHERE
  Sport = 'Basketball'
  AND Sex = 'M'
ORDER BY
  Year
