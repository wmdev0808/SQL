WITH daily_avg_temp AS 
  ( SELECT 
      date_trunc('day', event_time) event_date,
      avg(temp_celcius) avg_temp 
    FROM
      time_series.location_temp 
    GROUP BY 
      date_trunc('day', event_time)
  )
SELECT 
  event_date, avg_temp 
FROM 
  daily_avg_temp