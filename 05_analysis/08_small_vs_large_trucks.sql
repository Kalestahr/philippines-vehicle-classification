-- 8. Within freight and delivery vehicles (ff q.05), is it mostly small or larger trucks?
select
  d.class_name as `Vehicle Type`,
  count(*) as `Number of Detections`,
  round(count(*) * 100.0 / sum(count(*)) over (), 1) as `Percent of Freight Vehicles`
from vehicle_project.gold.fact_vehicle_detection f
join vehicle_project.gold.dim_vehicle_class d on f.class_id = d.class_id
where d.vehicle_category = 'goods/freight'
group by d.class_name
order by "Number of Detections" desc;