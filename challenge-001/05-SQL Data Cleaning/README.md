# SQL Data Cleaning

- In this lesson, you will be learning a number of techniques to

  - Clean and re-structure messy data.
  - Convert columns to different data types.
  - Tricks for manipulating NULLs.

- This will give you a robust toolkit to get from raw data to clean data that's useful for analysis.

## Cleaning with String Functions

- `customer_data` table

  | first_name | last_name | phone_number |
  | ---------- | --------- | ------------ |
  | Alric      | Gouny     | 399-751-5387 |

- LEFT

  - pulls a specified number of characters for each row in a specified column starting at the beginning (or from the left). As you saw here, you can pull the first three digits of a phone number using `LEFT(phone_number, 3)`.

- RIGHT

  - pulls a specified number of characters for each row in a specified column starting at the end (or from the right). As you saw here, you can pull the last eight digits of a phone number using `RIGHT(phone_number, 8)`.

- LENGTH
  - provides the number of characters for each row of a specified column. Here, you saw that we could use this to get the length of each phone number as `LENGTH(phone_number)`.

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

  - takes a character and a column, and provides the index where that character is for each row. The index of the first position is 1 in SQL. If you come from another programming language, many begin indexing at 0. Here, you saw that you can pull the index of a comma as `POSITION(',' IN city_state)`.

- STRPOS

  - provides the same result as `POSITION`, but the syntax for achieving those results is a bit different as shown here: `STRPOS(city_state, ',')`.

- Pro Tip

  - Note, both `POSITION` and `STRPOS` are case sensitive, so looking for `A` is different than looking for `a`.
  - Therefore, if you want to pull an index regardless of the case of a letter, you might want to use `LOWER` or `UPPER` to make all of the characters lower or uppercase.

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

## CONCAT, Piping ||

- Combines values from several columns into one column
- Each of these will allow you to combine columns together across rows. In this video, you saw how first and last names stored in separate columns could be combined together to create a full name: `CONCAT(first_name, ' ', last_name)` or with piping as `first_name || ' ' || last_name`.

- Pro Tip

  - Both `CONCAT` and `||` can be used to concatenate strings together.

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

## CAST, TO_DATE, ::

- `DATE_PART('month', TO_DATE(month, 'month'))` here changed a month name into the number associated with that particular month.

- Then you can change a string to a date using `CAST`. `CAST` is actually useful to change lots of column types. Commonly you might be doing as you saw here, where you change a `string` to a `date` using `CAST(date_column AS DATE)`. However, you might want to make other changes to your columns in terms of their data types. You can see other examples [here](http://www.postgresqltutorial.com/postgresql-cast/).

  - In this example, you also saw that instead of `CAST(date_column AS DATE)`, you can use `date_column::DATE`.

- Expert Tip

  - Most of the functions presented in this lesson are specific to strings. They won’t work with dates, integers or floating-point numbers. However, using any of these functions will automatically change the data to the appropriate type.

  - `LEFT`, `RIGHT`, and `TRIM` are all used to select only certain elements of strings, but using them to select elements of a number or date will treat them as strings for the purpose of the function. Though we didn't cover `TRIM` in this lesson explicitly, it can be used to remove characters from the beginning and end of a string. This can remove unwanted spaces at the beginning or end of a row that often happen with data being moved from Excel or other storage systems.

  - There are a number of variations of these functions, as well as several other string functions not covered here. Different databases use subtle variations on these functions, so be sure to look up the appropriate database’s syntax if you’re connected to a private database.The [Postgres literature](http://www.postgresql.org/docs/9.1/static/functions-string.html) contains a lot of the related functions.

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

  - Both `CAST` and `::` allow for the converting of one data type to another
  - `LEFT`, `RIGHT`, or `SUBSTRING` automatically cast data to a string data type

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

  - Occasionally, you'll end up with a data set that has some `NULL`s that you'd prefer to contain actual values.

  - Looking at the accounts table, you might want to clearly label a no primary point of contact as no POC, so the results will be easily understandable.

  - In cases like this, you can use coalesce to replace the `NULL` values.

- `COALESCE` function

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

  - Using `COALESCE`, we filled the `NULL` values and now get a value in every cell

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

- You now have a number of tools to assist in cleaning messy data in SQL. Manually cleaning data is tedious, but you now can clean data at scale using your new skills.

- There are a few other functions that work similarly. You can read more about those [here](https://www.w3schools.com/sql/sql_isnull.asp). You can also get a walk through of many of the functions you have seen throughout this lesson [here](https://mode.com/resources/sql-tutorial/sql-string-functions-for-cleaning).

### SQL NULL Functions

#### SQL IFNULL(), ISNULL(), COALESCE(), and NVL() Functions

- `Products` table:

| P_Id | ProductName | UnitPrice | UnitsInStock | UnitsOnOrder |
| ---- | ----------- | --------- | ------------ | ------------ |
| 1    | Jarlsberg   | 10.45     | 16           | 15           |
| 2    | Mascarpone  | 32.56     | 23           |              |
| 3    | Gorgonzola  | 15.67     | 9            | 20           |

- Suppose that the `UnitsOnOrder` column is optional, and may contain `NULL` values.

  ```
  SELECT ProductName, UnitPrice * (UnitsInStock + UnitsOnOrder)
  FROM Products;
  ```

  - In the example above, if any of the `UnitsOnOrder` values are `NULL`, the result will be `NULL`.

- Solutions

  - MySQL

    - The MySQL `IFNULL()` function lets you return an alternative value if an expression is `NULL`:

      ```
      SELECT ProductName, UnitPrice * (UnitsInStock + IFNULL(UnitsOnOrder, 0))
      FROM Products;
      ```

    - or we can use the `COALESCE()` function, like this:

      ```
      SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
      FROM Products;
      ```

  - SQL Server

    - The SQL Server `ISNULL()` function lets you return an alternative value when an expression is `NULL`:

      ```
      SELECT ProductName, UnitPrice * (UnitsInStock + ISNULL(UnitsOnOrder, 0))
      FROM Products;
      ```

    - or we can use the `COALESCE()` function, like this:

      ```
      SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
      FROM Products;
      ```

  - MS Access

    - The MS Access `IsNull()` function returns TRUE (-1) if the expression is a null value, otherwise FALSE (0):

      ```
      SELECT ProductName, UnitPrice * (UnitsInStock + IIF(IsNull(UnitsOnOrder), 0, UnitsOnOrder))
      FROM Products;
      ```

  - Oracle

    - The Oracle `NVL()` function achieves the same result:

      ```
      SELECT ProductName, UnitPrice * (UnitsInStock + NVL(UnitsOnOrder, 0))
      FROM Products;
      ```

    - or we can use the `COALESCE()` function, like this:

      ```
      SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
      FROM Products;
      ```

### Using SQL String Functions to Clean Data

#### SUBSTR

- `LEFT` and `RIGHT` both create substrings of a specified length, but they only do so starting from the sides of an existing string. If you want to start in the middle of a string, you can use `SUBSTR`. The syntax is `SUBSTR(*string*, *starting character position*, *# of characters*)`:

  ```
  SELECT incidnt_num,
       date,
       SUBSTR(date, 4, 2) AS day
  FROM tutorial.sf_crime_incidents_2014_01
  ```
