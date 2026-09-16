/**
Version 1.3.0
Desc: validates, dedupes, and stages the annotation data in silver, single step
created by CPJ on 9/16/2026
**/

create or refresh materialized view vehicle_project.silver.clean_vehicle_annotations
(
    -- Implement null check and range check
    constraint has_filename expect (filename is not null) on violation drop row,
    constraint valid_class_id expect (class_id is not null and class_id between 0 and 13) on violation drop row,
    constraint valid_split expect (split in ('train', 'valid', 'test')) on violation drop row,
    constraint valid_bbox_coords expect (
        x_center is not null and x_center between 0 and 1 and
        y_center is not null and y_center between 0 and 1 and
        width is not null and width between 0 and 1 and
        height is not null and height between 0 and 1
    ) on violation drop row,
    constraint nonzero_bbox_area expect (width > 0 and height > 0) on violation drop row,
    -- Check if box is within frame
    constraint bbox_within_frame expect (
        x_center - width / 2 >= 0 and
        x_center + width / 2 <= 1 and
        y_center - height / 2 >= 0 and
        y_center + height / 2 <= 1
    ) on violation drop row
)
as
-- Deduplication to keep only the first occurrence of each exact duplicate detection
select * except (row_num)
from (
    select
        filename, class_id, x_center, y_center, width, height, split, _ingested_at,
        row_number() over (
            partition by filename, class_id, x_center, y_center, width, height
            order by _ingested_at
        ) as row_num
    from vehicle_project.bronze.raw_vehicle_annotations
)
where row_num = 1;