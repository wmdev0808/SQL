# SQL for Non-programmers

## Introduction

### How can SQL answer your data questions

## 1. Introduction to SQL Server and Relational Database Concepts

### What is SQL Server

### Understanding servers, databases, and tables

- SQL

  - Structured Query Language

- Database

  - "A usually large collection of data organized, especially for repid search and retrieval (as by a computer)" - Merriam-Webster

- Relational Database

- RDBMS Offerings

  - Oracle
  - PostgreSQL
  - MySQL
  - Microsoft SQL Server

- Microsoft SQL Server documentation

  - docs.microsoft.com/en-us/sql/

- Download & Install SQL Server

- Download SQL Server Management Studio(SSMS)

- [SCHEMA].[TABLE]
- [SERVER].[DATABASE].[SCHEMA].[TABLE]

- Script for SelectTopNRows command from SSMS

  ```
  SELECT TOP (1000) [customer_id]
        , [first_name]
        , [last_name]
        , [full_name]
        , [phone_number]
        , [street_address]
        , [city_state_zip_id]
    FROM [sandbox].[dbo].[customer]
  ```

- [CREATE TABLE](./02_02.sql)

### Relational database concepts

- Relational Database Transformation

  - `Order` table

    | OrderNum | OrderDate | CustName      | State  | ProdCategory | ProdName         | Price  | Quantity | OrderTotal |
    | -------- | --------- | ------------- | ------ | ------------ | ---------------- | ------ | -------- | ---------- |
    | 27       | 3/15/2017 | Sade Santiago | Alaska | Case         | Assortment(case) | $82.95 | 1        | $82.95     |
    | 32       | 3/28/2017 | shellie Velez | Ohio   | Bottle       | Chili(bottole)   | $13.95 | 3        | $55.80     |

  =>

  - `Customer` Table

    | CustomerID | CustName        | State       |
    | ---------- | --------------- | ----------- |
    | 1          | Sade Santiago   | Alaska      |
    | 2          | Shellie Velez   | Ohio        |
    | 3          | Merrill Freeman | Connecticut |
    | 4          | Adara langley   | California  |

  - Order Table

    | OrderNum | OrderDate | CustID | ProdCategory | ProdName         | Price  | Quantity | OrderTotal |
    | -------- | --------- | ------ | ------------ | ---------------- | ------ | -------- | ---------- |
    | 27       | 3/15/2017 | 1      | Case         | Assortment(case) | $82.95 | 1        | $82.95     |
    | 32       | 3/28/2017 | 2      | Bottle       | Chili(bottle)    | $13.95 | 3        | $55.80     |

- One-to-Many Relationship

  ![](./images/1.1%20one-to-many-relationship.png)

- `Product` Table

  | ProductID | ProductCategory | ProdName   | Price  |
  | --------- | --------------- | ---------- | ------ |
  | 10        | Case            | Assortment | $82.95 |
  | 20        | Bottle          | Chili      | $13.95 |
  | 30        | Bottle          | Lemon      | $13.95 |
  | 40        | Case            | Lemon      | $82.95 |

- `Order` Table

  | OrderNum | OrderDate | CustID | ProductID | Quantity | OrderTotal |
  | -------- | --------- | ------ | --------- | -------- | ---------- |
  | 27       | 3/15/2017 | 1      | 10        | 1        | $82.95     |
  | 32       | 3/28/2017 | 2      | 20        | 3        | $55.80     |
  | 32       | 3/28/2017 | 2      | 50        | 1        | $55.80     |
  | 40       | 4/9/2017  | 3      | 30        | 3        | $41.85     |

  - Duplicated items still exist

- `Order` and `Order_Product` Table

  - Order

    | OrderNum | OrderDate | CustID | OrderTotal |
    | -------- | --------- | ------ | ---------- |
    | 27       | 3/15/2017 | 1      | $82.95     |
    | 32       | 3/28/2017 | 2      | $55.80     |
    | 40       | 4/9/2017  | 3      | $41.85     |
    | 99       | 9/28/2017 | 2      | $248.85    |

  - Order_Product

    | OrderNum | ProductID | Quantity |
    | -------- | --------- | -------- |
    | 27       | 10        | 1        |
    | 32       | 20        | 3        |
    | 32       | 50        | 1        |
    | 40       | 30        | 3        |

    - is called association table, join table, junction table

- Many-to-Many Relationship

  ![](./images/1.2%20many-to-many-relationship.png)

- Normalization

  - Organizing data in a database by establishing relationhips between tables in order to avoid redundancy and maintain data integrity
  - Optimized for data storage

- Denormalization

  - Intentionally breaking rules of normalization in a relational database
  - Optimized for data retrieval

- Original table will be transformed like this:
  - From:
    ![](images/1.3%20relational-database-transformation.png)
  - To:
    ![](<images/1.4%20entity-relationship-diagram(ERD).png>)

### Surrogate, primary, and foreign keys

- Key Relationships

  - `Surrogate key`

    - A unique identifier to represent the contents on a row in the logical design of a relational database; value is not derived from the content of the data itself

    - SQL Server examples
      - Identity
      - Sequence
      - NewID() GUID

  - `Natural key`

    - A unique identifier for a row in the logical design of a relational database as described using data attributes that exist within the data set and also have meaning outside the context of the database

  - `Primary key`

    - a field or fields that physically maintain and identify uniqueness in a table in a relational database

  - `Foreign key`
    - A key that points to a primary key and creates a relationship between two tables and maintains data integrity

## 2. Single Table Select Statements

### SQL data types and nullability

- Data Types

  - 1. Numbers

    - INT - for example, 256
    - DECIMAL/NUMERIC - for example, 3.14159
      - DECIMAL(10, 5)

  - 2. Strings and Characters

    - CHAR(1) - for example, Y
    - VARCHAR(15) - for example, John Doe

  - 3. Dates and Times

    - DATE - for example, 2025-12-10
    - TIME - for example, 12:15:04.1237
    - DATETIME/2 - for example, 2025-12-10 12:15:04.1237
    - DATETIMEOFFSET - for example, 2025-12-10 12:15:04.1237 +7.00

  - 4. True/False Values
    - BIT - for example, 0 or 1

- Nullability
  - No value; not to be confused with 0 or blank space
  - NULL
  - NOT NULL

### Reading from a single table in SQL

- Select Statement

  - SELECT [list of column names]
  - FROM [schema name].[table name]

  ```
  select *
  from dbo.additional_service
  ```

- Specify columns to be returned

  ```
  select
    srv_name,
    min_participants
  from dbo.additional_service
  ```

- Limit the result

  ```
  select top 3
    srv_name,
    min_participants
  from dbo.additional_service
  ```

- Change column header

  ```
  select top 3
    additional_service = srv_name,
    minimum_participants = min_participants
  from dbo.additional_service
  ```

  =>

  | additional_service      | minium_participants |
  | ----------------------- | ------------------- |
  | Two Trees Tasting Party | 12                  |

  or

  ```
  select top 3
    srvc_name [additional service],
    min_participants [minimum participants]
  from dbo.additional_service
  ```

  - You can even include spaces in square brackets

### Filtering on a single condition in SQL

- WHERE [condition is true/false]

- Note: `--`(two dash) denotes comments

- [Examples](./02_03.sql)

### Filtering on multiple conditions in SQL

- Logical Operators

  - AND: both conditions must be true
  - OR: at least one condition must be true

- [Example](./02_04.sql)

## 3. Multiple Table Select Statements

### Inner joins

- ERD
  ![](images/3.1%20ERD.png)

### Multiple inner joins

- ERD
  ![](images/3.2%20ERD.png)

### Outer joins

- LEFT OUTER JOIN

  - ![](images/3.3%20left%20outer%20join.png)

  - The join order matters in outer join
    - It doesn't matter with inner joins
    - But You always keep all the rows from anchoring table in outer joins

### Subqueries

- One of the functions of `inner joins` is that they can be used to filter results sets, but there is another method that we can use to achieve this called a `subquery`.

- Note:

  - we can't reference any tables from the subquery in our main select statement.

- When to use Subquery vs. Inner Join

  - Subquery

    - Can sometimes perform better than filtering with an INNER JOIN
    - Can only be used when you don't need to return columns from the subquery tables

  - Inner Join
    - Necessary if you need to reference columns from a table used for filtering
    - Also necessary if you need to use an association table on the way to another table

## 4. Additional SQL Query Tools

### Case statements

- [Examples](./04_01.sql)

### Built-in functions

- Built-In Function:

  - SQL code tool that takes in zero or more inputs and returns a single value; can be used for data manipulation or formatting

- [Examples](./04_02.sql)

- `CAST` or `CONVERT`

  - Syntax:

    ```
    CAST([column name] AS [data type])
    ```

    ```
    CONVERT([data type], [column name], [style number (optional)])
    ```

  - cast is ANSI standard
  - convert is SQL specific

- `CONCAT` or `+`

  - Syntax:

    ```
    CONCAT([string], [string], [string]...)
    ```

    ```
    [string] + [string]
    ```

  - When you concatenate using `+`, they should have compatible data types
    - For this, you can use `CAST`
    - Anything plus `NULL` is going to end up being `NULL`.
  - But when using `CONCAT`, you don't have to care about the above

- `FORMAT`

  - Syntax:

    ```
    FORMAT([column name], '[custom format]')
    ```

    or

    ```
    FORMAT([column name], [format code], [culture code])
    ```

  - Note: When formatting a date,
    - don't confuse `M` and `m`
      - M: month
      - m: minute

- `GETDATE()` or `SYSDATETIME()`

- `DATEADD`

  - Syntax:

    ```
    DATEADD([interval], [number], [date value])
    ```

  - Note: If you want to look at a month ago, you use a negative number.

- `COALESCE`, `ISNULL`

  - Syntax:

    ```
    COALESCE([first choice], [second choice], [third choice]...)
    ```

    ```
    ISNULL([first choice], [second choice])
    ```

  - Note: Make sure that all the choices have the same data type

    - For example,

      ```
      declare @override int

      select
        ...,
        coalesce_participants = coalesce(min_participants, @override, 'n/a')
      ...
      ```

      - Since the column, `min_participants` has `int` date type, the above qury will throw the data type error

### Aggregates

- Aggregate Functions

  - How Many Orders per Item?
    ![](images/4.4-01%20how%20many%20orders%20per%20item.png)

  - COUNT
  - SUM
  - MAX, MIN,
    ...

### Query processing order

- Query Processing Order

  - 1. FROM + JOINS
  - 2. WHERE
  - 3. GROUP BY
  - 4. HAVING
  - 5. SELECT
  - 6. ORDER BY
  - 7. TOP

- You can actually `ORDER BY` the aggregate column by the column alias instead of aggregate
  - The reason that we can refer to a column alias in the ORDER BY clause but not in other places in our query is because of the order in which the server resolves the query that we've provided.
  - So first, it looks at the `FROM` statement which includes any `JOINs`, which makes sense because before you can get any data, you need to know where it's coming from. Then the server filters the data by considering the `WHERE` clause. Then it collapses the results using any `GROUP BY` conditions. Then we actually build out the query results for the columns listed in the `SELECT` statement, applying any requested aliases. And this is why we can reference the column alias in the `ORDER BY` clause, which is resolved next. And lastly, the server applies the top condition to limit the results as requested in the query.
- If you try to filter the result on the aggregate function, for example, `SUM`, you'll get the error that an aggregate may not appear in the `WHERE` clause, and that's because of how the query is resolved.
  - The filtering from the `WHERE` clause happens before `GROUP BY` has been aggregated, so it doesn't know what that code means at that moment. Instead, we have another clause that exists specifically for this use case, which is the HAVING clause. And it goes right here, having sum greater than 500. It's written in basically the same way as the `WHERE` cause, but because it resolves after the `GROUP BY`, we can use it to filter it with the aggregate here.

## Conclusion

- Next steps
  - Additional Resources
    - Microsoft documentation https://docs.microsoft.com/en-us/sql
    - Stack Overflow
    - #sqlhelp on Twitter
    - Microsoft SQL Server Essential Training
