# Basic SQL

- Learn to write common SQL commands including SELECT, FROM, and WHERE
- Learn to use logical operators in SQL

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
