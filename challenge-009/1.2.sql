USE Animal_Shelter; -- For SQL Server

-- CROSS JOIN
SELECT	* 
FROM	Staff 
		CROSS JOIN 
		Staff_Roles; 

-- INNER JOIN
SELECT	* 
FROM	Staff 
		INNER JOIN 
		Staff_Roles
		ON 1 = 1; /* This predicate is always true, so this query is equal to CROSS JOIN */
		
SELECT	*
FROM	Animals AS A
		CROSS JOIN 
		Adoptions AS AD;

SELECT	AD.*, A.Breed, A.Implant_Chip_ID
FROM	Animals AS A
		INNER JOIN 
		Adoptions AS AD
		ON	AD.Name = A.Name 
			AND 
			AD.Species = A.Species;

SELECT	AD.*, A.Breed, A.Implant_Chip_ID
FROM	Animals AS A
		LEFT OUTER JOIN 
		Adoptions AS AD
		ON	AD.Name = A.Name 
			AND 
			AD.Species = A.Species;

SELECT	AD.Adopter_Email, AD.Adoption_Date, 
		A.*
FROM	Animals AS A
		LEFT OUTER JOIN 
		Adoptions AS AD
		ON	AD.Name = A.Name 
			AND 
			AD.Species = A.Species;
