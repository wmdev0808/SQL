# SQL Essential Training

## 0. Introduction

### 0.1. Understanding SQL

### 0.2. How to use the exercise files

### 0.3. Course overview

- SQLite 3

  - Every database system is different
    - Most predate standard
    - Syntax may be different
    - Features may be missing
    - Non-standard features
  - Standards compliant
  - Widely deployed
  - Single file, cross-platform

- Standard SQL

## 1. Installation

### 1.1. Installing on Windows

- SQLiteStudio
  - https://sqlitestudio.pl/

### 1.2. Installing on a Mac

## 2. SQL Overview

### 2.1. About SQL

- SQL statement

  ```
  SELECT * FROM Countries WHERE Continent = 'Europe';
  ```

  - Terminated by semicolon(;)
  - FROM clause
  - WHERE clause
    - Requires expressions
      - logical expression

- CRUD

  - Create
  - Read
  - Update
  - Delete

- SELECT

  ```
  SELECT * FROM Customer;
  ```

- INSERT

  ```
  INSERT INTO Customer (name, city, state)
    VALUES ('Jimi Hendrix', 'Renton', 'WA');
  ```

- UPDATE

  ```
  UPDATE Customer
    SET
      Address = '123 Music Avenue',
      Zip = '98056'
    WHERE id = 5;
  ```

- DELETE

  ```
  DELETE FROM Customer WHERE id = 4;
  ```

### 2.2. Database organization

- A databas has tables

  - A table has rows and columns

    - `Customers`

      | id  | name       | address       | city    | state | zip   |
      | --- | ---------- | ------------- | ------- | ----- | ----- |
      | 1   | Bill Smith | 123 Main St   | Hope    | CA    | 98765 |
      | 2   | Mary Smith | 123 Dorian St | Harmony | AZ    | 98765 |
      | 3   | Bob Smith  | 123 Laugh St  | Humor   | CA    | 98765 |

    - A row is like a recod
    - A column is like a field
    - A unique key identifies a table row

  - Tables are related by keys

    - sale

      | id  | item_id | cust_id | quan | price |
      | --- | ------- | ------- | ---- | ----- |
      | 1   | 1       | 2       | 3    | 2995  |
      | 2   | 2       | 2       | 1    | 1995  |
      | 3   | 1       | 1       | 1    | 2995  |

    - item

      | id  | name   | description    |
      | --- | ------ | -------------- |
      | 1   | Pixels | 64 RGB         |
      | 2   | Humor  | Especially dry |
      | 3   | Beauty | Inner beauty   |

    - customer

      | id  | name       | address       | city    | state | zip   |
      | --- | ---------- | ------------- | ------- | ----- | ----- |
      | 1   | Bill Smith | 123 Main St   | Hope    | CA    | 98765 |
      | 2   | Mary Smith | 123 Dorian St | Harmony | AZ    | 98765 |
      | 3   | Bob Smith  | 123 Laugh St  | Humor   | CA    | 98765 |

### 2.3. The SELECT statement

```
SELECT 'Hello, World' AS Result;
```

```
SELECT * FROM Country ORDER BY Name;
```

```
SELECT Name, LifeExpectancy AS "LIfe Expectancy" FROM Country ORDER BY Name;
```

```
SELECT Name, LifeExpectancy "LIfe Expectancy" FROM Country ORDER BY Name;
```

### 2.4. Selecting rows

```
SELECT Name, Continent, Region FROM Country WHERE Continent = 'Europe' ORDER BY Name LIMIT 5 OFFSET 5;
```

### 2.5. Selecting columns

```
SELECT * FROM Country;
```

```
SELECT Name AS Country, Continent, Region FROM Country;
```

### 2.6. Counting rows

```
SELECT COUNT(*) FROM Country WHERE Population > 10000000 AND Continent = 'Europe';
```

- Note: COUNT only consider Not NULL values

  ```
  SELECT COUNT(LifeExpectancy) FROM Country;
  ```

### 2.7. Inserting data

```
SELECT * FROM customer;

INSERT INTO customer (name, address, city, state, zip)
  VALUES ('Fred Flintstone', '123 Cobblestone Way', 'Bedrock', 'CA', '91234');

INSERT INTO customer (name, city, state)
  VALUES ('Jimi Hendrix', 'Renton', 'WA');
```

### 2.8. Updating data

```
SELECT * FROM customer;

UPDATE customer SET address = '123 Music Avenue', zip = '98056' WHERE id = 5;

UPDATE customer SET address = '2603 S Washington St', zip = '98056' WHERE id = 5;

UPDATE customer SET address = NULL, zip = NULL WHERE id = 5;
```

### 2.9. Deleting data

```
SELECT * FROM customer WHERE id = 4;

DELETE FROM customer WHERE id = 4;
SELECT * FROM customer;

DELETE FROM customer WHERE id = 5;
SELECT * FROM customer;
```

## 3. Fundamental Concepts

### 3.1. Creating a table

```
CREATE TABLE test (
  a INTEGER,
  b TEXT
);

INSERT INTO test VALUES (1, 'a');
INSERT INTO test VALUES (2, 'b');
INSERT INTO test VALUES (3, 'c');
SELECT * FROM test;
```

### 3.2. Deleting a table

```
CREATE TABLE test (a TEXt, b TEXT);
INSERT INTO test VALUES ('one', 'two');
SELECT * FROM test;

DROP TABLE test;

DROP TABLE IF EXISTS test;
```

### 3.3. Inserting rows

```
CREATE TABLE test (a INTEGER, b TEXT, c TEXT);

INSERT INTO test VALUES (1, 'This', 'Right here!');

INSERT INTO test (b, c) VALUES ('That', 'Over there!');

INSERT INTO test DEFAULT VALUES;

INSERT INTO test (a, b, c) SELECT id, name, description from item;

SELECT * FROM test;
```

### 3.4. Deleting rows

```
SELECT * FROM test;

DELETE FROM test WHERE a = 3;
```

### 3.5. The NULL value

- `NULL` means `No value`

  - Not a value, not zero, not empty string, a lack of value

    ```
    SELECT * FROM test WHERE a = NULL;
    ```

    => No result

    ```
    SELECT * FROM test WHERE a IS NULL;
    ```

    ```
    SELECT * FROM test WHERE a IS NOT NULL;
    ```

    ```
    INSERT INTO test ( a, b, c ) VALUES ( 0, NULL, '' );
    SELECT * FROM test WHERE b IS NULL;
    SELECT * FROM test WHERE b = '';
    SELECT * FROM test WHERE c = '';
    SELECT * FROM test WHERE c IS NULL;
    ```

- `NOT NULL` constraint

  ```
  DROP TABLE IF EXISTS test;
  CREATE TABLE test (
    a INTEGER NOT NULL,
    b TEXT NOT NULL,
    c TEXT
  );

  INSERT INTO test VALUES ( 1, 'this', 'that' );
  SELECT * FROM test;

  INSERT INTO test ( b, c ) VALUES ( 'one', 'two' ); /* NOT NULL containt failed */
  INSERT INTO test ( a, c ) VALUES ( 1, 'two' ); /* NOT NULL containt failed */
  INSERT INTO test ( a, b ) VALUES ( 1, 'two' );
  DROP TABLE IF EXISTS test;
  ```

### 3.6. Constraining columns

```
DROP TABLE IF EXISTS test;
CREATE TABLE test ( a TEXT, b TEXT, c TEXT );
INSERT INTO test ( a, b ) VALUES ( 'one', 'two' );
SELECT * FROM test;
```

- NOT NULL

  ```
  CREATE TABLE test ( a TEXT, b TEXT, c TEXT NOT NULL );
  ```

- DEFAULT

  ```
  CREATE TABLE test ( a TEXT, b TEXT, c TEXT DEFAULT 'panda' );
  ```

- UNIQUE

  ```
  CREATE TABLE test ( a TEXT UNIQUE, b TEXT, c TEXT DEFAULT 'panda' );
  CREATE TABLE test ( a TEXT UNIQUE NOT NULL, b TEXT, c TEXT DEFAULT 'panda' );
  ```

### 3.7. Changing a schema

- ALTER TABLE

  - Add a new column

    ```
    DROP TABLE IF EXISTS test;
    CREATE TABLE test ( a TEXT, b TEXT, c TEXT );
    INSERT INTO test VALUES ( 'one', 'two', 'three');
    INSERT INTO test VALUES ( 'two', 'three', 'four');
    INSERT INTO test VALUES ( 'three', 'four', 'five');
    SELECT * FROM test;

    ALTER TABLE test ADD d TEXT;
    ALTER TABLE test ADD e TEXT DEFAULT 'panda';

    DROP TABLE IF EXISTS test;
    ```

### 3.8. ID columns

```
CREATE TABLE test (
  id INTEGER PRIMARY KEY,
  a INTEGER,
  b TEXT
);
INSERT INTO test (a, b) VALUES ( 10, 'a' );
INSERT INTO test (a, b) VALUES ( 11, 'b' );
INSERT INTO test (a, b) VALUES ( 12, 'c' );
SELECT * FROM test;
DROP TABLE IF EXISTS test;
```

### 3.9. Filtering data

- `WHERE`, `LIKE`, and `IN`

  - world.db

  ```
  SELECT * FROM Country;
  SELECT Name, Continent, Population FROM Country
    WHERE Population < 100000 ORDER BY Population DESC;
  SELECT Name, Continent, Population FROM Country
    WHERE Population < 100000 OR Population IS NULL ORDER BY Population DESC;
  SELECT Name, Continent, Population FROM Country
    WHERE Population < 100000 AND Continent = 'Oceania' ORDER BY Population DESC;
  SELECT Name, Continent, Population FROM Country
    WHERE Name LIKE '%island%' ORDER BY Name;
  SELECT Name, Continent, Population FROM Country
  WHERE Continent IN ( 'Europe', 'Asia' ) ORDER BY Name;
  ```

### 3.10. Removing duplicates

- `SELECT DISTINCT`

  - db: world.db
  - query:

    ```
    SELECT Continent FROM Country;
    SELECT DISTINCT Continent FROM Country;
    ```

  - Using the `SELECT DISTINCT` statement, you will get only unique results.

    - db: test.db
    - query:

      ```
      DROP TABLE IF EXISTS test;
      CREATE TABLE test ( a int, b int );
      INSERT INTO test VALUES ( 1, 1 );
      INSERT INTO test VALUES ( 2, 1 );
      INSERT INTO test VALUES ( 3, 1 );
      INSERT INTO test VALUES ( 4, 1 );
      INSERT INTO test VALUES ( 5, 1 );
      INSERT INTO test VALUES ( 1, 2 );
      INSERT INTO test VALUES ( 1, 2 );
      INSERT INTO test VALUES ( 1, 2 );
      INSERT INTO test VALUES ( 1, 2 );
      INSERT INTO test VALUES ( 1, 2 );
      SELECT * FROM test;

      SELECT DISTINCT a FROM test;
      SELECT DISTINCT b FROM test;
      SELECT DISTINCT a, b FROM test;

      DROP TABLE IF EXISTS test;
      ```

### 3.11. Ordering output

- `ORDER BY`

  - db: world.db
  - query:

    ```
    SELECT Name FROM Country;
    SELECT Name FROM Country ORDER BY Name;
    SELECT Name FROM Country ORDER BY Name DESC;
    SELECT Name FROM Country ORDER BY Name ASC;
    SELECT Name, Continent FROM Country ORDER BY Continent, Name;
    SELECT Name, Continent, Region FROM Country ORDER BY Continent DESC, Region, Name;
    ```

### 3.12. Conditional expressions

- `CASE`

  - db: test.db
  - query:

    ```
    DROP TABLE IF EXISTS booltest;
    CREATE TABLE booltest (a INTEGER, b INTEGER);
    INSERT INTO booltest VALUES (1, 0);
    SELECT * FROM booltest;

    SELECT
        CASE WHEN a THEN 'true' ELSE 'false' END as boolA,
        CASE WHEN b THEN 'true' ELSE 'false' END as boolB
        FROM booltest
    ;

    SELECT
      CASE a WHEN 1 THEN 'true' ELSE 'false' END AS boolA,
      CASE b WHEN 1 THEN 'true' ELSE 'false' END AS boolB
      FROM booltest
    ;

    DROP TABLE IF EXISTS booltest;
    ```

## 4. Relationships

### 4.1. Understaind JOIN

- `JOIN`

  - db: test.db
  - Preparation query:

    ```
    CREATE TABLE left ( id INTEGER, description TEXT );
    CREATE TABLE right ( id INTEGER, description TEXT );

    INSERT INTO left VALUES ( 1, 'left 01' );
    INSERT INTO left VALUES ( 2, 'left 02' );
    INSERT INTO left VALUES ( 3, 'left 03' );
    INSERT INTO left VALUES ( 4, 'left 04' );
    INSERT INTO left VALUES ( 5, 'left 05' );
    INSERT INTO left VALUES ( 6, 'left 06' );
    INSERT INTO left VALUES ( 7, 'left 07' );
    INSERT INTO left VALUES ( 8, 'left 08' );
    INSERT INTO left VALUES ( 9, 'left 09' );

    INSERT INTO right VALUES ( 6, 'right 06' );
    INSERT INTO right VALUES ( 7, 'right 07' );
    INSERT INTO right VALUES ( 8, 'right 08' );
    INSERT INTO right VALUES ( 9, 'right 09' );
    INSERT INTO right VALUES ( 10, 'right 10' );
    INSERT INTO right VALUES ( 11, 'right 11' );
    INSERT INTO right VALUES ( 11, 'right 12' );
    INSERT INTO right VALUES ( 11, 'right 13' );
    INSERT INTO right VALUES ( 11, 'right 14' );

    SELECT * FROM left;
    SELECT * FROM right;
    ```

### 4.2. Accessing related tables

```
SELECT l.description AS left, r.description AS right
FROM left AS l
JOIN right AS r ON l.id = r.id
;

-- restore database
DROP TABLE left;
DROP TABLE right;

-- sale example
SELECT * FROM sale;
SELECT * FROM item;

SELECT s.id AS sale, i.name, s.price
  FROM sale AS s
  JOIN item AS i ON s.item_id = i.id
  ;

SELECT s.id AS sale, i.name, s.price
  FROM sale AS s
  LEFT JOIN item AS i ON s.item_id = i.id
  ;

SELECT s.id AS sale, s.date, i.name, i.description, s.price
  FROM sale AS s
  JOIN item AS i ON s.item_id = i.id
  ;
```

### 4.3. Relating multiple tables

- `Junction table`

  - For many-to-many relationships

    - ex):
      - A customer can buy many items
      - An item can be purchased by many customers

  - db: test.db
  - query:

    ```
    SELECT * FROM customer;
    SELECT * FROM item;
    SELECT * FROM sale;

    SELECT c.name AS Cust, c.zip, i.name AS Item, i.description, s.quantity AS Quan, s.price AS Price
    FROM sale AS s
    JOIN item AS i ON s.item_id = i.id
    JOIN customer AS c ON s.customer_id = c.id
    ORDER BY Cust, Item
    ;

    -- a customer without sales
    INSERT INTO customer ( name ) VALUES ( 'Jane Smith' );
    SELECT * FROM customer;

    -- left joins
    SELECT c.name AS Cust, c.zip, i.name AS Item, i.description, s.quantity AS Quan, s.price AS Price
      FROM customer AS c
      LEFT JOIN sale AS s ON s.customer_id = c.id
      LEFT JOIN item AS i ON s.item_id = i.id
      ORDER BY Cust, Item
    ;

    -- restore database
    DELETE FROM customer WHERE id = 4;
    ```

## 5. Strings

### 5.1. About SQL strings

- Literal string inside single quote

  ```
  SELECT 'a literal SQL string';
  ```

- Standard SQL vs MySQL

  - Standard SQL

    ```
     SELECT 'a literal SQL string';
    ```

  - MySQL

    ```
    SELECT "a literal SQL string";
    ```

- Single quote in string

  ```
  SELECT 'Here''s a single quote mark.';
  ```

  =>

  Here's a single quote mark.

- Concatenation

  - Concatenation in standard SQL

    ```
    SELECT 'This' || ' & ' || 'that';
    ```

  - Concatenation in MySQL

    ```
    SELECT CONCAT('This', ' & ', 'that');
    ```

  - Concatenation in MS SQL Server

    ```
    SELECT 'This' + ' & ' + 'that';
    ```

- String functions
  - SUBSTR(string, start, length);
  - LENGTH(string);
  - TRIM(string);
  - UPPER(string);
  - LOWER(string);

### 5.2. Finding the length of a string

- `LENGTH`

  - db: world.db
  - query:

    ```
    SELECT LENGTH('string');
    SELECT Name, LENGTH(Name) AS Len FROM City ORDER BY Len DESC;
    ```

### 5.3. Selecting part of a string

- `SUBSTR`

  - db: album.db
  - query:

    ```
    SELECT SUBSTR('this string', 6);
    SELECT SUBSTR('this string', 6, 3);
    SELECT released,
        SUBSTR(released, 1, 4) AS year,
        SUBSTR(released, 6, 2) AS month,
        SUBSTR(released, 9, 2) AS day
      FROM album
      ORDER BY released
    ;
    ```

### 5.4. Removing spaces

- `TRIM`, `LTRIM`, `RTRIM`

  ```
  SELECT TRIM('   string   ');
  SELECT LTRIM('   string   ');
  SELECT RTRIM('   string   ');
  SELECT TRIM('...string...', '.');
  ```

### 5.5. Folding case

- `UPPER`, `LOWER`

  - db: world.db
  - query:

    ```
    SELECT 'StRiNg' = 'string';
    SELECT LOWER('StRiNg') = LOWER('string');
    SELECT UPPER('StRiNg') = UPPER('string');
    SELECT UPPER(Name) FROM City ORDER BY Name;
    SELECT LOWER(Name) FROM City ORDER BY Name;
    ```

## 6. Numbers

### 6.1. Numeric types

- Fundamental numeric types

  - Integer
  - Real

- Integer types

  - INTEGER(precision)
  - DECIMAL(precision, scale)
  - MONEY(precision, scale)

- Real types

  - REAL(precision)
  - FLOAT(precision)

- Precision vs Scale

  | Expression                       | Result |
  | -------------------------------- | ------ |
  | `((.1 + .2) * 10)`               | 3.0    |
  | `(1.0 + 2.0)`                    | 3.0    |
  | `((.1 + .2) * 10) = (1.0 + 2.0)` | FALSE  |

### 6.2. What type if that value

- `TYPEOF`

  ```
  SELECT TYPEOF( 1 + 1 ); /*integer*/
  SELECT TYPEOF( 1 + 1.0 );/*real*/
  SELECT TYPEOF('panda');/*text*/
  SELECT TYPEOF('panda' + 'koala');/*integer*/
  ```

### 6.3. Integer division

```
SELECT 1 / 2; /* integer: 0 */
SELECT 1.0 / 2; /* numeric: 0.50000000000000000000 */
SELECT CAST(1 AS REAL) / 2; /* double precision: 0.5 */
SELECT 17 / 5; /* integer: 3 */
SELECT 17 / 5, 17 % 5; /* integer: 3, integer: 2 */
```

### 6.4. Rounding numbers

- `ROUND`

  ```
  SELECT 2.55555; /* 2.55555 */
  SELECT ROUND(2.55555); /* 3 */
  SELECT ROUND(2.55555, 3); /* 2.556 */
  SELECT ROUND(2.55555, 0); /* 3 */
  ```

## 7. Dates and Times

### 7.1. Dates and times

- SQL standard datetime format

  ```
  2018-03-28 15:32:47
  ```

- All dates and times in UTC(Coordinated Universal Time)

- SQL date and time types
  - `DATE`
  - `TIME`
  - `DATETIME`
  - `YEAR`
  - `INTERVAL`

### 7.2. Date- and time-related functions

```
SELECT DATETIME('now'); /* 2023-01-04 14:20:49 */
SELECT DATE('now'); /* 2023-01-04 */
SELECT TIME('now'); /* 14:21:30 */
SELECT DATETIME('now', '+1 day'); /* 2023-01-05 14:21:47 */
SELECT DATETIME('now', '+3 days'); /* 2023-01-07 14:22:01 */
SELECT DATETIME('now', '-1 month'); /* 2022-12-04 14:22:19 */
SELECT DATETIME('now', '+1 year'); /* 2024-01-04 14:22:31 */
SELECT DATETIME('now', '+3 hours', '+27 minutes', '-1 day', '+3 years');/* 2026-01-03 17:49:56 */
```

## 8. Aggregates

### 8.1. What are aggregates

- db: world.db
- query:

  ```
  SELECT COUNT(*) FROM Country;
  ```

  ```
  SELECT Region, COUNT(*)
    FROM Country
    GROUP BY Region
  ;
  ```

  ```
  SELECT Region, COUNT(*) AS Count
    FROM Country
    GROUP BY Region
    ORDER BY Count DESC, Region
  ;
  ```

- db: album.db
- query:

  ```
  SELECT a.title AS Album, COUNT(t.track_number) as Tracks
    FROM track AS t
    JOIN album AS a
      ON a.id = t.album_id
    GROUP BY a.id
    ORDER BY Tracks DESC, Album
  ;

  SELECT a.title AS Album, COUNT(t.track_number) as Tracks
    FROM track AS t
    JOIN album AS a
      ON a.id = t.album_id
    GROUP BY a.id
    HAVING Tracks >= 10
    ORDER BY Tracks DESC, Album
  ;

  SELECT a.title AS Album, COUNT(t.track_number) as Tracks
    FROM track AS t
    JOIN album AS a
      ON a.id = t.album_id
    WHERE a.artist = 'The Beatles'
    GROUP BY a.id
    HAVING Tracks >= 10
    ORDER BY Tracks DESC, Album
  ;
  ```

### 8.2. Using aggregate functions

- `COUNT`, `AVG`, `MIN`, `MAX`, `SUM`

  - db: world.db
  - query:

    ```
    SELECT COUNT(*) FROM Country;
    SELECT COUNT(Population) FROM Country;
    SELECT AVG(Population) FROM Country;
    SELECT Region, AVG(Population) FROM Country GROUP BY Region;
    SELECT Region, MIN(Population), MAX(Population) FROM Country GROUP BY Region;
    SELECT Region, SUM(Population) FROM Country GROUP BY Region;
    ```

### 8.3. Aggregating DISTINCT values

- db: world.db
- query:

  ```
  SELECT COUNT(HeadOfState) FROM Country;
  SELECT HeadOfState FROM Country ORDER BY HeadOfState;
  SELECT COUNT(DISTINCT HeadOfState) FROM Country;
  ```

## 9. Transactions

### 9.1. What are transactions

- What is a transaction?

  ```
  BEGIN TRANSACTION
    INSERT INTO table_1
    INSERT INTO table_2
    SELECT FROM table_2
    INSERT INTO table_3
  END TRANSACTION
  ```

  - In database terminology, a transaction is a group of operations that are handled as one unit of work. In practice, this means that you may have many operations, and if any of these operations fails, the entire group of operations is treated as fail, and the database is restored to its state before the group of operations was started.

- Concurrent operations

  - Transactions are also used to ensure that concurrent operations result in a state as if they were handled separately and sequentially. In other words, if your database is used by many clients at the same time, and they're all conducting similar complex operations grouped into transactions, those transactions will affect the database as if each transaction were completed separately.

- Performance
  - Transactions can also improve performance, sometimes radically, for example if you have a lot of rows to insert into a table, or a set of tables, each of these inserts takes time to write to the storage device, when making individual writes, the database system uses resources to ensure that each row has been successfully committed to storage before the next write begins. When you make a group of inserts to your table as a transaction, the database system can perform many write operations together, significantly reducing the overhead associated with writing to physical media. Generally transactional operations could improve reliability and performance for larger or more complex operations.

### 9.2. Data integrity

- db: test.db
- query:

  ```
  CREATE TABLE widgetInventory (
    id INTEGER PRIMARY KEY,
    description TEXT,
    onhand INTEGER NOT NULL
  );

  CREATE TABLE widgetSales (
    id INTEGER PRIMARY KEY,
    inv_id INTEGER,
    quan INTEGER,
    price INTEGER
  );

  INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'rock', 25 );
  INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'paper', 25 );
  INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'scissors', 25 );

  SELECT * FROM widgetInventory;
  SELECT * FROM widgetSales;
  ```

  ```
  BEGIN TRANSACTION;
  INSERT INTO widgetSales ( inv_id, quan, price ) VALUES ( 1, 5, 500 );
  UPDATE widgetInventory SET onhand = ( onhand - 5 ) WHERE id = 1;
  END TRANSACTION;

  BEGIN TRANSACTION;
  INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'toy', 25 );
  ROLLBACK;
  SELECT * FROM widgetInventory;

  -- restore database
  DROP TABLE IF EXISTS widgetInventory;
  DROP TABLE IF EXISTS widgetSales;
  ```

### 9.3. Performance

- db: test.db
- query:

  ```
  CREATE TABLE test ( id INTEGER PRIMARY KEY, data TEXT );

  -- put this before the 1,000 INSERT statements
  BEGIN TRANSACTION;

  -- copy / paste 1,000 of these ...
  INSERT INTO test ( data ) VALUES ( 'this is a good sized line of text.' );

  -- put this after the 1,000 INSERT statements
  END TRANSACTION;

  SELECT COUNT(*) FROM test;

  -- restore database
  DROP TABLE test;
  ```

- Without the transaction
  - 1.020 seconds
- With the transaction
  - 0.047 seconds

## 10. Triggers

### 10.1. Automating data with triggers

- Triggers are operations that are automatically performed when a specified database event occurs.

- db: test.db
- query:

  ```
  CREATE TABLE widgetCustomer (
    id INTEGER PRIMARY KEY,
    name TEXT,
    last_order_id INT
  );
  CREATE TABLE widgetSale (
    id INTEGER PRIMARY KEY,
    item_id INT,
    customer_id INT,
    quan INT,
    price INT
  );

  INSERT INTO widgetCustomer (name) VALUES ('Bob');
  INSERT INTO widgetCustomer (name) VALUES ('Sally');
  INSERT INTO widgetCustomer (name) VALUES ('Fred');

  SELECT * FROM widgetCustomer;

  CREATE TRIGGER newWidgetSale AFTER INSERT ON widgetSale
      BEGIN
          UPDATE widgetCustomer SET last_order_id = NEW.id WHERE widgetCustomer.id = NEW.customer_id;
      END
  ;

  INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (1, 3, 5, 1995);
  INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (2, 2, 3, 1495);
  INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (3, 1, 1, 2995);
  SELECT * FROM widgetSale;
  SELECT * FROM widgetCustomer;
  ```

### 10.2. Preventing updates

- db: test.db
- query:

  ```
  DROP TABLE IF EXISTS widgetSale;

  CREATE TABLE widgetSale (
    id integer primary key,
    item_id INT,
    customer_id INTEGER,
    quan INT,
    price INT,
    reconciled INT
  );
  INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (1, 3, 5, 1995, 0);
  INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (2, 2, 3, 1495, 1);
  INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (3, 1, 1, 2995, 0);
  SELECT * FROM widgetSale;

  CREATE TRIGGER updateWidgetSale BEFORE UPDATE ON widgetSale
      BEGIN
          SELECT RAISE(ROLLBACK, 'cannot update table "widgetSale"') FROM widgetSale
              WHERE id = NEW.id AND reconciled = 1;
      END
  ;

  BEGIN TRANSACTION;
  UPDATE widgetSale SET quan = 9 WHERE id = 2;
  END TRANSACTION;

  SELECT * FROM widgetSale;
  ```

### 10.3. Example - Timestamps

- Triggers may also used to create timestamps, and in this example I'll show you how to use a trigger to create timestamps and to update a transaction log.

- db: test.db
- query:

  ```
  DROP TABLE IF EXISTS widgetSale;
  DROP TABLE IF EXISTS widgetCustomer;

  CREATE TABLE widgetCustomer (
    id integer primary key,
    name TEXT,
    last_order_id INT,
    stamp TEXT
  );
  CREATE TABLE widgetSale (
    id integer primary key,
    item_id INT,
    customer_id INTEGER,
    quan INT,
    price INT,
    stamp TEXT
  );
  CREATE TABLE widgetLog (
    id integer primary key,
    stamp TEXT,
    event TEXT,
    username TEXT,
    tablename TEXT,
    table_id INT
  );

  INSERT INTO widgetCustomer (name) VALUES ('Bob');
  INSERT INTO widgetCustomer (name) VALUES ('Sally');
  INSERT INTO widgetCustomer (name) VALUES ('Fred');
  SELECT * FROM widgetCustomer;

  CREATE TRIGGER stampSale AFTER INSERT ON widgetSale
      BEGIN
          UPDATE widgetSale SET stamp = DATETIME('now') WHERE id = NEW.id;
          UPDATE widgetCustomer SET last_order_id = NEW.id, stamp = DATETIME('now')
              WHERE widgetCustomer.id = NEW.customer_id;
          INSERT INTO widgetLog (stamp, event, username, tablename, table_id)
              VALUES (DATETIME('now'), 'INSERT', 'TRIGGER', 'widgetSale', NEW.id);
      END
  ;

  INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (1, 3, 5, 1995);
  INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (2, 2, 3, 1495);
  INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (3, 1, 1, 2995);

  SELECT * FROM widgetSale;
  SELECT * FROM widgetCustomer;
  SELECT * FROM widgetLog;

  -- restore database
  DROP TRIGGER IF EXISTS newWidgetSale;
  DROP TRIGGER IF EXISTS updateWidgetSale;
  DROP TRIGGER IF EXISTS stampSale;

  DROP TABLE IF EXISTS widgetCustomer;
  DROP TABLE IF EXISTS widgetSale;
  DROP TABLE IF EXISTS widgetLog;
  ```

## 11. Views and Subselects

### 11.1. Creating a subselect

- db: world.db
- query:

  ```
  CREATE TABLE t ( a TEXT, b TEXT );
  INSERT INTO t VALUES ( 'NY0123', 'US4567' );
  INSERT INTO t VALUES ( 'AZ9437', 'GB1234' );
  INSERT INTO t VALUES ( 'CA1279', 'FR5678' );
  SELECT * FROM t;

  SELECT SUBSTR(a, 1, 2) AS State, SUBSTR(a, 3) AS SCode,
    SUBSTR(b, 1, 2) AS Country, SUBSTR(b, 3) AS CCode FROM t;

  SELECT co.Name, ss.CCode FROM (
      SELECT SUBSTR(a, 1, 2) AS State, SUBSTR(a, 3) AS SCode,
        SUBSTR(b, 1, 2) AS Country, SUBSTR(b, 3) AS CCode FROM t
    ) AS ss
    JOIN Country AS co
      ON co.Code2 = ss.Country
  ;

  DROP TABLE t;
  ```

### 11.2. Searching within a result set

- db: album.db
- query:

  ```
  SELECT DISTINCT album_id FROM track WHERE duration <= 90;

  SELECT * FROM album
    WHERE id IN (SELECT DISTINCT album_id FROM track WHERE duration <= 90)
  ;

  SELECT a.title AS album, a.artist, t.track_number AS seq, t.title, t.duration AS secs
    FROM album AS a
    JOIN track AS t
      ON t.album_id = a.id
    WHERE a.id IN (SELECT DISTINCT album_id FROM track WHERE duration <= 90)
    ORDER BY a.title, t.track_number
  ;

  SELECT a.title AS album, a.artist, t.track_number AS seq, t.title, t.duration AS secs
    FROM album AS a
    JOIN (
      SELECT DISTINCT album_id, track_number, duration, title
        FROM track
        WHERE duration <= 90
    ) AS t
      ON t.album_id = a.id
    ORDER BY a.title, t.track_number
  ;
  ```

### 11.3. Creating a view

- In SQL you can save a query as a view and you can use that view as if it were a table.
- A view is really just a saved query, and because the result of a SELECT is effectively a table, you can use a view anywhere you would use a table.

- db: album.db
- query:

  ```
  SELECT id, album_id, title, track_number,
    duration / 60 AS m, duration % 60 AS s FROM track;

  CREATE VIEW trackView AS
    SELECT id, album_id, title, track_number,
      duration / 60 AS m, duration % 60 AS s FROM track;
  SELECT * FROM trackView;

  SELECT a.title AS album, a.artist, t.track_number AS seq, t.title, t.m, t.s
    FROM album AS a
    JOIN trackView AS t
      ON t.album_id = a.id
    ORDER BY a.title, t.track_number
  ;

  DROP VIEW IF EXISTS trackView;
  ```

### 11.4. Creating a joined view

- db: album.db
- query:

  ```
  SELECT a.artist AS artist,
      a.title AS album,
      t.title AS track,
      t.track_number AS trackno,
      t.duration / 60 AS m,
      t.duration % 60 AS s
    FROM track AS t
      JOIN album AS a
        ON a.id = t.album_id
  ;

  CREATE VIEW joinedAlbum AS
    SELECT a.artist AS artist,
        a.title AS album,
        t.title AS track,
        t.track_number AS trackno,
        t.duration / 60 AS m,
        t.duration % 60 AS s
      FROM track AS t
      JOIN album AS a
        ON a.id = t.album_id
  ;

  SELECT * FROM joinedAlbum;
  SELECT * FROM joinedAlbum WHERE artist = 'Jimi Hendrix';

  SELECT artist, album, track, trackno,
    m || ':' || substr('00' || s, -2, 2) AS duration
      FROM joinedAlbum;

  DROP VIEW IF EXISTS joinedAlbum;
  ```

## 12. A Simple CRUD Application

### 12.1. Embedding SQL

- CRUD App UI

  - ![](images/12.1_CRUD%20app%20UI.png)

- [Code](CRUD/crud.php)

### 12.2. The SELECT functions

- db: album.db
- query:

  ```
  SELECT SEC_TO_TIME(320);
  SELECT TIME_TO_SEC('5:20');
  SELECT title, duration, SEC_TO_TIME(duration) FROM track;

  SELECT a.title, SUM(duration), SUM_SEC_TO_TIME(t.duration) FROM track AS t
    JOIN album AS a ON t.album_id = a.id
    GROUP BY a.id
  ```

- PHP functions for SELECT
  - `get_albums_sql()`
  - `get_tracks_sql($album_id)`
  - `fetch_album($id)`
  - `fetch_track($id)`

### 12.3. The INSERT, UPDATE, and DELETE functions

- `insert_album_sql($album)`

  - Use prepared statements to prevent any dangerous security issues, such as SQL injection

- `insert_track_sql($track)`
- `update_album_sql($album)`
- `update_track_sql($track)`
- `delete_album_sql($id)`
- `delete_track_sql($id)`

## 13. Conclusion

### 13.1. Goodbye
