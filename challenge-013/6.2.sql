SELECT 
  server_id, cpu_utilization,
  avg(cpu_utilization) OVER (PARTITION BY server_id)
FROM 
  time_series.utilization 
WHERE 
  event_time BETWEEN '2019-03-05' AND '2019-03-06'