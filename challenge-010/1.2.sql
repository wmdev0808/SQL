-- Animals that were not adopted
-- Using OUTER JOIN, called Anti JOIN
SELECT	DISTINCT AN.Name, AN.Species
FROM	Animals AS AN
		LEFT OUTER JOIN
		Adoptions AS AD
			ON AD.Name = AN.Name AND AD.Species = AN.Species
WHERE	AD.Name IS NULL;

-- Using NOT EXISTS
SELECT	AN.Name, AN.Species
FROM	Animals AS AN
WHERE	NOT EXISTS	(
						SELECT	NULL
						FROM	Adoptions AS AD
						WHERE	AD.Name = AN.Name
								AND 
								AD.Species = AN.Species
					);
-- Row expressions
/* PostgreSQL row expressions
SELECT	Name, Species
FROM	Animals 
WHERE	(Name, Species) NOT IN (SELECT Name, Species FROM Adoptions);
*/

-- SQL Server "mimic row expressions" - Don't try this at home!
SELECT	Name, Species
FROM	Animals 
WHERE	CONCAT(Name, '|||', Species) 
			NOT IN 
			(SELECT CONCAT(Name, '|||', Species) FROM Adoptions);

-- The right way - Set Operators
SELECT	Name, Species
FROM	Animals
EXCEPT	
SELECT	Name, Species
FROM	Adoptions;

-- Animals that were adopted and vaccinated at least twice
SELECT	Name, Species
FROM	Adoptions
INTERSECT
SELECT	Name, Species
FROM	Vaccinations
GROUP BY Name, Species
HAVING	COUNT(*) > 1;