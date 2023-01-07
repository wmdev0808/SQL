/* Species added to ORDER BY for visual reference */
SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		(	SELECT COUNT (*) 
			FROM animals
		) AS number_of_animals
FROM 	animals
ORDER BY 	species ASC, 
			admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER () AS number_of_animals
FROM 	animals
ORDER BY 	species ASC, 
			admission_date ASC;

-- PARTITION BY
/* Number of species animals instead of total animals */
/*Subquery: use correlation between parent query and subquery*/
SELECT 	a1.species, 
		a1.name, 
		a1.primary_color, 
		a1.admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals AS a2
			WHERE 	a2.species = a1.species
		) AS number_of_species_animals
FROM 	animals AS a1
ORDER BY 	a1.species ASC, 
			a1.admission_date ASC;

/*Window function*/
SELECT 	species,
		name,
		primary_color,
		admission_date,
		COUNT (*) 
		OVER (PARTITION BY species) AS number_of_species_animals
FROM 	animals
ORDER BY 	species ASC, 
			admission_date ASC;
/*Performance perspective:
  Subquery solution: 340.57
  Window function solution: 11.39
*/

-- Optimized subquery solution

SELECT 	a.species, 
		a.name, 
		a.primary_color, 
		a.admission_date,
		species_counts.number_of_species_animals
FROM 	animals AS a
		INNER JOIN 
		(	SELECT 	species,
					COUNT(*) AS number_of_species_animals
			FROM 	animals
			GROUP BY species
		) AS species_counts
		ON a.species = species_counts.species
ORDER BY 	a.species ASC,
			a.admission_date ASC;
/*Cost: 10.55*/