USE Animal_Shelter; -- For SQL Server

-- Using ordinal positions
SELECT	*
FROM	Animals
ORDER BY 2, 5, 1;

/* PostgreSQL

-- https://dbfiddle.uk/?rdbms=postgres_12&fiddle=1661d82a3969780042b28b139b2bb293&hide=2

SELECT	Species, COUNT(*)
FROM	Animals
GROUP BY 1
ORDER BY 2 DESC;
*/

-- Order by
SELECT	Adoption_Date, 
		Species, 
		Name
FROM	Adoptions
ORDER BY Adoption_Date DESC;

SELECT	Species, 
		Name
FROM	Adoptions
ORDER BY Adoption_Date DESC;

-- DISTINCT and ORDER BY
SELECT 	DISTINCT 
		Species, 
		Name
FROM	Adoptions
ORDER BY Adoption_Date DESC;/*Error: ORDER BY items must appear in the select list if SELECT DISTINCT is specified.*/

-- Tie breakers
SELECT	*
FROM	Animals
ORDER BY Species; /*Sorted using dictionary order*/

SELECT	*
FROM	Animals
ORDER BY Species, Name;

SELECT	*
FROM	Animals
ORDER BY Implant_Chip_ID;

-- NULL sorting goodies
SELECT	*
FROM	Animals
ORDER BY Breed;

SELECT	*
FROM	Animals
ORDER BY Breed DESC;

/* PostgreSQL and Oracle 

-- https://dbfiddle.uk/?rdbms=postgres_12&fiddle=62953002b268c424daa2f5d15838c36d&hide=2

SELECT	*
FROM	Animals
ORDER BY Breed NULLS LAST;
*/