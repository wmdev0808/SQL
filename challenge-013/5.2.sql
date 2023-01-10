/* Query 1 */
SELECT
  dept_id, server_id, cput_utilization,
  LAG(cpu_utilization) OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM 
  time_series.v_utilization 
WHERE 
  event_time BETWEEN '2019-03-05' AND '2019-03-06'

/* Query 2 */
SELECT
  dept_id, server_id, cput_utilization,
  LAG(cpu_utilization, 10) OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM 
  time_series.v_utilization 
WHERE 
  event_time BETWEEN '2019-03-05' AND '2019-03-06'
