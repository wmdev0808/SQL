-- Start with a simple join
SELECT	*
FROM	Vaccinations AS V
		INNER JOIN
		Persons AS P
			ON P.Email = V.Email;

-- Add grouping sets and required columns (doesn't work yet)
SELECT	YEAR(V.Vaccination_Time) AS Year,
		V.Species,
		V.Email,
		P.First_Name,
		P.Last_Name,
		COUNT(*) AS Number_Of_Vaccinations,
		MAX(YEAR(V.Vaccination_Time)) AS Latest_Vaccination_Year -- yes, this is legit!
FROM	Vaccinations AS V
		INNER JOIN
		Persons AS P
			ON P.Email = V.Email
GROUP BY GROUPING SETS	(
							(),
							YEAR(V.Vaccination_Time),
							V.Species,
							(YEAR(V.Vaccination_Time), V.Species),
							V.Email,
							(V.Email, V.Species)
						);

-- Try to add dummy aggregates for first name and last name
SELECT	YEAR(V.Vaccination_Time) AS Year,
		V.Species,
		V.Email,
		MAX(P.First_Name) AS First_Name, -- Dummy aggregate
		MAX(P.Last_Name) AS Last_Name, -- Dummy aggregate
		COUNT(*) AS Number_Of_Vaccinations,
		MAX(YEAR(V.Vaccination_Time)) AS Latest_Vaccination_Year
FROM	Vaccinations AS V
		INNER JOIN
		Persons AS P
			ON P.Email = V.Email
GROUP BY GROUPING SETS	(
							(),
							YEAR(V.Vaccination_Time),
							V.Species,
							(YEAR(V.Vaccination_Time), V.Species),
							(V.Email),
							(V.Email, V.Species)
						);

-- Add NULL replacement with COALESCE, but what's wrong with first name and last name???
SELECT	COALESCE(CAST(YEAR(V.Vaccination_Time) AS VARCHAR(10)), 'All Years') AS Year,
		COALESCE(V.Species, 'All Species') AS Species,
		COALESCE(V.Email, 'All Staff') AS Email,
		COALESCE(MAX(P.First_Name), '') AS First_Name, -- Dummy aggregate
		COALESCE(MAX(P.Last_Name), '') AS Last_Name, -- Dummy aggregate
		COUNT(*) AS Number_Of_Vaccinations,
		MAX(YEAR(V.Vaccination_Time)) AS Latest_Vaccination_Year
FROM	Vaccinations AS V
		INNER JOIN
		Persons AS P
			ON P.Email = V.Email
GROUP BY GROUPING SETS	(
							(),
							YEAR(V.Vaccination_Time),
							V.Species,
							(YEAR(V.Vaccination_Time), V.Species),
							(V.Email),
							(V.Email, V.Species)
						);

-- Must use the GROUPING function to distinguish "All staff" from individuals
SELECT	COALESCE(CAST(YEAR(V.Vaccination_Time) AS VARCHAR(10)), 'All Years') AS Year,
		COALESCE(V.Species, 'All Species') AS Species,
		COALESCE(V.Email, 'All Staff') AS Email,
		CASE WHEN GROUPING(V.Email) = 0
			THEN MAX(P.First_Name) -- Dummy aggregate
			ELSE ''
			END AS First_Name,
		CASE WHEN GROUPING(V.Email) = 0
			THEN MAX(P.Last_Name) -- Dummy aggregate
			ELSE ''
			END AS Last_Name,
		COUNT(*) AS Number_Of_Vaccinations,
		MAX(YEAR(V.Vaccination_Time)) AS Latest_Vaccination_Year
FROM	Vaccinations AS V
		INNER JOIN
		Persons AS P
			ON P.Email = V.Email
GROUP BY GROUPING SETS	(
							(),
							YEAR(V.Vaccination_Time),
							V.Species,
							(YEAR(V.Vaccination_Time), V.Species),
							(V.Email),
							(V.Email, V.Species)
						)
ORDER BY Year, Species, First_Name, Last_Name;

/* PostgreSQL
SELECT	COALESCE(CAST(EXTRACT(YEAR FROM V.Vaccination_Time) AS VARCHAR(10)), 'All Years') AS Year,
		COALESCE(V.Species, 'All Species') AS Species,
		COALESCE(V.Email, 'All Staff') AS Email,
		CASE WHEN GROUPING(V.Email) = 0
			THEN MAX(P.First_Name) -- Dummy aggregate
			ELSE ' '
			END AS First_Name,
		CASE WHEN GROUPING(V.Email) = 0
			THEN MAX(P.Last_Name) -- Dummy aggregate
			ELSE ' '
			END AS Last_Name,
		COUNT(*) AS Number_Of_Vaccinations,
		MAX(EXTRACT(YEAR FROM V.Vaccination_Time)) AS Latest_Vaccination_Year
FROM	Vaccinations AS V
		INNER JOIN
		Persons AS P
			ON P.Email = V.Email
GROUP BY GROUPING SETS	(
							(),
							EXTRACT(YEAR FROM V.Vaccination_Time),
							V.Species,
							(EXTRACT(YEAR FROM V.Vaccination_Time), V.Species),
							(V.Email),
							(V.Email, V.Species)
						)
ORDER BY Year, V.Species NULLS FIRST, First_Name, Last_Name;
*/