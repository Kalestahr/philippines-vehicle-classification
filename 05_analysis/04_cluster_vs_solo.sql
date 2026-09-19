-- 4. When this vehicle type shows up, does it usually appear more than once in the same photo (cluster vs solo)
-- Fkeeps only one copy per original source photo (
with deduped_images as (
  select filename
  from (
    select
      filename,
      regexp_extract(filename, '^(.*)\\.rf\\.', 1) as source_photo_id,
      row_number() over (partition by regexp_extract(filename, '^(.*)\\.rf\\.', 1) order by filename) as rn
    from vehicle_project.gold.dim_image
  )
  where rn = 1
),
detections_deduped as (
  select f.image_id, f.class_id
  from vehicle_project.gold.fact_vehicle_detection f
  join vehicle_project.gold.dim_image i on f.image_id = i.image_id
  join deduped_images d on i.filename = d.filename
),
per_image_counts as (
  select image_id, class_id, count(*) as same_class_count
  from detections_deduped
  group by image_id, class_id
)
select
  d.class_name as `Vehicle Type`,
  round(100.0 * sum(case when p.same_class_count > 1 then 1 else 0 end) / count(*), 1) as `Percent Appearing in Groups`
from detections_deduped f
join vehicle_project.gold.dim_vehicle_class d on f.class_id = d.class_id
join per_image_counts p on f.image_id = p.image_id and f.class_id = p.class_id
group by d.class_name
order by `Percent Appearing in Groups` desc;