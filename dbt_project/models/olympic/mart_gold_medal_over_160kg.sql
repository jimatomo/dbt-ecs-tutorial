{{
  config(
    materialized='view'
  )
}}

SELECT
  *
FROM
  {{ ref('mart_not_null_gold_medal') }}
WHERE
  Weight > 160
