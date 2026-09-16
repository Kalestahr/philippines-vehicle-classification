/**
Version 1.1.1 
Desc: builds the raw table from consolidated raw files
created by CPJ on 9/16/2026
**/

create or refresh streaming table vehicle_project.bronze.raw_vehicle_annotations
as
select
  filename,
  class_id,
  x_center,
  y_center,
  width,
  height,
  split,
  _metadata.file_path as _source_file,
  current_timestamp() as _ingested_at
from stream read_files(
  '/Volumes/vehicle_project/bronze/raw_files/annotations',
  format => 'csv'
);