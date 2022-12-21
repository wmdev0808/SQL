# Queries Made Easy

## Introduction

### Making a statement with SQL

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

## Transaction Control

## Data Definition Language

## Conclusion
