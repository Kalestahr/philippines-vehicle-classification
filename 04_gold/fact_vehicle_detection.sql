/**
Version 1.0.0
Granularity: one row per vehicle
created by CPJ on 9/17/2026
**/

create or replace table vehicle_project.gold.fact_vehicle_detection as
select
  concat(c.filename, '_', cast(row_number() over (partition by c.filename order by c.x_center) as string)) as detection_id,
  i.image_id as image_id,
  c.class_id as class_id,
  c.x_center as x_center,
  c.y_center as y_center,
  c.width as width,
  c.height as height,
  c.width * c.height as bbox_area
from vehicle_project.silver.clean_vehicle_annotations c
join vehicle_project.gold.dim_image i on c.filename = i.filename;