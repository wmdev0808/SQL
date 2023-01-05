USE Animal_Shelter;

SELECT	A.Name,
		A.Species,
		A.Breed,
		A.Primary_Color,
		V.Vaccination_Time,
		V.Vaccine,
		P.First_Name,
		P.Last_Name,
		SA.Role
FROM	Animals AS A
		LEFT OUTER JOIN
		(	Vaccinations AS V
			INNER JOIN
			Staff_Assignments AS SA
				ON SA.Email = V.Email
			INNER JOIN
			Persons AS P
				ON P.Email = V.Email
		)
		ON	A.Name = V.Name
			AND
			A.Species = V.Species
ORDER BY A.Species, A.Name, A.Breed, V.Vaccination_Time DESC;