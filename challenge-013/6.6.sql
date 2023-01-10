/* y=mx+b m: slope b: intercept x: input value y: predicted value */
SELECT 
  regr_slope(free_memory, cpu_utilization) * 0.65,
  regr_intercept(free_memory, cpu_utilization) predicted_value 
FROM 
  time_series.utilization 
WHERE 
  event_time BETWEEN '2019-03-05' AND '2019-03-06'