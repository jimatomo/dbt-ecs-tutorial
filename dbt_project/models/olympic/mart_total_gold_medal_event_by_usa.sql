{{
  config(
    materialized='view'
  )
}}

SELECT
  event,
  COUNT(Medal) AS total_gold_medal_count
FROM
  {{ ref('mart_gold_medal_by_usa') }}
GROUP BY
  event
ORDER BY
  COUNT(Medal) DESC
