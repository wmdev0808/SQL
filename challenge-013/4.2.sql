EXPLAIN ANALYZE SELECT 
  location_id, avg(temp_celcius)
FROM
  time_series.location_temp
GROUP BY 
  location_id;

/*
  Query Plan
  Finalize GroupAggregate (cost=7337.44..7465.36 rows=500 width=38)
    Group Key: location_id
    -> Gather Merge (cost=7337.44..7454.11 rows=1000 width=38)
      Workers Planned: 2
      -> Sort (cost=6337.41..6338.66 rows=500 width=38)
        Sort Key: location_id
        -> Partial HashAggregate (cost=6310.00..6315.00 rows=500 width=38)
          Group Key: location_id
          -> Parallel Seq Scan on location_temp (cost=0.00..5268.33 rows=208333 width=10)
  Planning Time: 0.180 ms
  Execution Time: 192.387 ms
*/

CREATE INDEX idx_loc_temp_location ON 
  time_series.location_temp(location_id)

EXPLAIN SELECT 
  location_id, avg(temp_celcius)
FROM 
  time_series.location_temp
WHERE 
  location_id = 'loc2'
GROUP BY 
  location_id 

/*

  Query Plan
  GroupAggregate (cost=20.14..2145.65 rows=432 width=38)
    Group Key: location_id
    -> Bitmap Heap Scan on location_temp(cost=20.14..2135.27 rows=9...)
      Recheck Cond: ((location_id)::text = 'loc2'::text)
      -> Bitmap Index Scan on idx_loc_temp_location (cost=0.00..19.89...)
        Index Cond: ((location_id)::text = 'loc2'::text)
*/

DROP INDEX time_series.idx_loc_temp_location;
