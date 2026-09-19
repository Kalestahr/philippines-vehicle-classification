/**
Version 1.0.0
Granularity: one row per image
created by CPJ on 9/17/2026
**/

create or replace table vehicle_project.gold.fact_image_composition as
select
  image_id,
  count(*) as total_vehicle_count,
  count(distinct class_id) as distinct_class_count,
  max_by(class_id, bbox_area) as dominant_class_id
from vehicle_project.gold.fact_vehicle_detection
group by image_id;