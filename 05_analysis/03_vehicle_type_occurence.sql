-- 3. Vehicle type co-occurrence
select
  da.class_name as `Vehicle Type A`,
  db.class_name as `Vehicle Type B`,
  count(*) as `Times Seen Together`
from vehicle_project.gold.fact_class_cooccurrence c
join vehicle_project.gold.dim_vehicle_class da on c.class_id_a = da.class_id
join vehicle_project.gold.dim_vehicle_class db on c.class_id_b = db.class_id
group by da.class_name, db.class_name
order by `Times Seen Together` desc;