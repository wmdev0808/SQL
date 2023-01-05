USE Animal_Shelter; -- For SQL Server

SELECT	*
FROM	Animals 
WHERE	Species = 'Dog'	
		AND 
		Breed <> 'Bullmastiff'; /*Incorrect logically: Breed with NULL are unapplicable*/

SELECT	*
FROM	Persons
WHERE	Birth_Date <> '20000101';
