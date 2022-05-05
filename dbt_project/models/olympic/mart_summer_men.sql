{{
  config(
    materialized='view'
  )
}}

SELECT
  *
FROM
  {{ ref('stg_athlete_events_regions') }}
WHERE
  Season = 'Summer'
  AND Sex = 'M'
