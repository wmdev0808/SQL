-- OVER ()

SELECT 	species, 
		name, 
		primary_color, 
		admission_date
FROM 	animals
ORDER BY admission_date ASC;

/*Total number of animals in our shelter ever. Before window function*/
SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		(	SELECT COUNT (*) 
			FROM animals
		) AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC;
/*With window function*/
SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER () AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC;

-- FILTER
/* Total number of animals in our shelter since 2017 */
SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals
			WHERE 	admission_date >= '2017-01-01'
		) AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC; /*Not correct*/

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals
			WHERE 	admission_date >= '2017-01-01' -- duplicated predicate
		) AS number_of_animals
FROM 	animals
WHERE 	admission_date >= '2017-01-01' -- We need to duplicate the predicate
ORDER BY admission_date ASC;

/*With window function*/
SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*)
		FILTER (WHERE admission_date >= '2017-01-01') -- Add FILTER clause
		OVER () AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC;/*Fitlered count is 75, but the returned query is still 100*/

/*With window function, just adding WHERE is enough without duplicating the predicate*/
SELECT 	species,
		name, 
		primary_color, 
		admission_date,
		COUNT (*)
		OVER () AS number_of_animals
FROM 	animals	
WHERE 	admission_date >= '2017-01-01'
ORDER BY admission_date ASC;