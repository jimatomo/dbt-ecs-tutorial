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
  age IS NOT NULL
