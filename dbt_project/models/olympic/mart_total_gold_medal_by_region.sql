{{
  config(
    materialized='view'
  )
}}

SELECT
  region,
	COUNT(Medal) AS total_gold_medal_count
FROM
  {{ ref('mart_gold_medal') }}
GROUP BY
  region
ORDER BY
  COUNT(Medal) DESC
