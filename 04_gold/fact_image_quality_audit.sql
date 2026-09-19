/**
Version 1.0.0
Granularity: one row per audited image, train and valid only
created by CPJ on 9/17/2026
**/

create or replace table vehicle_project.gold.fact_image_quality_audit as
select
  regexp_extract(image_path, '([^\\\\]+)$', 1) as image_id,
  cast(quality_score as float) as cleanlab_quality_score,
  cast(is_flagged as boolean) as was_quarantined,
  cast(num_gt_boxes as int) as num_gt_boxes,
  gt_classes,
  'train' as source_split
from read_files(
  '/Volumes/vehicle_project/bronze/raw_files/audit/audit_results_train.csv',
  format => 'csv',
  header => true
)

union all

select
  regexp_extract(image_path, '([^\\\\]+)$', 1) as image_id,
  cast(quality_score as float) as cleanlab_quality_score,
  cast(is_flagged as boolean) as was_quarantined,
  cast(num_gt_boxes as int) as num_gt_boxes,
  gt_classes,
  'valid' as source_split
from read_files(
  '/Volumes/vehicle_project/bronze/raw_files/audit/audit_results_valid.csv',
  format => 'csv',
  header => true
);