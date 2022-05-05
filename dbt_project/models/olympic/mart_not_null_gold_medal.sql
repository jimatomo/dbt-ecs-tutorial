{{
  config(
    materialized='view'
  )
}}

SELECT
  *
FROM
  {{ ref('mart_gold_medal') }}
WHERE
  Weight IS NOT NULL
  AND Height IS NOT NULL
