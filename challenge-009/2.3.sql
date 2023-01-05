USE Animal_Shelter; -- For SQL Server

SELECT	*
FROM	Animals
WHERE	Breed = NULL;/*Incorrect: empty result*/

SELECT	*
FROM	Animals
WHERE	Breed != NULL;/*Incorrect: empty result*/

SELECT	*
FROM	Animals
WHERE	Breed = NULL 
		OR 
		Breed != NULL; /*Incorrect: empty result*/

SELECT	*
FROM	Animals
WHERE	Breed = 'Bullmastiff' 
		OR 
		Breed != 'Bullmastiff';/*Incorrect: does not include NULL breed*/

SELECT	*
FROM	Animals
WHERE	Breed IS NULL;/*Correct*/

SELECT	*
FROM	Animals
WHERE	Breed IS NOT NULL;/*Correct*/

SELECT	*
FROM	Animals
WHERE	Breed != 'Bullmastiff';

SELECT	*
FROM	Animals
WHERE	Breed != 'Bullmastiff'
		OR 
		Breed IS NULL;/*Correct: also include NULL breed*/
		
SELECT 	*
FROM 	Animals
WHERE 	ISNULL(Breed, 'Some value') != 'Bullmastiff';/*Correct*/

/* PostgreSQL

-- https://dbfiddle.uk/?rdbms=postgres_12&fiddle=604141955f380c713f4ffce0bcdda1a7&hide=2

-- distinct predicate
SELECT	*
FROM	Animals
WHERE	Breed IS DISTINCT FROM 'Bullmastiff';

-- trust test
SELECT	*
FROM	Animals
WHERE	(Breed = 'Bullmastiff') IS NOT TRUE;
*/
