# SQL Data Cleaning

## Cleaning with String Functions

- `customer_data` table

  | first_name | last_name | phone_number |
  | ---------- | --------- | ------------ |
  | Alric      | Gouny     | 399-751-5387 |

- LEFT

  - Pull characters from the left side of the string and present them as a separate string

- RIGHT

  - Pull from the right side of the string and present as a separate string

- LENGTH
  - Pulls the length of a string

```
SELECT  first_name,
        last_name,
        phone_number,
        LEFT(phone_number, 3) AS area_code,
        RIGHT(phone_number, 8) AS phone_number_onlym
        RIGHT(phone_number, LENGTH(phone_number) - 4) AS phone_number_alt
FROM demo.customer_data
```

- Result =>

  | first_name | last_name | phone_number | area_code | phone_number_only | phone_number_alt |
  | ---------- | --------- | ------------ | --------- | ----------------- | ---------------- |
  | Alric      | Gouny     | 399-751-5387 | 399       | 751-5387          | 751-5387         |

  ...

## Cleaning With More Advanced String Functions

- customer_data

  | first_name | last_name | city_state     |
  | ---------- | --------- | -------------- |
  | Alric      | Gouny     | Cincinnati, OH |

- POSITION

  - Provides the position of a string counting from the left

- STRPOS

  - Provides the position of a string counting from the left

- Pro Tip

  - Position and string position are case censitive
  - If you want to look for a character regardless of its case, you can make the entire string upper or lower case.

- LOWER

  - force every character in a string to become lowercase.

- UPPER

  - make all the letters appear as uppercase.

```
SELECT  first_name,
        last_name,
        city_state,
        POSITION(',' IN city_state) AS comma_position,
        STRPOS(city_state, ',') AS substr_comma_position,
        LOWER(city_state) AS lowercase,
        UPPER(city_state) AS uppercase,
        LEFT(city_state, POSITION(',' IN city_state) - 1) AS city
FROM demo.customer_data
```

- Result =>

  | city_state     | comma_position | substr_comma_position | lowercase      | uppercase      | city       |
  | -------------- | -------------- | --------------------- | -------------- | -------------- | ---------- |
  | Cincinnati, OH | 11             | 11                    | cincinnati, oh | CINCINNATI, OH | Cincinnati |

## CONCAT

- Combines values from several columns into one column

- Pro Tip

  - Both 'CONCAT' and '||' can be used to concatenate strings together.

- Query

  ```
  SELECT first_name,
          last_name,
          CONCAT(first_name,' ',last_name) AS full_name,
          first_name || ' ' || last_name AS full_name_alt
  FROM demo.customer_data
  ```

- Result

  | first_name | last_name | full_name   | full_name_alt |
  | ---------- | --------- | ----------- | ------------- |
  | Alric      | Gouny     | Alric Gouny | Alric Gouny   |

## CAST

- Pro Tip

  - Remember dates in SQL are stored YYYY-MM-DD
  - We can use either 'CONCAT' or '||' to concatenate strings together

- TO_DATE

  - converts a formatted date string to a date integer
  - format
    ```
    TO_DATE ( string, format_mask, nls_language )
    ```

- CAST

  - Allows us to change columns from one data type to another

- Pro Tip

  - Both 'CAST' and '::' allow for the converting of one data type to another
  - LEFT, RIGHT, or SUBSTRING automatically cast data to a string data type

- Query

  ```
  SELECT *,
         DATE_PART('month', TO_DATE(month, 'month')) AS clean_month,
         year || '-' || DATE_PART('month', TO_DATE(month, 'month')) || '-' || day AS concatenated_date
         CAST(year || '-' || DATE_PART('month', TO_DATE(month, 'month')) || '-' || day AS date) AS formatted_date,
         (year || '-' || DATE_PART('month', TO_DATE(month, 'month')) || '-' || day)::date AS formatted_date_alt
  FROM demo.ad_clicks

  ```

- Result

  | month   | day | year | clicks | clean_month | concatenated_date | formatted_date | formatted_date_alt |
  | ------- | --- | ---- | ------ | ----------- | ----------------- | -------------- | ------------------ |
  | January | 1   | 2014 | 1135   | 1           | 2014-1-1          | 2014-01-01     | 2014-01-01         |

## COALESCE

- Use case

  - Occasionally, you'll end up with a data set that has some nulls that you'd prefer to contain actual values.

  - Looking at the accounts table, you might want to clearly label a no primary point of contact as no POC, so the results will be easily understandable.

  - In cases like this, you can use coalesce to replace the null values.

- COALESCE function

  - Returns the first non-null value passed for each row

- Query

  ```
  SELECT *,
         COALESCE(primary_poc, 'no POC') AS primary_poc_modified
  FROM demo.accounts
  WHERE primary_poc IS NULL
  ```

- Result

  | id   | name  | website       | lat         | long         | primary_poc | sales_rep_id | primary_poc_modified |
  | ---- | ----- | ------------- | ----------- | ------------ | ----------- | ------------ | -------------------- |
  | 1501 | Intel | www.intel.com | 41.03153857 | -74.66846407 |             | 321580       | no POC               |

- Pro Tip

  - Using "COALESCE", we filled the NULL values and now get a value in every cell

- Query

  ```
  SELECT COUNT(primary_poc) AS regular_count,
         COUNT(COALESCE(primary_poc, 'no POC')) AS modified_count
  FROM demo.accounts
  ```

- Result

  | regular_count | modified_count |
  | ------------- | -------------- |
  | 345           | 354            |

## Data Cleaning Conclusion
