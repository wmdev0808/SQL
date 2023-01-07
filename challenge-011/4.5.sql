WITH annual_vaccinations
AS
(
SELECT	CAST (DATE_PART ('year', vaccination_time) AS INT) AS year,
		COUNT (*) AS number_of_vaccinations
FROM 	vaccinations
GROUP BY DATE_PART ('year', vaccination_time)
)
-- SELECT * FROM annual_vaccinations ORDER BY year; -- Uncomment to execute preceding CTE
,annual_vaccinations_with_previous_2_year_average
AS
(
SELECT 	*,
		CAST (AVG (number_of_vaccinations) 
			   OVER (ORDER BY year ASC
					 RANGE BETWEEN 2 PRECEDING AND 1 PRECEDING 
					 -- Watch out for frame type...
					) 
			AS DECIMAL (5, 2)
			 )
		AS previous_2_years_average
FROM 	annual_vaccinations
-- WHERE year <> 2018 -- remove comment to check difference between ROWS and RANGE above
)
-- SELECT * FROM annual_vaccinations_with_previous_2_year_average ORDER BY year;
SELECT 	*,
		CAST ((100 * number_of_vaccinations / previous_2_years_average) 
			 AS DECIMAL (5, 2)
			 ) AS percent_change
FROM 	annual_vaccinations_with_previous_2_year_average
ORDER BY year ASC;

/*Alternative solution*/
WITH yearly_vaccination_count AS -- This CTE summarizes yearly vaccination
(
SELECT  CAST ( DATE_PART ('year', vaccination_time) AS INT) AS year,
        count (*) AS number_of_vaccinations
FROM    vaccinations
GROUP BY    DATE_PART ('year', vaccination_time)
)
SELECT  *,
        CAST(AVG (number_of_vaccinations) OVER W AS DECIMAL (5, 2)) AS previous_2_years_average, -- Use window function to calculate previous 2 year average number of vaccinations
        CAST(100 * (number_of_vaccinations / (AVG (number_of_vaccinations) OVER W ) - 1) AS DECIMAL (5, 2)) AS percent_change  -- Use window function to calculate percentage change
FROM    yearly_vaccination_count
WINDOW W AS (   ORDER BY year ASC
                RANGE BETWEEN   2 PRECEDING
                                AND
                                1 PRECEDING
            )
ORDER BY year ASC;