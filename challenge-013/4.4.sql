/* Create a table of location and temperature measurements */
CREATE TABLE time_series.location_temp_p
(
  event_time timestamp NOT NULL,
  event_hour integer,
  temp_celcius integer,
  location_id character varying COLLATE pg_catalog."default"
)
PARTITION BY RANGE (event_hour);

CREATE TABLE time_series.loc_temp_p1 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (0) TO (2);
CREATE INDEX idx_loc_temp_p1 ON time_series.loc_temp_p1(event_time);

CREATE TABLE time_series.loc_temp_p2 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (2) TO (4);
CREATE INDEX idx_loc_temp_p2 ON time_series.loc_temp_p2(event_time);

CREATE TABLE time_series.loc_temp_p3 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (4) TO (6);
CREATE INDEX idx_loc_temp_p3 ON time_series.loc_temp_p3(event_time);

CREATE TABLE time_series.loc_temp_p4 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (6) TO (8);
CREATE INDEX idx_loc_temp_p4 ON time_series.loc_temp_p4(event_time);

CREATE TABLE time_series.loc_temp_p5 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (8) TO (10);
CREATE INDEX idx_loc_temp_p5 ON time_series.loc_temp_p5(event_time);

CREATE TABLE time_series.loc_temp_p6 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (10) TO (12);
CREATE INDEX idx_loc_temp_p6 ON time_series.loc_temp_p2(event_time);

CREATE TABLE time_series.loc_temp_p7 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (12) TO (14);
CREATE INDEX idx_loc_temp_p7 ON time_series.loc_temp_p7(event_time);

CREATE TABLE time_series.loc_temp_p8 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (14) TO (16);
CREATE INDEX idx_loc_temp_p9 ON time_series.loc_temp_p9(event_time);

CREATE TABLE time_series.loc_temp_p9 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (16) TO (18);
CREATE INDEX idx_loc_temp_p9 ON time_series.loc_temp_p9(event_time);

CREATE TABLE time_series.loc_temp_p10 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (18) TO (20);
CREATE INDEX idx_loc_temp_p10 ON time_series.loc_temp_p10(event_time);

CREATE TABLE time_series.loc_temp_p11 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (20) TO (22);
CREATE INDEX idx_loc_temp_p11 ON time_series.loc_temp_p11(event_time);

CREATE TABLE time_series.loc_temp_p12 PARTITION OF time_series.location_temp_p 
  FOR VALUES FROM (22) TO (24);
CREATE INDEX idx_loc_temp_p12 ON time_series.loc_temp_p12(event_time);

INSERT INTO time_series.location_temp_p 
  (event_time, event_hour, temp_celcius, location_id)
  (SELECT event_time, extract(hour from event_time), temp_celcius, location_id
  FROM time_series.location_temp);

EXPLAIN SELECT location_id, avg(temp_celcius)
FROM time_series.location_temp 
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';

EXPLAIN SELECT location_id, avg(temp_celcius)
FROM time_series.location_temp_p  
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY location_id;

EXPLAIN SELECT location_id, avg(temp_celcius)
FROM time_series.location_temp_p  
WHERE event_hour BETWEEN 0 AND 4
GROUP BY location_id;

EXPLAIN SELECT location_id, avg(temp_celcius)
FROM time_series.location_temp_p  
WHERE event_time BETWEEN '2019-03-04' AND '2019-03-05'
GROUP BY location_id;


