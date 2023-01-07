SELECT 	species, 
		name, 
		COUNT (*) AS number_of_checkups,
		ROW_NUMBER () 
		OVER (	PARTITION BY species 
		 		ORDER BY COUNT(*) DESC
		 	 ) AS row_number
FROM	routine_checkups
GROUP BY 	species,
			name
ORDER BY 	species, 
			number_of_checkups DESC;

WITH all_ranks
AS
(
SELECT 	species, 
		name, 
		COUNT (*) AS number_of_checkups,
		ROW_NUMBER () OVER W AS row_number,
		RANK () OVER W AS rank,
		DENSE_RANK () OVER W AS dense_rank
FROM	routine_checkups
GROUP BY species, name
WINDOW 	W AS 	(PARTITION BY species 
				 ORDER BY COUNT(*) DESC
				)
)
SELECT 	species,
		name,
		number_of_checkups
FROM	all_ranks
WHERE 	row_number <= 3
ORDER BY 	species,
			number_of_checkups DESC;

WITH all_ranks
AS
(
SELECT 	species, 
		name, 
		COUNT (*) AS number_of_checkups,
		ROW_NUMBER () 
		OVER W AS row_number,
		RANK () 
		OVER W AS rank,
		DENSE_RANK () 
		OVER W AS dense_rank
FROM	routine_checkups
GROUP BY species, name
WINDOW 	W AS 	(PARTITION BY species 
				 ORDER BY COUNT(*) DESC
				)
)
SELECT 	species,
		name,
		number_of_checkups
FROM	all_ranks
WHERE 	rank <= 3
ORDER BY 	species,
			number_of_checkups DESC;

/*All animals whose number of checkups is in the top 3 distinct number of checkups per species*/
WITH all_ranks
AS
(
SELECT 	species, 
		name, 
		COUNT (*) AS number_of_checkups,
		ROW_NUMBER () 
		OVER W AS row_number,
		RANK () 
		OVER W AS rank,
		DENSE_RANK () 
		OVER W AS dense_rank
FROM	routine_checkups
GROUP BY species, name
WINDOW 	W AS 	(PARTITION BY species 
				 ORDER BY COUNT(*) DESC
				)
)
SELECT 	species,
		name,
		number_of_checkups
FROM	all_ranks
WHERE 	dense_rank <= 3
ORDER BY 	species,
			number_of_checkups DESC;
