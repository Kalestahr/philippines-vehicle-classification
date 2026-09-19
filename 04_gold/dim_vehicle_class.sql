/**
Version 1.0.0
Desc: vehicle classification
created by CPJ on 9/16/2026
**/
 
create or replace table vehicle_project.gold.dim_vehicle_class as
select * from (values
  (0, 'Bicycle', 2, 'non-motorized', false),
  (1, 'Electric Bike', 2, 'private', false),
  (2, 'Hatchback', 4, 'private', false),
  (3, 'Large Bus', 4, 'public transport', false),
  (4, 'Light Goods Vehicle', 4, 'goods/freight', false),
  (5, 'Medium Goods Vehicle', 4, 'goods/freight', false),
  (6, 'Motorcycle', 2, 'private', false),
  (7, 'Pickup Truck', 4, 'private', false),
  (8, 'Public Utility Jeepney', 4, 'public transport', true),
  (9, 'Sedan', 4, 'private', false),
  (10, 'Small Bus', 4, 'public transport', false),
  (11, 'Sports Utility Vehicle', 4, 'private', false),
  (12, 'Tricycle', 3, 'public transport', true),
  (13, 'Van', 4, 'private', false)
) as t(class_id, class_name, wheel_count, vehicle_category, is_ph_specific);
 
