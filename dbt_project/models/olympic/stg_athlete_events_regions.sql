{{
  config(
    materialized='table'
  )
}}

SELECT
  ae.id
 ,ae.name
 ,ae.sex
 ,ae.age
 ,ae.height
 ,ae.weight
 ,ae.team
 ,ae.noc
 ,ae.games
 ,ae.year
 ,ae.season
 ,ae.city
 ,ae.sport
 ,ae.event
 ,ae.medal
 ,nr.region
 ,nr.notes
FROM
  {{ source('olympic', 'athlete_events') }} ae INNER JOIN {{ source('olympic', 'noc_regions') }} nr
    ON ae.noc = nr.noc
