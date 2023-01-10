/* Loading Data */

COPY time_series.utilization(event_time, server_id, cpu_utilization, free_memory, session_cnt)
FROM '/Users/dev/data/utilization.txt' DELIMITER ','

