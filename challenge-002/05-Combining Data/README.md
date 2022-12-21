# Combining Data

## Using JOINs

```
SELECT first_name, last_name, name
FROM Employees
JOIN Departments ON Employees.id = Departments.office_manager_id;
```

- Note: Without `ON` clause, `(INNER) JOIN` is equivalent to `CROSS JOIN`

## The different types of JOINs

- INNER JOIN

  ```
  SELECT first_name, last_name, name
  FROM Employees
  INNER JOIN Departments ON Employees.id = Departments.office_manager_id;
  ```

- LEFT JOIN

  ```
  SELECT first_name, last_name, date_complete
  FROM Employees
  LEFT JOIN ComplianceTraining
  ON Employees.id = ComplianceTraning.employee_id;
  ```

## Using VLOOKUP, HLOOKUP, XLOOKUP in SQL

- Excel `VLOOKUP` equivalent SQL

  ```
  SELECT first_name, last_name, department, state
  FROM Employees
  JOIN departments ON Employees.department = Departments.name;
  ```
