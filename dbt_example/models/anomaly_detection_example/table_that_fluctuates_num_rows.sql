select
  arr,
  current_timestamp() as updated_at,
  1 as anomaly,
  "something" as anomaly2

from unnest(generate_array(1,12)) as arr