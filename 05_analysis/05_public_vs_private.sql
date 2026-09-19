-- 6. Public transport vs private vehicle ratio
select
  d.vehicle_category as `Vehicle Category`,
  count(*) as `Number of Detections`,
  round(count(*) * 100.0 / sum(count(*)) over (), 1) as `Percent of Total`
from vehicle_project.gold.fact_vehicle_detection f
join vehicle_project.gold.dim_vehicle_class d on f.class_id = d.class_id
group by d.vehicle_category
order by `Number of Detections` desc;
 