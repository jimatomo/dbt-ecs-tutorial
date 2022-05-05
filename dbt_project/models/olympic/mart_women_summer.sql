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
  Sex = 'F'
  AND Season = 'Summer'
