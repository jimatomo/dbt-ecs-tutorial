{{
  config(
    materialized='view'
  )
}}

SELECT
  DISTINCT ON (year)
  *
FROM
  {{ ref('mart_gold_medal_basketball_by_usa') }}
ORDER BY
  Year, ID
