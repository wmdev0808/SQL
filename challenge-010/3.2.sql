-- Multi level aggregates
-- Number of annual, monthly, and overall adoptions.
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date);

SELECT	YEAR(Adoption_Date) AS Year,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date);

SELECT	COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY ();

-- Add UNION ALL... no good
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
UNION ALL
SELECT	YEAR(Adoption_Date) AS Year,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date)
UNION ALL
SELECT	COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY ();

-- Try string placeholders... no good
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Number_Of_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
UNION ALL
SELECT	YEAR(Adoption_Date) AS Year,
		'All Months' AS Month,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date)
UNION ALL
SELECT	'All Years' AS Year,	
		'All Months' AS Month,
		COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY ()
ORDER BY Year, Month;

-- Use NULL placeholders... very good!
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
UNION ALL
SELECT	YEAR(Adoption_Date) AS Year,
		NULL AS Month,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date)
UNION ALL
SELECT	NULL AS Year,	
		NULL AS Month,
		COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY ()
ORDER BY Year, Month;

-- Reuse lowest granularity aggregate in WITH clause
WITH Aggregated_Adoptions
AS
(
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
)
SELECT	*
FROM	Aggregated_Adoptions
UNION ALL
SELECT	Year,
		NULL,
		COUNT(*)
FROM	Aggregated_Adoptions
GROUP BY Year
UNION ALL
SELECT	NULL,
		NULL,
		COUNT(*)
FROM	Aggregated_Adoptions
GROUP BY ();


/* PostgreSQL
-- Reuse lowest granularity aggregate in WITH clause
WITH Aggregated_Adoptions
AS
(
SELECT	EXTRACT(year FROM Adoption_Date) AS Year,
		EXTRACT(month FROM Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY EXTRACT(year FROM Adoption_Date) , EXTRACT(month FROM Adoption_Date)
)
SELECT	*
FROM	Aggregated_Adoptions
UNION ALL
SELECT	Year,
		NULL,
		COUNT(*)
FROM	Aggregated_Adoptions
GROUP BY Year
UNION ALL
SELECT	NULL,
		NULL,
		COUNT(*)
FROM	Aggregated_Adoptions
GROUP BY ();
*/

-- GROUPING SETS
-- Equivalent to no GROUP BY
SELECT	COUNT(*) AS Total_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			()
		);

-- Equivalent to GROUP BY YEAR(Adoption_Date)
SELECT	YEAR(Adoption_Date) AS Year,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			YEAR(Adoption_Date)
		)
ORDER BY Year;

-- Equivalent to GROUP BY YEAR(Adoption_Date), MONTH(Adoption_Date)
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			(
				YEAR(Adoption_Date), MONTH(Adoption_Date)
			)
		)
ORDER BY Year, Month;

-- Be careful with the parentheses!
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			YEAR(Adoption_Date), MONTH(Adoption_Date)
		)
ORDER BY Year, Month;

-- All in one...
SELECT	YEAR(Adoption_Date) AS Year,
		MONTH(Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			(YEAR(Adoption_Date), MONTH(Adoption_Date)),
			YEAR(Adoption_Date),
			()
		)
ORDER BY Year, Month;

/* PostgreSQL
-- All in one...
SELECT	EXTRACT(year FROM Adoption_Date) AS Year,
		EXTRACT(month FROM Adoption_Date) AS Month,
		COUNT(*) AS Monthly_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			(EXTRACT(year FROM Adoption_Date), extract(month FROM Adoption_Date)),
			EXTRACT(year FROM Adoption_Date),
			()
		)
ORDER BY Year, Month;
*/

-- Non hierarchical grouping sets
SELECT	YEAR(Adoption_Date) AS Year,
		Adopter_Email,
		COUNT(*) AS Annual_Adoptions
FROM	Adoptions
GROUP BY GROUPING SETS	
		(
			YEAR(Adoption_Date),
			Adopter_Email
		);

-- Handling NULLs
SELECT	COALESCE(Species, 'All') AS Species,
		CASE 
			WHEN GROUPING(Breed) = 1
			THEN 'All'
			ELSE Breed
		END AS Breed,
		GROUPING(Breed) AS Is_This_All_Breeds,
		COUNT(*) AS Number_Of_Animals
FROM	Animals
GROUP BY GROUPING SETS 
		(
			Species,
			Breed,
			()
		)
ORDER BY Species, Breed;