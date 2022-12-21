# Queries Made Easy

## Introduction

### Making a statement with SQL

### How to use the exercise files

- [Live SQL](https://livesql.oracle.com)
  - Create an account
  - Sign In
  - My Scripts
    - Upload Script
    - Run Script

## Creating Tables in Databases

### What is a table and naming conventions

- What Is a Table

  - Basic unit of storage

  - Consists of rows and columns

  - Contains information about users

  - Can be created anytime, even while using database

- Naming Conventions

  - Must begin with a letter
  - Must be 1-30 characters long
  - Not an Oracle reserved keyword
  - No duplicate name of another object used by same user
  - Contains only A-Z, a-z, 0-9, `_`, $, and #

### Database table types

- User Tables

  - Collection of tables created and maintained by the users
  - Contains user information
  - Owned by different users

- Data Dictionary Tables

  - Collection of tables created and maintained by Oracle server
  - Contains database information
  - Owned by SYS user

- Data Dictionary Tables in more detail

  - Information about Oracle server users, privileges granted to users, table constraints

  - We use these tables to see database objects owned by us

  - Frequently used data dictionary tables:
    - USER_TABLES,
    - USER_OBJECTS, and
    - USER_CONSTRAINTS

### Datatypes for columns in tables

- Data Types

  | Data Type        | Description                                                                   |
  | ---------------- | ----------------------------------------------------------------------------- |
  | VARCHAR2(size)   | Variable-length character data                                                |
  | CHAR(size)       | Fixed-length character data                                                   |
  | NUMBER(p, s)     | Variable-length numeric data                                                  |
  | DATE             | Date and time values                                                          |
  | LONG             | Variable-length character data up to 2 GB                                     |
  | CLOB             | Character data up to 4 GB                                                     |
  | RAW and LONG RAW | Raw binary data                                                               |
  | BLOB             | Binary data up to 4 GB                                                        |
  | BFILE            | Binary data stored in an external file, up to 4 GB                            |
  | ROWID            | Base64 numbering system representing the unique address of a row in its table |

## Manipulating Data

### Add rows in tables

- Data Manipulation Language (DML)

  - INSERT
  - UPDATE
  - DELETE
  - MERGE

- INSERT

  - Syntax: INSERT INTO table_name(column1, ...) VALUES(value1, ...);
  - One row is inserted at a time using this syntax

  ```
  --Insert rows into dept_tab
  SELECT * FROM dept_tab;

  INSERT INTO dept_tab VALUES(10, 'Administration', 200, 1700);

  INSERT INTO dept_tab(deptno, location_id, mgr_id, dname) VALUES(20, 1800, 210, 'Marketing');
  ```

  ```
  INSERT INTO dept_tab VALUES(50, 'Strategy', NULL, NULL);
  ```

  - `NULL` is not equivalent emtpy value

  ```
  --Insert special functions like sysdate
  INSERT INTO emp_tab VALUES(100, 'SCOTT', 'PROGRAMMER', 210, SYSDATE, 10000, 3000, 10);
  ```

  => 100 SCOTT PROGRAMMER 210 05-OCT-20 10000 3000 10

- INSERT Using Script

  - Use & substitution in a SQL statement to prompt for values at runtime

    - Example:

      ```
      INSERT INTO dept_tab
      VALUES (&deptno, '&dname', '&location');
      ```

  - Multiple rows can be inserted at a time

  - Save the script to a file on the computer and run the script file

- Copy Rows from Another Table

  - Use subquery in the INSERT statement
  - Multiple rows can be inserted
  - Do not use VALUES clause in the INSERT statement
  - The number of columns in the subquery should be eqaul to number of columns in the INSERT clause
  - To make a copy of an existing table

    ```
    INSERT INTO new_table_name SELECT * FROM old_table_name where condition;
    ```

### Modify rows and columns in tables

- UPDATE

  - To modify data in tables

    ```
    UPDATE table_name
    SET column_name=value,
    [column_name=value, ...]
    [WHERE condition];
    ```

  - Can update one or more rows at a time
  - If WHERE clause is not specified, all rows in the table are modified

- Modify one row in `emp_tab`

  ```
  SELECT * FROM emp_tab;

  UPDATE emp_tab SET salary=8000 WHERE empno=7001;
  ```

- Modify multiple columns using subquery

  - Can modifiy multiple columns using subquery in `SET` clause

    ```
    UPDATE table
    SET column=(SELECT column FROM table WHERE condition),
    [column=(SELECT column FROM table WHERE condition)]
    WHERE condition;
    ```

  - Use subqueries to modify data in the same table or another table

  ```
  UPDATE emp_tab
  SET
    manager=(SELECT manager FROM emp_tab WHERE empno=7001),
    salary=(SELECT salary FROM emp_tab WHERE empno=7001)
  WHERE empno=7002;
  ```

- Modify row in a different table using subquery

  ```
  SELECT * FROM old_emp_tab;

  UPDATE old_emp_tab SET salary=(SELECT salary FROM emp_tab WHERE empno=7001) WHERE empno=7001;
  ```

- Integrity constraint error

  - If you try to modify a row to a value that does not exist in the parent table, it returns the integrity constraint error

  ```
  UPDATE emp_tab SET deptno=500 where deptno=10;
  ```

  - Because there is no `deptno` `500` in `dept_tab` which is the parent table of `emp_tab`

### Delete rows in tables

- DELETE

  - Used to delete rows from a table
  - Syntax:

    ```
    DELETE FROM
    table_name [WHERE condition];
    ```

  - Specific rows are deleted if WHERE clause is specified
  - All rows are deleted if WHERE clause is omitted

- Example:

  - Delete one row from a table

    ```
    SELECT * FROM emp_tab;

    DELETE FROM emp_tab WHERE empno=7007;
    ```

- DELETE Based on Another Table

  - Use subqueries in DELETE to remove rows based on values in another table

    ```
    DELETE FROM old_emp_tab
    WHERE salary=(SELECT salary from emp_tab where salary<1000);
    ```

  - Example:

    - Delete rows based on another table using a subquery

      ```
      SELECT * FROM old_emp_tab;

      DELETE FROM old_emp_tab WHERE salary=(SELECT salary FROM emp_tab WHERE salary < 1000);
      ```

- An integrity constraint error is returned when we try to delete a row that contains a primary key and is used as a foreign key in another table

  - Example:

    ```
    DELETE FROM dept_tab WHERE deptno=10;
    ```

### Merge rows in tables

- `MERGE`

  - To upadte or insert data in a table based on a condition
  - If a row already exists in a table, it is updated
    - Otherwise, it inserts a new row in the table
  - Improves performance
  - Useful in data warehouse applications

- Syntax

  ```
  MERGE INTO table_name table_alias
  USING (table/view/subquery) alias
  ON (join condition)
  WHEN MATCHED THEN
    UPDATE SET col1=value1, col2=value2
  WHEN NOT MATCHED THEN
    INSERT (column names) VALUES(column values);
  ```

- Example:

  - Merge statement to update or insert rows into `dept_copy_tab`

    ```
    SELECT * FROM dept_copy_tab;

    MERGE INTO dept_copy_tab dc USING dept_tab d ON (dc.deptno=d.deptno) WHEN MATCHED THEN UPDATE SET dc.mgr_id=300 WHEN NOT MATCHED THEN INSERT VALUES (d.deptno, d.dname, d.mgr_id, d.location_id);
    ```

## Transaction Control

### Committing database changes

- Transaction Control Language (TCL)

  - TCL: COMMIT, ROLLBACK, SAVEPOINT
  - Transaction is a collection of DML statements that form a logical block
  - A transaction starts with the first DML statement
  - A transaction ends when:
    - Commit/rollback is given
    - DDL/DCL statements are executed (autocommit occurs)
    - User exits the system or system crashes

- COMMIT

  - It ends current transaction and saves all the data changes
  - For DML, we need to issue commit explicitly to save changes
  - DDL and DCL statements are autocommit
  - Autocommit also occurs when user normally exits the system without explicitly issuing a COMMIT statement

- Comparison:

  - Before

    - Changes can be reverted
    - Current user can view results, but others cannot view changes made by this user
    - Affected rows are locked

  - After
    - All changes will be permanent and can't be reverted
    - All users can view the changes made by this user
    - Locks on affected rows are released

### Rollback in database changes

- ROLLBACK and SAVEPOINT

  - `ROLLBACK` discards all pending data changes and ends current transaction
  - `SAVEPOINT` creates a marker point within a transaction
  - AutoRollback occurs when there is a system failure or abnormal termination of the system
  - By using COMMIT and ROLLBACK, we can preview data changes before making them permanent

- Example

  - COMMIT
    Reverts all below changes and returns to this stage
    <===================================================== `ROLLBACK`
    NEW TRANSACTION
    INSERT
    UPDATE
    `SAVEPOINT A`
    Reverts below changes and returns to `Savepoint A`
    <==========================================================Rollback `SAVEPOINT A`
    DELETE
    INSERT
    `SAVEPOINT B`
    Reverts below changes and returns to Savepoint B
    <==========================================================Rollback `SAVEPOINT B`
    DELETE

- Comparison:

  - Before

    - Changes made cannot be reverted
    - Affected rows are locked
    - Current user can view results of data changes but others cannot view those results

  - After
    - Data changes are reverted
    - All locks on affected rows are released
    - All data changes are discarded, so no access to anyone

## Data Definition Language

### Different ways to create tables

- CREATE Statement

  - A data definition language (DDL) statement
  - Syntax:

    ```
    CREATE TABLE [schema.]table_name (column datatype [default expression], [...]);
    ```

  - Tables belonging to other users are not in the user's schema:

    ```
    SELECT * FROM schema_name.table_name;
    ```

  - To check and confirm a table creation, we use this syntax:

    ```
    DESCRIBE table_name; (or) DESC table_name;
    ```

- Constraints

  - Enforces rules at table level
  - Defined at table level or column level
  - Prevent the deletion of a table when there are dependencies
  - Must be satisfied for the operations to succeed

  - Examples:
    - Primary Key
      - Uniquely for every row thus helps to identify each row in the table
    - Foreign key
      - Establishes a connection between the column in this table and the column of the referenced table
    - Not NULL
      - Specifies that the column cannot contain a NULL value

- Examples:

  - Create a table with primary key and Not null constraints

    ```
    CREATE TABLE countries (
      country_id NUMBER(10),
      country_name VARCHAR2(20),
      country_code VARCHAR2(10) CONSTRAINT countries_country_code_nn NOT NULL,
      country_region VARCHAR2(20),
      total_customers NUMBER(20),
      profit_country_level NUMBER(20),
      CONSTRAINT countries_country_id_pk PRIMARY KEY(country_id)
    );
    ```

    - As you can see, you can give `column-level` or `table-level` constraints

  - Create a table with foreign key constraint

    ```
    CREATE TABLE states (
      state_id NUMBER(10),
      state_name VARCHAR2(20),
      state_region VARCHAR2(20),
      country_id NUMBER(10),
      total_customers NUMBER(20),
      profit_state_level NUMBER(20),
      CONSTRAINT states_state_id_pk PRIMARY KEY(state_id),
      CONSTRAINT states_country_id_fk FOREIGN KEY(country_id) REFERENCES countries(country_id)
    );
    ```

- Create Table Using Subquery

  - Syntax:

    ```
    CREATE TABLE table [(column, column, ...)] AS subquery;
    ```

  - Example:

    ```
    CREATE TABLE employees_dept40 AS (SELECT empno, name, job, salary FROM emp_tab where deptno=40);
    ```

### Alter tables

- ALTER Statement

  - DDL statement
  - Used to add, modify, or drop columns from a table
  - Add columns to a table:

    ```
    ALTER TABLE table_name ADD (column datatype [default expr][, column datatype, ...]);
    ```

    - Ex): Add a new column in a table

      ```
      ALTER TABLE states ADD (test_col VARCHAR2(5));

      SELECT * FROM user_tab_columns WHERE table_name='STATES';
      ```

  - Modify columns in a table:

    ```
    ALTER TABLE table_name MODIFY (column datatype [default expr][, column datatype, ...]);
    ```

    - Ex): Change datatype or size of a column

      ```
      ALTER TABLE states MODIFY(test_col VARCHAR2(20));
      ```

  - Drop columns from a table:

    ```
    ALTER TABLE table_name DROP COLUMN column_name;
    ```

    - Ex): Delete a column from a table

      ```
      ALTER TABLE states DROP COLUMN test_col;
      ```

  - All DDL statements are autocommit
    - Once changes are made, the old state of data cannot be recovered

### Drop, rename, and truncate tables

- Other DDL Statements

  - `DROP` a table, syntax: `DROP TABLE table_name;`

    - Removes all rows from a table and the table structure
    - Pending transactions will be committed
    - Changes cannot be reverted as it is autocommit

    - Ex): Drop a table

      ```
      DROP TABLE dept_copy_tab;
      ```

  - `RENAME` a table, syntax: `RENAME table1 TO table2;`

    - Rename a table, view, synonym, or sequence

    ```
    RENAME states TO states_sales_tab;
    ```

  - `TRUNCATE` a table, syntax: `TRUNCATE TABLE table_name;`
    - Removes all rows and also releases storage space used by the table

## Conclusion

### Next steps

- `Getting Started with SQL: A Hands-On Approach for Beginners` by Thomas Nield

- `SQL Practice Problems: 57 beginning, intermediate, and advanced challenges for you to solve using a "learn-by-doing" approach` by sylvia Moestl Vasilik
