-- In case you forgot to cleanup the previous demos...
DELETE FROM Adoptions WHERE Name = 'Duplicate';
DELETE FROM Animals WHERE Name IN ('Duplicate', 'Ferris');

-- 1. Start with a simple CROSS JOIN
SELECT	*
FROM	Animals AS A1
		CROSS JOIN
		Animals AS A2;

-- 2. Filter for same species and breed
SELECT	*
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
			ON	A1.Species = A2.Species
				AND
				A1.Breed = A2.Breed;

-- 3. Replace * with required column names
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
			ON	A1.Species = A2.Species
				AND
				A1.Breed = A2.Breed
ORDER BY 	A1.Species, 
			A1.Breed;

-- 4. Add predicate or comment for future developers
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
			ON	A1.Species = A2.Species
				AND
				A1.Breed = A2.Breed -- Removes NULL breeds
				-- AND 
				-- A1.Breed IS NOT NULL -- 
ORDER BY 	A1.Species, 
			A1.Breed;

-- 5. Don't match animals with themselves.
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
			ON	A1.Species = A2.Species
				AND
				A1.Breed = A2.Breed -- Removes NULL breeds
				AND
				A1.Name <> A2.Name
ORDER BY 	A1.Species, 
			A1.Breed;

-- 6. Solution
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
		ON	A1.Species = A2.Species
			AND
			A1.Breed = A2.Breed -- Removes NULL breeds
			AND
			A1.Name <> A2.Name
			AND
			A1.Gender = 'M'
			AND 
			A2.Gender = 'F'
ORDER BY 	A1.Species, 
			A1.Breed;

-- 7. Solution with > shortcut 
-- 	  !!! Only works if collation is dictionary based, and if case insensitive or casing is consistent !!!
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
		ON	A1.Species = A2.Species
			AND
			A1.Breed = A2.Breed -- Removes NULL breeds
			AND
			A1.Name <> A2.Name
			AND
			A1.Gender > A2.Gender
ORDER BY 	A1.Species, 
			A1.Breed;