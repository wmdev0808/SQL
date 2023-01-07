-- Routine Checkups
SELECT 	*
FROM	routine_checkups;


/*
  Return an animal's species, name, checkup time, heart rate, and a Boolean column that is TRUE only for animals which all of their heart rate measurements were either equal to, or larger than the average heart rate for their species.
*/
-- Average species heart rates
SELECT 	species, 
		name,
		checkup_time, 
		heart_rate,
		CAST (
				AVG (heart_rate) 
				OVER (PARTITION BY species)
			 AS DECIMAL (5, 2)
			 ) AS species_average_heart_rate -- CAST to DECIMAL for prettier presentation
FROM	routine_checkups
ORDER BY 	species ASC,
			checkup_time ASC;

-- Nesting attempt
/*Use EVERY Boolean aggregate function
  Boolean aggregate window functions elements are logical predicates
*/
SELECT 	species, 
		name, 
		checkup_time, 
		heart_rate,
		EVERY (Heart_rate >= 	AVG (heart_rate) 
								OVER (PARTITION BY species)
				) 
		OVER (PARTITION BY species, name) AS consistently_at_or_above_average
FROM	routine_checkups
ORDER BY 	species ASC,
			checkup_time ASC; /*Error: window function calls cannot be nested*/

-- Split with CTE
WITH species_average_heart_rates
AS
(
SELECT 	species,
		name, 
		checkup_time, 
		heart_rate, 
		CAST (
					AVG (heart_rate) 
					OVER (PARTITION BY species) 
				AS DECIMAL (5, 2)
			 ) AS species_average_heart_rate
FROM	routine_checkups
)
SELECT	species,
		name, 
		checkup_time, 
		heart_rate,
		EVERY (heart_rate >= species_average_heart_rate) 
		OVER (PARTITION BY species, name) AS consistently_at_or_above_average
FROM 	species_average_heart_rates
ORDER BY 	species ASC,
			checkup_time ASC;

-- Use as filter attempt
WITH species_average_heart_rates
AS
(
SELECT 	species, 
		name, 
		checkup_time, 
		heart_rate, 
		AVG (heart_rate) 
		OVER (PARTITION BY species) AS species_average_heart_rate
FROM	routine_checkups
)
SELECT	species, 
		name, 
		checkup_time, 
		heart_rate
FROM 	species_average_heart_rates
WHERE 	EVERY (heart_rate >= species_average_heart_rate) 
		OVER (PARTITION BY species, name)
ORDER BY 	species ASC,
			checkup_time ASC;/* Error: windows functions are not allowed in WHERE */

-- Separate into CTEs
WITH species_average_heart_rates
AS
(
SELECT 	species, 
		name, 
		checkup_time, 
		heart_rate, 
		CAST (	AVG (heart_rate) 
				OVER (PARTITION BY species) 
			 AS DECIMAL (5, 2)
			 ) AS species_average_heart_rate
FROM	routine_checkups
),
with_consistently_at_or_above_average_indicator
AS
(
SELECT	species, 
		name, 
		checkup_time, 
		heart_rate,
		species_average_heart_rate,
		EVERY (heart_rate >= species_average_heart_rate) 
		OVER (PARTITION BY species, name) AS consistently_at_or_above_average
FROM 	species_average_heart_rates
)
SELECT 	DISTINCT species,
		name,
		heart_rate,
		species_average_heart_rate
FROM 	with_consistently_at_or_above_average_indicator
WHERE 	consistently_at_or_above_average
ORDER BY 	species ASC,
			heart_rate DESC;

