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
  region = 'USA'
