EXPLAIN SELECT 
  server_id, avg(cpu_utilization)
FROM 
  time_series.utilization 
WHERE 
  event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY 
  server_id 
/*
  Query Plan
  HashAggregate (cost=3876.34..3876.96 rows=50 width=12)
    Group Key: server_id 
    -> Bitmap Heap Scan on utilization (cost=499.00..3828.25 rows=9617 width=8)
       Recheck Cond: ((event_time >= '2019-03-05 00:00:00'::timestamp without time zone) ANd (...))
       -> Bitmap Index Scan on utilization_pkey (cost=0.00..496.59 rows=9617 width=0)
          Index Cond: ((event_time >= '2019-03-05 00:00:00'::timestamp without time zone) AND ...)
*/

CREATE INDEX idx_util_time_serv ON 
  time_series.utilization(event_time, server_id);
/*
  Query Plan
  HashAggregate (cost=3628.34..3628.96 rows=50 width=12)
  ...
*/

/* Delete the existing index and create a new one */
CREATE INDEX idx_util_serv_time ON 
  time_series.utilization(server_id, event_time);
/*
  Run the query plan, Not get any gains there
*/