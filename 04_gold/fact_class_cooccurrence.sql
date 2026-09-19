/**
Version 1.0.0
Granularity: one row per co-occurring class pair, per image
created by CPJ on 9/17/2026
**/

create or replace table vehicle_project.gold.fact_class_cooccurrence as
select
  a.image_id,
  a.class_id as class_id_a,
  b.class_id as class_id_b
from vehicle_project.gold.fact_vehicle_detection a
join vehicle_project.gold.fact_vehicle_detection b
  on a.image_id = b.image_id
  and a.class_id < b.class_id;