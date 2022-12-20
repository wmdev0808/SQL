# Organizing Data

## Sorting data

```
SELECT first_name, last_name, tshirt_size
FROM Employees
ORDER BY first_name DESC, first_name;
```

## Grouping data

```
SELECT department, COUNT(department) AS NumberOfEmployees
FROM Employees
GROUP BY department
HAVING NumberOfEmployees < 10
ORDER BY department;
```

## Using a pivot table in SQL

```
SELECT tshirt_size, COUNT(*) AS 'Total'
FROM Employees
GROUP BY tshirt_size
HAVING tshirt_size IS NOT NULL;
```

## Subqueries in SQL

```
SELECT * FROM Employees
WHERE vacation_taken = (SELECT MAX(vacation_taken) FROM Employees);
```

## Advanced subqueries in SQL

```
SELECT * FROM Employees
WHERE department IN (SELECT name FROM Departments WHERE state = 'OK')
ORDER BY department;
```
