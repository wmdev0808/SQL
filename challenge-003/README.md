# Queries Made Easy

## Introduction

### Making a statement with SQL

#### What Is a Table

- Basic unit of storage

- Consists of rows and columns

- Contains information about users

- Can be created anytime, even while using database

#### Data Dictionary Tables

- Information about Oracle server users, privileges granted to users, table constraints

- We use these tables to see database objects owned by us

- Frequently used data dictionary tables:
  - USER_TABLES,
  - USER_OBJECTS, and
  - USER_CONSTRAINTS

#### MERGE

- To upadte or insert data in a table based on a condition
- If a row already exists in a table, it is updated
  - Otherwise, it inserts a new row in the table
- Improves performance
- Useful in data warehouse applications

```
MERGE INTO table_name table_alias
USING (table/view/subquery) alias
ON (join condition)
WHEN MATCHED THEN
  UPDATE SET col1=value1, col2=value2
WHEN NOT MATCHED THEN
  INSERT (column names) VALUES(column values);
```

#### Transaction controls

- Before

  - Changes can be reverted
  - Current user can view results, but others cannot view changes made by this user
  - Affected rows are locked

- After
  - All changes will be permanent and can't be reverted
  - All users can view the changes made by this user
  - Locks on affected rows are released

#### Data Types

| Data Type      | Description                               |
| -------------- | ----------------------------------------- |
| VARCHAR2(size) | Variable-length character data            |
| CHAR(size)     | Fixed-length character data               |
| NUMBER(p, s)   | Variable-length numeric data              |
| DATE           | Date and time values                      |
| LONG           | Variable-length character data up to 2 GB |
| CLOB           | Character data up to 4 GB                 |

### How to use the exercise files

- [Live SQL](https://livesql.oracle.com)
  - Create an account
  - Sign In
  - My Scripts
    - Upload Script
    - Run Script

## Creating Tables in Databases

## Manipulating Data

## Transaction Control

## Data Definition Language

## Conclusion
