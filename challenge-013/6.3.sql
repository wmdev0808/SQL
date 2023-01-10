WITH daily_avg_temp AS 
  ( SELECT 
      date_trunc('day', event_time),
      avg(temp_celcius) avg_temp 
    FROM 
      time_series.location_temp 
    GROUP BY 
      date_trunc('day', event_time)
  )
SELECT 
  event_date, avg_temp,
  ( SELECT avg_temp
    FROM daily_avg_temp dat2 
    WHERE dat2.event_date = dat1.event_date - interval '1' day) 
FROM 
  daily_avg_temp dat1 