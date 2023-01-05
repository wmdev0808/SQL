USE Animal_Shelter; -- For SQL Server

-- Granular detail rows
SELECT	*
FROM	Adoptions;

-- How many were adopted?
SELECT	COUNT(*)	AS Number_Of_Adoptions
FROM	Adoptions;

-- But - beware!
SELECT	Name,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions; /* Error */

-- Granular detail rows
SELECT	*
FROM	Vaccinations;

SELECT		Species,
			COUNT(*)	AS Number_Of_Vaccinations
FROM		Vaccinations
GROUP BY	Species;

-- Number of vaccinations per animal
SELECT		Name,
			Species,
			COUNT(*)	AS Number_Of_Vaccinations
FROM		Vaccinations
GROUP BY	Name,
			Species;

-- Beware!
SELECT		Name,
			Species,
			Vaccine,
			COUNT(*)	AS Number_Of_Vaccinations
FROM		Vaccinations
GROUP BY	Name,
			Species;/*Error*/
