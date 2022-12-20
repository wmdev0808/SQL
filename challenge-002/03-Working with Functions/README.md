# Working with Functions

## Using SUM in SQL

```
SELECT SUM(num_desks)
FROM Departments
WHERE id >= 1 AND id <= 5;
```

## AVG, MIN, MAX, and COUNT in SQL

```
SELECT AVG(vacation_taken)
FROM Employees
WHERE department = 'Marketing';
```

```
SELECT MIN(vacation_taken)
FROM Employees
```

```
SELECT MAX(vacation_taken)
FROM
```

```
SELECT COUNT(id)
FROM Employees
WHERE vacation_taken > 20;
```

## Finding unique values in SQL

```
SELECT DISTINCT(tshirt_size)
FROM Employees
WHERE tshirt_size IS NOT NULL;
```

## UPPER, LOWER, and LENGTH in SQL

```
SELECT UPPER(first_name)
FROM Employees
```

```
SELECT LOWER(first_name)
FROM Employees
```

```
SELECT first_name
FROM Employees
WHERE LENGTH(first_name) > 4;
```
