/* Loading Data */

COPY time_series.location_temp(event_time, location_id, temp_celcius)
FROM '/Users/dev/data/location_temp.txt' DELIMITER ',';

