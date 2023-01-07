-- Row offset functions
/* Show animal checkups, and how much weight they gained since the last checkup. */
SELECT	species, 
		name,
		checkup_time,
		weight
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight) 
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight,1 , 'N/A') 
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC; /*Error: invalid input syntax for type numeric: "N/A" */

SELECT	species, 
		name,
		checkup_time,
		weight,
		COALESCE (weight - LAG(weight) 
						   OVER (PARTITION BY species, name 
						         ORDER BY checkup_time ASC
						        )
				 , 'N/A'
				 ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;

SELECT	species, 
		name,
		checkup_time,
		weight,
		COALESCE (CAST (100 * (weight - LAG (weight) 
										OVER (PARTITION BY species, name 
											  ORDER BY checkup_time ASC
											  )
							  ) 
						AS VARCHAR(10)
						)
				  , 'N/A'
				 ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC,
			weight_gain ASC;/* Bug: Messing with data types will forever haunt your application... sorted by string not number, such as -20.0, -40.0, 20.0... */

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight, 1, 0) 
				 OVER (PARTITION BY species, name 
				       ORDER BY checkup_time ASC
				      ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC; /* function lag(numeric, integer, integer) does not exist */

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight, 1, 0.0) 
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;/* Incorrect */

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight, 1, weight) 
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC;/* Incorrect */

SELECT	species, 
		name,
		checkup_time,
		weight,
		weight - LAG (weight)
				 OVER (PARTITION BY species, name 
				 	   ORDER BY checkup_time ASC
				 	  ) AS weight_gain
FROM 	routine_checkups
ORDER BY 	species ASC, 
			name ASC, 
			checkup_time ASC; /* NULL is the best one for missing data */

