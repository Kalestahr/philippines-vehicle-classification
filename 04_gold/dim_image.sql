/**
Version 1.0.0
Desc: creates one row per distinct image
created by CPJ on 9/16/2026
**/
 
create or replace table vehicle_project.gold.dim_image as
select
  filename as image_id,
  filename,
  split,
  -- kaggle documentation mentioned resizing the images to 640x640 with black-edge padding
  640 as image_width_px,
  640 as image_height_px
from (select distinct filename, split from vehicle_project.silver.clean_vehicle_annotations);
