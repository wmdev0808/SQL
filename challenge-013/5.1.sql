CREATE VIEW time_series.v_utilization AS 
  (SELECT *, server_id % 10 dept_id FROM time_series.utilization)

/* Query 1 */
SELECT 
  dept_id, server_id, cpu_utilization,
  LEAD(cput_utilization) OVER (PARTITION BY dept_id 
                              ORDER BY cpu_utilization DESC)
FROM 
  time_series.v_utilization 
WHERE 
  event_time BETWEEN '2019-03-05' AND '2019-03-06'

/* Query 2 */
SELECT 
  dept_id, server_id, cpu_utilization,
  LEAD(cput_utilization, 2) OVER (PARTITION BY dept_id 
                              ORDER BY cpu_utilization DESC)
FROM 
  time_series.v_utilization 
WHERE 
  event_time BETWEEN '2019-03-05' AND '2019-03-06'
