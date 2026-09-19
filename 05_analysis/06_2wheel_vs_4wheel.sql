
-- 6. Two-wheeled vs four-plus-wheeled share
select
  case when d.wheel_count <= 2 then 'Two-Wheeled' else 'Four or More Wheels' end as `Wheel Group`,
  count(*) as `Number of Detections`,
  round(count(*) * 100.0 / sum(count(*)) over (), 1) as `Percent of Total`
from vehicle_project.gold.fact_vehicle_detection f
join vehicle_project.gold.dim_vehicle_class d on f.class_id = d.class_id
group by case when d.wheel_count <= 2 then 'Two-Wheeled' else 'Four or More Wheels' end;
 