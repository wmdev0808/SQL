-- Exploration
SELECT * FROM vaccinations v;
SELECT * FROM animals a;
SELECT * FROM adoptions a2;

-- SOLUTION STEPS --

-- STEP 1 
-- Calculate the vaccinations per year per species
-- STEP 2
-- Calculate the animals per year.
	-- a. Calculate the number of admisions per year
	-- b. Calculate number of adoptions per year
	-- c. Combine the tables with a FULL OUTER JOIN and calculate tha animal variations per year
-- STEP 3
-- Join animals in shelters with vaccinations and calculate the average vaccinations/animal
-- STEP 4 
-- Calculate the rolling average and the percentage variation

-- EXECUTION --

-- STEP 1 
-- Calculate the vaccinations per year per species

WITH vaccinations_per_year AS (
	SELECT
		species,
		DATE_PART('year',vaccination_time) AS year,
		COUNT(*) AS number_of_vaccinations
	FROM
		vaccinations v
	GROUP BY
		species,
		DATE_PART('year',vaccination_time)
	ORDER BY 
		species
	)
-- SELECT * FROM vaccinations_per_year; -- Test
	
-- STEP 2
-- Calculate the animals per year.
	-- a. Calculate the number of admisions per year
	-- b. Calculate number of adoptions per year
	-- c. Combine the tables with a FULL OUTER JOIN and calculate tha animal variations per year


-- 2a. Admisions per year

, admisions_per_year AS (
	SELECT
		species,
		DATE_PART('year',admission_date) AS year,
		COUNT(*) AS number_of_admisions
	FROM
		animals a1 
	GROUP BY
		species,
		DATE_PART('year',admission_date)
	ORDER BY 
		species
	)
--SELECT * FROM admisions_per_year; -- Test

-- 2b. Adoptions per year

, adoptions_per_year AS (
	SELECT
		species,
		DATE_PART('year',adoption_date) AS year,
		COUNT(*) AS number_of_adoptions
	FROM
		adoptions a2 
	GROUP BY
		species,
		DATE_PART('year',adoption_date)
	ORDER BY 
		species
	)
--SELECT * FROM adoptions_per_year; -- Test
	
-- 2c. Combine the tables with a FULL OUTER JOIN and calculate tha animal variations per year
-- Here I wrapped the fields in COALESCE. This way, if there are no admisions or adoptions in one year, the field still appears

, animals_in_shelters AS (
SELECT
	COALESCE(adm.species,adp.species) AS species,
	COALESCE (adm.year,adp.year) AS year,
	COALESCE(adm.number_of_admisions,0) as number_of_admissions,
	COALESCE (adp.number_of_adoptions, 0) AS number_of_adoptions,
	(adm.number_of_admisions - COALESCE (adp.number_of_adoptions, 0)) AS animals_in_shelter_variation,
	SUM((adm.number_of_admisions - COALESCE (adp.number_of_adoptions, 0))) 
		OVER ( PARTITION BY adm.species
		ORDER BY COALESCE (adm.year,adp.year)
		ROWS BETWEEN 
		UNBOUNDED PRECEDING 
		AND
		CURRENT ROW
		) AS animals_in_shelter
FROM admisions_per_year AS adm
	FULL OUTER JOIN adoptions_per_year AS adp 
		ON adm.species = adp.species
		AND adm.year = adp.year
)
-- SELECT * FROM  animals_in_shelters ; -- Test

-- STEP 3
-- Join animals in shelters with vaccinations and calculate the average vaccinations/animal

, average_vaccinations_per_animal AS (
	SELECT
		ais.species,
		ais."year",
		vpy.number_of_vaccinations,
		ais.animals_in_shelter,
		CAST( (vpy.number_of_vaccinations / ais.animals_in_shelter) AS DECIMAL (5,2) ) AS average_vaccinations_per_animal
	FROM animals_in_shelters AS ais
		LEFT JOIN vaccinations_per_year AS vpy
			ON ais.species = vpy.species
			AND ais.year = vpy.year
	)

--SELECT * FROM average_vaccinations_per_animal; -- Test
	
-- STEP 4 
-- Calculate the rolling average and the percentage variation

SELECT 
	species,
	"year",
	number_of_vaccinations,
--	animals_in_shelter,
	average_vaccinations_per_animal,
	CAST( AVG(average_vaccinations_per_animal) OVER w AS DECIMAL (5,2) ) AS previous_2_years_average,
	CAST( (average_vaccinations_per_animal / AVG(average_vaccinations_per_animal) OVER w) *100 AS DECIMAL (5,2) ) AS percent_change
FROM average_vaccinations_per_animal
WINDOW w AS (
		PARTITION BY species 
		ORDER BY year
		RANGE BETWEEN 
		2 PRECEDING 
		AND 
		1 PRECEDING 
		)
;