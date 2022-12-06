# SQL Joins

- Learn to write INNER JOINS to combine data from multiple tables
- Learn to write LEFT JOINs to combine data from multiple tables

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
