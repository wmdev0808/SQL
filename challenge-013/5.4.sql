/* Query 1 */
SELECT
  dept_id, server_id, cput_utilization,
  PERCENT_RANK() OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM 
  time_series.v_utilization 
WHERE 
  event_time BETWEEN '2019-03-05' AND '2019-03-06'