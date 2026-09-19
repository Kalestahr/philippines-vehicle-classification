-- 2. How much space vehicles occupies in roads vs frequency based on images
select
  d.class_name as `Vehicle Type`,
  count(*) as `Number of Detections`,
  round(avg(f.bbox_area), 4) as `Average Road Space Occupied`
from vehicle_project.gold.fact_vehicle_detection f
join vehicle_project.gold.dim_vehicle_class d on f.class_id = d.class_id
group by d.class_name
order by `Average Road Space Occupied` desc;