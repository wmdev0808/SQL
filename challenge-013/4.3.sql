EXPLAIN SELECT 
  location_id, avg(temp_celcius)
FROM
  time_series.location_temp 
WHERE
  event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY
  location_id

/*
  Query Plan
  Finalize GroupAggregate (cost=7640.69..7768.61 rows=500 width=38)
    Group Key: location_id
    -> Gather Merge (cost=7640.69..7768.36 rows=1000 width=38)
      Workers Planned: 2
      -> Sort (cost=6640.66..6641.91 rows=500 width=38)
        Sort Key: location_id
        -> Partial HashAggregate (cost=6310.00..6315.00 rows=500 width=38)
          Group Key: location_id
          -> Parallel Seq Scan on location_temp (cost=0.00..5268.33 rows=208333 width=10)
            Filter: ((event_time >= '2019-03-05 00:00:00'::timestamp without...))
*/

CREATE INDEX idx_loc_temp_time_loc ON 
  time_series.location_temp(event_time, location_id);

EXPLAIN SELECT 
  location_id, avg(temp_celcius)
FROM
  time_series.location_temp 
WHERE
  event_time BETWEEN '2019-03-05 00:00:00' AND '2019-03-05 00:20:00'
GROUP BY
  location_id

/*
  Query Plan
  HashAggregate (cost=2907.68..2913.77 rows=487 width=38)
    Group Key: location_id
    -> Bitmap Heap Scan on location_temp (cost=46.96..2898.63 rows=18...)
       Recheck Cond: ((event_time >= '2019-03-05 00:00:00'::timestamp without...))
       -> Bitmap Index Scan on idx_loc_temp_time_loc (cost=0.00..46.51 rows=1809 width=0)
          Index Cond: ((event_time >= '2019-03-05 00:00:00'::timestamp wi...))
*/