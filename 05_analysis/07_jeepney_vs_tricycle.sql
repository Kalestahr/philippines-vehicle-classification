 
-- 7. Jeepney-to-tricycle ratio
select
  d.class_name as `Vehicle Type`,
  count(*) as `Number of Detections`
from vehicle_project.gold.fact_vehicle_detection f
join vehicle_project.gold.dim_vehicle_class d on f.class_id = d.class_id
where d.is_ph_specific = true
group by d.class_name;
 