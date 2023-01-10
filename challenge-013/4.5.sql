/* No partitioned */
EXPLAIN SELECT location_id, avg(temp_celcius)
FROM time_series.location_temp
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY location_id;
/*
  Query Plan
  Finalize GroupAggregate (cost=7640.69..7768.61 rows=500 width=38)
    Group Key: location_id
    -> Gather Merge (cost=7640.69..7757.36 rows=1000 width=38)
      Workers Planned: 2
      -> Sort (cost=6640.66..6641.91 rows=500 width=38)
        Sort Key: location_id
        -> Partial HashAggregate (cost=6613.25..6618.25 rows=500 width=38)
          Group Key: location_id
          -> Parallel Seq Scan on location_temp (cost=0.00..6310.00 rows=60650 widt...)
            Filter: ((event_time >= '2019-03-05 00:00:00'::timestamp without time zone...))
*/

EXPLAIN SELECT location_id, avg(temp_celcius)
FROM time_series.location_temp_p 
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY location_id;
/*
  Query Plan
  Finalize GroupAggregate (cost=9219.12..9270.29 rows=200 width=38)
    Group Key: loc_temp_p1.location_id
    -> Gather Merge (cost=9219.12..9265.79 rows=400 width=38)
      Workers Planned: 2
      -> Sort (cost=8219.10..8219.60 rows=200 width=38)
        Sort Key: loc_temp_p1.location_id
        -> Partial HashAggregate (cost=8209.45..8211.45 rows=200 width=38)
          Group Key: loc_temp_p1.location_id
          -> Parallel Seq Scan on location_temp (cost=0.00..6310.00 rows=60650 widt...)
            Filter: ((event_time >= '2019-03-05 00:00:00'::timestamp without time zone...))
*/

EXPLAIN SELECT location_id, avg(temp_celcius)
FROM time_series.location_temp_p 
WHERE event_hour BETWEEN 0 AND 4
GROUP BY location_id;
/*
  Query Plan
  Finalize GroupAggregate (cost=3698.55..3749.72 rows=200 width=38)
    Group Key: loc_temp_p1.location_id
    -> Gather Merge (cost=3698.55..3745.22 rows=400 width=38)
      Workers Planned: 2
      -> Sort (cost=3698.55..3745.22 rows=200 width=38)
        Sort Key: loc_temp_p1.location_id
        -> Partial HashAggregate (cost=8209.45..8211.45 rows=200 width=38)
          Group Key: loc_temp_p1.location_id
          -> Parallel Seq Scan on location_temp (cost=0.00..6310.00 rows=60650 widt...)
            Filter: ((event_time >= '2019-03-05 00:00:00'::timestamp without time zone...))
*/