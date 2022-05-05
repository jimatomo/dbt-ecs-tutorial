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
  Medal = 'Gold'
