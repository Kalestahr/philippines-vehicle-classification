select * from read_files(
  '/Volumes/vehicle_project/bronze/raw_files/audit/audit_results_valid.csv',
  format => 'csv',
  header => true
)
limit 5;