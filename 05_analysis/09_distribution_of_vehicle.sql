-- 9. Distribution of vehicles per image
select
  case
    when total_vehicle_count = 1 then '1 Vehicle'
    when total_vehicle_count between 2 and 3 then '2-3 Vehicles'
    else '4+ Vehicles'
  end as `Vehicle Distribution`,
  count(*) as `Number of Images`,
  round(count(*) * 100.0 / sum(count(*)) over (), 1) as `Percent of Images`
from vehicle_project.gold.fact_image_composition
group by
  case
    when total_vehicle_count = 1 then '1 Vehicle'
    when total_vehicle_count between 2 and 3 then '2-3 Vehicles'
    else '4+ Vehicles'
  end
order by `Number of Images` desc;