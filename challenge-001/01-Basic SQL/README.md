# Basic SQL

## Parch & Posey Database

- A Paper Company

## Entity Relationshhip Diagram

- ERD
  - Entity Relationship Diagram
  - ![Schema](./schema.png)

## Why Businesses Choose Databases

### Data Integrity

- Data integrity can make sure that the data entered is consistent
- Speed
- Concurrent users

## Types of Statements

### Statements

- Tell the database what you'd like to do with the data

  - CREATE
    - Is how you make a new table in the database
  - DROP
    - Is how you remove a table from the database

- SELECT
  - Allows you to read and display data

## SELECT & FROM Statements

- SELECT statement

  - Filling out a form to get a set of results

- The form has a set of questions

  - What data do you want to pull from?
  - Which elements from the database do you want to pull?

- These questions are structured in the same order every time

- FROM clause

  - Tells the query which table to use

- SELECT caluse
  - Tells the query which columns to use
  - \*(asterisk) means all

```
  SELECT *
    FROM orders
```

## LIMIT Statement

- Scan the first few rows of data to get an idea of which fields you care about
- Use the LIMIT clause as a way to keep queries from taking too long

## ORDER BY Statement

- "ORDER BY" clause will allow you to sort by date

  ```
  SELECT *
    FROM demo.orders
  ORDER BY occurred_at
  LIMIT 1000
  ```

- Add "DESC" after the column to flip the ordering

## WHERE Statements

- Allows you to filter a set of results based on specific criteria

  ```
  SELECT *
    FROM demo.orders
  WHERE account_id = 4251
  ORDER BY occurred_at
  LIMIT 1000
  ```

## WHERE with Non-Numeric Data

- Comparison Operators

  - Include =, !=(<>), >, and < as well as other tools for comparing columns/values

- Operators

  - If you're using an operator with values that are non-numeric, you need to put the value in single quotes

  ```
  SELECT *
    FRORM demo.accounts
  WHERE name != 'United Technologies'
  ```

## Arithmetic Operators

```
SELECT  account_id,
        occurred_at,
        standard_qty,
        gloss_qty,
        poster_qty,
        gloss_qty + poster_qty AS nonstandard_qty
FROM demo.orders
```

- Derived Column
  - A new column that is a manipulation of the existing columns in your database

## LIKE Operator

- Write a filter that will capture all web traffic using the "LIKE" operator

- If I just use an equals sign in the "WHERE" clause, you get back zero result.

```
SELECT *
  FROM demo.web_events_full
WHERE referrer_url LIKE '%google%'
```

- LIKE function requires wild cards
  - %: means a character or any number of characters

## IN Operator

- IN function allows you to filter data based on several possible values

  ```
  SELECT *
    FROM demo.accounts
  WHERE name IN('Walmart', 'Apple')
  ```

- "IN" requires single quotation marks around non-numerical data
- You have to put a comma in between each pair of distinct values

## NOT Operator

- Provides the inverse results for IN, LIKE, and similar operators

  ```
  SELECT sales_rep_id,
          name
    FROM demo.accounts
  WHERE sales_rep_id NOT IN(321500, 321570)
  ORDER BY sales_rep_id
  ```

  ```
  SELECT *
    FROM demo.web_events_full
  WHERE referrer_url NOT LIKE '%google%'
  ```

## AND & BETWEEN Operators

- AND

  - Filter based on multiple criteria using "AND"

  ```
  SELECT *
    FROM demo.orders
  WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01'
  ORDER BY occurred_at DESC
  ```

- BETWEEN

  - The BETWEEN operator is inclusive: begin and end values are included.

  ```
  SELECT * FROM Products
    WHERE Price BETWEEN 10 AND 20;
  ```

## OR Operator

```
SELECT account_id,
        occurred_at,
        standard_qty,
        gloss_qty,
        poster_qty
FROM demo.orders
WHERE standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0
```

## OR Statement

- OR can be combined with other operators by using parenthesis

```
SELECT account_id,
        occurred_at,
        standard_qty,
        gloss_qty,
        poster_qty
FROM demo.orders
WHERE (standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0)
  AND occurred_at >= '2016-10-01'
```

## Introduction to JOINs

## Why Not Store Everything in One Table

## Why Use Separate Tables

- JOINs
  - Orders and accounts are different types of objects
  - This allows queries to execute more quickly

## Your First JOIN

- INNER JOIN

  ```
  SELECT orders.*,
          accounts.*
    FROM demo.orders
    JOIN demo.accounts
      ON orders.account_id = accounts.id
  ```

- Tells query an additional table from which you would like to pull data
- ON
  - Specifies a logical statement to combine the table in from and join statements

## ALIAS

- Give table names ALIAS when performing JOINs
- The alias for a table will be created in the FROM or JOIN clauses
- You can now use this alias to replace the table name throughout the rest of the query

  ```
  SELECT o.*,
          a.*
    FROM demo.orders o
    JOIN demo.accounts a
      ON o.account_id = a.id
  ```

## JOINS

- INNER JOIN

  - Only returns rows that appear in both tables.

  ```
  SELECT a.id, a.name, o.total
    FROM orders o
      JOIN accounts a
        ON o.account_id = a.id
  ```

  - Orders

    | id  | account_id | total |
    | --- | ---------- | ----- |
    | 1   | **1001**   | 169   |
    | 2   | **1001**   | 288   |
    | 17  | **1011**   | 541   |
    | 18  | **1021**   | 539   |
    | 19  | **1021**   | 558   |
    | 24  | 1031       | 1363  |

  - Accounts

    | id       | name        |
    | -------- | ----------- |
    | **1001** | Walmart     |
    | **1011** | Exxon Mobil |
    | **1021** | Apple       |

## Other JOINs

- Types of Joins

  - Left Join

    ```
    SELECT
    FROM left table
    LEFT JOIN right table
    ```

  - Right Join

    ```
    SELECT a.id, a.name, o.total
    FROM orders o
    RIGHT JOIN accounts a
    ON o.account_id = a.id
    ```

  - Full Outer Join

## JOINs and Filtering

```
SELECT orders.*,
      accounts.*
  FROM demo.orders
  LEFT JOIN demo.accounts
    ON orders.account_id = accounts.id
  WHERE accounts.sales_rep_id = 321500
```

- Logic in the ON clause reduces the rows before combining the tables
- Logic in the WHERE clause occurs after the JOIN occurs

```
SELECT orders.*,
      accounts.*
  FROM demo.orders
  LEFT JOIN demo.accounts
    ON orders.account_id = accounts.id
    AND accounts.sales_rep_id = 321500
```

- This will pre-filter right table before JOIN
- These extra rows are because this is a left join.

## Introduction to Aggregations

- Count

  - Counts how many rows are in a particular column

- Sum

  - Add all values in a particular column

- Min and Max

  - Returns the lowest and highest values in a particular column

- Average
  - Calculates the average of all the values in a particular column

## NULLs

- NULLs means no data

## Data Types and NULLs

```
SELECT *
  FROM demo.accounts
WHERE primary_poc IS NULL
```

```
SELECT *
  FROM demo.accounts
WHERE primary_poc IS NOT NULL
```

- NULL is not data, is a property of data

## COUNT

```
SELECT COUNT(*) AS order_count
  FROM demo.orders
WHERE occurred_at >= '2016-12-01'
  AND occurred_at < '2017-01-01'
```

## COUNT & NULLs

- COUNT can help us identify the number of NULL values in any particular column

  ```
  SELECT COUNT(primary_poc) AS account_primary_poc_count
    FROM demo.accounts
  ```

- If the COUNT result of a column is less than the number of rows in the table, we know the difference is the number of NULLs

  ```
  SELECT *
    FROM demo.accounts
  WHERE primary_poc IS NULL
  ```

- We can use the COUNT function on any column in a table

## SUM

```
SELECT  SUM(standard_qty) AS standard,
        SUM(gloss_qty) AS gloss,
        SUM(poster_qty) AS poster
    FROM demo.orders
```

- You cannot use SUM(_) the way you can use COUNT(_)
- SUM is only for columns that have quantitative data.
- COUNT works on any column
- SUM treats NULL as 0

## MIN & MAX

```
SELECT  MIN(standard_qty) AS standard_min,
        MIN(gloss_qty) AS gloss_min,
        MIN(poster_qty) AS poster_min,
        MAX(standard_qty) AS standard_max,
        MAX(gloss_qty) AS gloss_max,
        MAX(poster_qty) AS poster_max
  FROM demo.orders
```

- MIN and MAX are similar to other aggregators in that they ignore NULL values

## AVG

```
SELECT  AVG(standard_qty) AS standard_avg,
        AVG(gloss_qty) AS glosss_avg,
        AVG(poster_qty) AS poster_avg
  FROM demo.orders
```

- keep in mind that it can only be used on numerical columns.
- Also, it ignores nulls completely, meaning that rows with null values are not counted in the numerator or the denominator when calculating the average.

  - If you want to treat nulls as zero, you'll need to take a sum and divide it by the count rather than just using the average function.

## GROUP BY

- Allows creating segments that will aggregate independent from one another

  ```
  SELECT account_id,
          SUM(standard_qty) AS standard_sum,
          SUM(gloss_qty) AS gloss_sum,
          SUM(poster_qty) AS poster_sum
    FROM demo.orders
    GROUP BY account_id
    ORDER_BY account_id
  ```

- "GROUP BY" clause goes in-between the "WHERE" AND "ORDER" clause
- Whenever there's a field in the Select statement that's not being aggregated, the query expects it to be in the GROUP BY clause.
  - A column that's not aggregated and not in the GROUP BY will return the error

## GROUP BY Part II

- GROUP BY and ORDER BY can be used with multiple columns in the same query

  ```
  SELECT account_id,
          channel,
          COUNT(id) AS events
    FROM demo.web_events
    GROUP BY account_id, channel
    ORDER BY account_id, channel
  ```

- The order in the ORDER BY determines which column is ordered on first
- You can order DESC for any column in your ORDER BY

  ```
  SELECT account_id,
          channel,
          COUNT(id) AS events
    FROM demo.web_events
    GROUP BY account_id, channel
    ORDER BY account_id, events DESC
  ```

## DISTINCT

- If you want to group by some columns but you don't necessarily want to include any aggregations, you can use DISTINCT instead.

  ```
  SELECT  DISTINCT account_id,
          channel
    FROM demo.web_events
  ORDER BY account_id
  ```

## HAVING

```
SELECT account_id,
        SUM(total_amt_used) AS sum_total_amt_usd
  FROM demo.orders
GROUP BY 1
HAVING SUM(total_amt_used) >= 250000
```

## DATE Functions I

```
SELECT occurred_at,
       SUM(standard_qty) AS standard_qty_sum
  FROM dem.orders
GROUP BY occurred_at
ORDER BY occurred_at
```

- Date formats sorted oldest to newest based on alphabetical sorting

  | Databases  | In the U.S. | In the rest of the world |
  | ---------- | ----------- | ------------------------ |
  | YYYY MM DD | MM DD YY    | DD MM YY                 |
  | 2015-09-21 | 03-19-2016  | 08-12-2016               |
  | 2016-03-19 | 09-21-2015  | 10-10-2017               |
  | 2016-12-08 | 10-10-2017  | 19-03-2016               |
  | 2017-10-10 | 10-10-2017  | 21-09-2015               |

- Events need to match this exact date and time to be grouped!

  ```
  2017-04-01 12:15:01
  ```

## DATE Functions Part II

- DATE_TRUNC

  2017-04-01 3:56:02
  2017-04-01 5:01:23 => 2017-04-01 00:00:00
  ...

  ```
  SELET DATE_TRUNC('day', occurred_at) AS day,
        SUM(standard_qty) AS standard_qty_sum
    FROM demo.orders
  GROUP BY DATE_TRUNC('day', occurred_at)
  ORDER BY DATE_TRUNC('day', occurred_at)
  ```

- | RESULT              | INPUT                                     |
  | ------------------- | ----------------------------------------- |
  | 2017-04-01 12:15:01 | DATE_TRUNC('second', 2017-04-01 12:15:01) |
  | 2017-04-01 00:00:00 | DATE_TRUNC('day', 2017-04-01 12:15:01)    |
  | 2017-04-01 00:00:00 | DATE_TRUNC('month', 2017-04-01 12:15:01)  |
  | 2017-04-01 00:00:00 | DATE_TRUNC('year', 2017-04-01 12:15:01)   |

- DATE_PART

  - Date part allows you to pull the part of the date that you're interested in.

    | RESULT | INPUT                                    |
    | ------ | ---------------------------------------- |
    | 1      | DATE_PART('second', 2017-04-01 12:15:01) |
    | 1      | DATE_PART('day', 2017-04-01 12:15:01)    |
    | 4      | DATE_PART('month', 2017-04-01 12:15:01)  |
    | 2017   | DATE_PART('year', 2017-04-01 12:15:01)   |

  - 'dow' pulls the day of the week with 0 as Sunday and 6 as Saturday
  - The 1 and 2 here identify these columns in the select statement

    ```
    SELECT  DATE_PART('dow', occurred_at) AS day_of_week,
            SUM(total) AS total_qty
      FROM demo.orders
    GROUP BY 1
    ORDER BY 2 DESC
    ```

## CASE V2

- Derive

  - Take data from existing columns and modify them

- "CASE" statement handles "IF" "THEN" logic

  - "CASE" statements must end with the word "END"
  - Else
    - Captures values not specified in "WHEN" and "THEN" statements

  ```
  SELECT id,
          account_id,
          occurred_at,
          channel,
          CASE WHEN channel = 'facebook' OR channel = 'direct' THEN 'yes' ELSE 'no' END AS is_facebook
    FROM demo.web_events
  ORDER BY occurred_at
  ```

- example:

  ```
  SELECT account_id,
          occurred_at,
          total,
          CASE WHEN total > 500 THEN 'Over 500'
               WHEN total > 300 AND total <= 500 THEN '301-500'
               WHEN total > 100 AND total <= 300 THEN '101-300'
               ELSE '100 or under' END AS total_group
    FROM demo.orders
  ```

## CASE Statements and Aggregations

```
SELECT  CASE WHEN total > 500 THEN 'Over 500'
            ELSE '500 or under' END AS total_group,
        COUNT(*) AS order_count
  FROM demo.orders
GROUP BY 1
```

=>

| total_group  | order_count |
| ------------ | ----------- |
| Over 500     | 3196        |
| 500 or under | 3716        |

- why wouldn't I just use a WHERE clause to filter out rows I don't want to count?

  - You could do that

    ```
    SELECT COUNT(1) AS orders_over_500_units
      FROM demo.orders
    WHERE total > 500
    ```

    =>

    | orders_over_500_units |
    | --------------------- |
    | 3196                  |

  - Unfortunately, using the WHERE clause only allows you to count one condition at a time.
    - This would be tedious if we had a number of different cases.
    - We would need a separate query for each one.
