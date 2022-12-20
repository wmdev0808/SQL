# SQL Basics

## Viewing data in SQL

```
SELECT * FROM Employees;
```

## Identifying columns in SQL

```
SELECT last_name AS 'Last Name', first_name, id FROM Employees;
```

## Filtering rows in SQL

```
SELECT * FROM Employees
WHERE department = "Marketing";
```

## Combining filters in SQL

```
SELECT first_name, last_name, department
FROM Employees
WHERE department = 'Marketing' AND tshirt_size = 'L';
```

```
...
WHERE department IS NOT 'Sales';
```

```
...
WHERE deaprtment = 'Sales' OR department = 'Marketing' OR department = 'Services'
```

```
SELECT first_name, last_name, department
FROM Employees
WHERE (department = 'Sales' OR department = 'Marketing')
  AND tshirt_size = 'L' AND first_name IS NOT 'Rikki';
```

## Limiting results in SQL

```
SELECT * FROM Employees
WHERE tshirt_size = 'L'
LIMIT 1 OFFSET 10;
```

## Comparing operators in SQL

```
SELECT * FROM Employees
wHERE vacation_taken > 9;
```

```
SELECT * FROM Employees
wHERE vacation_taken IS NOT 9;
```

## The LIKE operator in SQL

```
SELECT * FROM Employees
WHERE last_name LIKE '%t%';
```

```
SELECT * FROM Employees
WHERE last_name LIKE '_a%';
```
