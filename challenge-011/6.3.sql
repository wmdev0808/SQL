-- Frame offset functions

SELECT	species, 
		name,
		checkup_time,
		weight,
		(weight - 	LAG (weight) 
					OVER (PARTITION BY species, name 
						  ORDER BY checkup_time ASC
						 )
		) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

/* Show weight gain over the past 3 months. */
SELECT	species, 
		name,
		checkup_time,
		weight,
		(weight - 	FIRST_VALUE (weight) 
					OVER (PARTITION BY species, name 
						  ORDER BY checkup_time ASC
						  RANGE BETWEEN 	'3 months' PRECEDING 
						  					AND 
						  					CURRENT ROW
						 )
		) AS weight_gain_since_up_to_3_months_ago
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;/*Incorrect*/

SELECT	species, 
		name,
		checkup_time,
		weight,
		(weight - 	FIRST_VALUE (weight) 
					OVER (PARTITION BY species, name 
						  ORDER BY checkup_time ASC
						  RANGE BETWEEN 	'3 months' PRECEDING 
						  					AND 
						  					'3 months' PRECEDING
						 )
		) AS weight_gain_from_exactly_3_mon ths_ago
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;/*Incorrect*/

SELECT (current_timestamp - interval '3 months') AS three_months_ago__before_Covid19__;

SELECT	species, 
		name,
		checkup_time,
		weight,
		(weight - 	FIRST_VALUE (weight) 
					OVER(	PARTITION BY species, name 
							ORDER BY CAST (checkup_time AS DATE) ASC
							RANGE BETWEEN 	'3 months' PRECEDING 
											AND 
											'3 months' PRECEDING
						)
		) AS weight_gain_from_3_months_ago_to_the_day
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC; /*Incorrect*/

SELECT	species, 
		name,
		checkup_time,
		weight,
		(weight - 	FIRST_VALUE (weight) 
					OVER (PARTITION BY species, name 
						  ORDER BY CAST (checkup_time AS DATE) ASC
						  RANGE BETWEEN 	'3 months' PRECEDING 
											AND 
											'1 day' PRECEDING
						 )
		) AS weight_gain_in_3_months
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		(weight - 	FIRST_VALUE (weight) 
					OVER (PARTITION BY species, name 
						  ORDER BY CAST (checkup_time AS DATE) ASC
						  RANGE BETWEEN 	'3 months' PRECEDING 
											AND 
											'1 day' PRECEDING
						 )
		) AS weight_gain_in_3_months
FROM 	routine_checkups
ORDER BY ABS (weight_gain_in_3_months) DESC;/* Error: cannot use an alias in a function in the same query */

WITH
weight_gains
AS
(
SELECT	species, 
		name,
		checkup_time,
		weight,
		(weight - 	FIRST_VALUE (weight) 
						OVER (PARTITION BY species, name 
							  ORDER BY CAST (checkup_time AS DATE) ASC
							  RANGE BETWEEN 	'3 months' PRECEDING 
												AND 
												'1 day' PRECEDING
							 )
		) AS weight_gain_in_3_months
FROM 	routine_checkups
)
SELECT 	*
FROM 	weight_gains
ORDER BY ABS (weight_gain_in_3_months) DESC NULLS LAST;

WITH weight_gains
AS
(
SELECT	species, 
		name,
		checkup_time,
		weight,
		(weight - 	FIRST_VALUE (weight) 
						OVER (PARTITION BY species, name 
							  ORDER BY CAST (checkup_time AS DATE) ASC
							  RANGE BETWEEN 	'3 months' PRECEDING 
												AND 
												'1 day' PRECEDING
							 )
		) AS weight_gain_in_3_months
FROM 	routine_checkups
),
include_percentage
AS
(
SELECT 	*,
		CAST (100 * weight_gain_in_3_months / weight 
			 AS DECIMAL (5, 2)
			 ) AS percent_change
FROM 	weight_gains
)
SELECT 	*
FROM 	include_percentage
WHERE 	percent_change IS NOT NULL
ORDER BY ABS (percent_change) DESC;

