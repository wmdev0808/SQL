USE Animal_Shelter; -- For SQL Server

SELECT	Adopter_Email,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
GROUP BY Adopter_Email
ORDER BY Number_Of_Adoptions DESC;

SELECT	Adopter_Email,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
WHERE	COUNT(*) > 1
GROUP BY Adopter_Email
ORDER BY Number_Of_Adoptions DESC;/*Error: cannot put aggregate functions in WHERE clause*/

SELECT	Adopter_Email,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
GROUP BY Adopter_Email
HAVING	COUNT(*) > 1
ORDER BY Number_Of_Adoptions DESC;

SELECT	Adopter_Email,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
GROUP BY Adopter_Email
HAVING	COUNT(*) > 1 
		AND	
		Adopter_Email NOT LIKE '%gmail.com'
ORDER BY Number_Of_Adoptions DESC;

SELECT	Adopter_Email,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
WHERE	Adopter_Email NOT LIKE '%gmail.com'
GROUP BY Adopter_Email
HAVING	COUNT(*) > 1
ORDER BY Number_Of_Adoptions DESC;

SELECT	Adopter_Email,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
WHERE	Adopter_Email NOT LIKE '%gmail.com'
GROUP BY Adopter_Email
HAVING	COUNT(*) > 1
		AND 
		YEAR(Adoption_Date) = 2019
ORDER BY Number_Of_Adoptions DESC; /*Error*/
