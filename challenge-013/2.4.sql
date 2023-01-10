EXPLAIN SELECT * FROM time_series.utilization

/*
  "QUERY PLAN"
  "Seq Scan on utilization  (cost=0.00..25.70 rows=1570 width=24)"
*/

EXPLAIN ANALYZE SELECT * FROM time_series.utilization
/*
  "QUERY PLAN"
  "Seq Scan on utilization  (cost=0.00..25.70 rows=1570 width=24) (actual time=0.002..0.003 rows=0 loops=1)"
  "Planning Time: 0.033 ms"
  "Execution Time: 0.010 ms"
*/