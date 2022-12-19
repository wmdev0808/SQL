# Window Functions

- PostgreSQL’s documentation does an excellent job of [introducing the concept of Window Functions](https://www.postgresql.org/docs/9.1/static/tutorial-window.html): a window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities. Behind the scenes, the window function is able to access more than just the current row of the query result.

  - Here is an example that shows how to compare each employee's salary with the average salary in his or her department:

    ```
    SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;
    ```

    | depname   | empno | salary | avg                   |
    | --------- | ----- | ------ | --------------------- |
    | develop   | 11    | 5200   | 5020.0000000000000000 |
    | develop   | 7     | 4200   | 5020.0000000000000000 |
    | develop   | 9     | 4500   | 5020.0000000000000000 |
    | develop   | 8     | 6000   | 5020.0000000000000000 |
    | develop   | 10    | 5200   | 5020.0000000000000000 |
    | personnel | 5     | 3500   | 3700.0000000000000000 |
    | personnel | 2     | 3900   | 3700.0000000000000000 |
    | sales     | 3     | 4800   | 4866.6666666666666667 |
    | sales     | 1     | 5000   | 4866.6666666666666667 |
    | sales     | 4     | 4800   | 4866.6666666666666667 |
    | (10 rows) |

  - The first three output columns come directly from the table `empsalary`, and there is one output row for each row in the table. The fourth column represents an average taken across all the table rows that have the same `depname` value as the current row. (This actually is the same function as the regular `avg` aggregate function, but the `OVER` clause causes it to be treated as a window function and computed across an appropriate set of rows.)

  - A window function call always contains an `OVER` clause directly following the window function's name and argument(s). This is what syntactically distinguishes it from a regular function or aggregate function. The `OVER` clause determines exactly how the rows of the query are split up for processing by the window function. The `PARTITION BY` list within `OVER` specifies dividing the rows into groups, or partitions, that share the same values of the `PARTITION BY` expression(s). For each row, the window function is computed across the rows that fall into the same partition as the current row.

  - You can also control the order in which rows are processed by window functions using `ORDER BY` within `OVER`. (The window `ORDER BY` does not even have to match the order in which the rows are output.) Here is an example:

    ```
    SELECT depname, empno, salary, rank() OVER (PARTITION BY depname ORDER BY salary DESC) FROM empsalary;
    ```

    | depname   | empno | salary | rank |
    | --------- | ----- | ------ | ---- |
    | develop   | 8     | 6000   | 1    |
    | develop   | 10    | 5200   | 2    |
    | develop   | 11    | 5200   | 2    |
    | develop   | 9     | 4500   | 4    |
    | develop   | 7     | 4200   | 5    |
    | personnel | 2     | 3900   | 1    |
    | personnel | 5     | 3500   | 2    |
    | sales     | 1     | 5000   | 1    |
    | sales     | 4     | 4800   | 2    |
    | sales     | 3     | 4800   | 2    |
    | (10 rows) |

  - As shown here, the rank function produces a numerical rank within the current row's partition for each distinct ORDER BY value, in the order defined by the ORDER BY clause. rank needs no explicit parameter, because its behavior is entirely determined by the OVER clause.

  - The rows considered by a window function are those of the "virtual table" produced by the query's FROM clause as filtered by its WHERE, GROUP BY, and HAVING clauses if any. For example, a row removed because it does not meet the WHERE condition is not seen by any window function. A query can contain multiple window functions that slice up the data in different ways by means of different OVER clauses, but they all act on the same collection of rows defined by this virtual table.

  - We already saw that ORDER BY can be omitted if the ordering of rows is not important. It is also possible to omit PARTITION BY, in which case there is just one partition containing all the rows.

  - There is another important concept associated with window functions: for each row, there is a set of rows within its partition called its window frame. Many (but not all) window functions act only on the rows of the window frame, rather than of the whole partition. By default, if ORDER BY is supplied then the frame consists of all rows from the start of the partition up through the current row, plus any following rows that are equal to the current row according to the ORDER BY clause. When ORDER BY is omitted the default frame consists of all rows in the partition. [1] Here is an example using sum:

    ```
    SELECT salary, sum(salary) OVER () FROM empsalary;
    ```

    | salary    | sum   |
    | --------- | ----- |
    | 5200      | 47100 |
    | 5000      | 47100 |
    | 3500      | 47100 |
    | 4800      | 47100 |
    | 3900      | 47100 |
    | 4200      | 47100 |
    | 4500      | 47100 |
    | 4800      | 47100 |
    | 6000      | 47100 |
    | 5200      | 47100 |
    | (10 rows) |

  - Above, since there is no `ORDER BY` in the `OVER` clause, the window frame is the same as the partition, which for lack of `PARTITION BY` is the whole table; in other words each sum is taken over the whole table and so we get the same result for each output row. But if we add an `ORDER BY` clause, we get very different results:

    ```
    SELECT salary, sum(salary) OVER (ORDER BY salary) FROM empsalary;
    ```

    | salary    | sum   |
    | --------- | ----- |
    | 3500      | 3500  |
    | 3900      | 7400  |
    | 4200      | 11600 |
    | 4500      | 16100 |
    | 4800      | 25700 |
    | 4800      | 25700 |
    | 5000      | 30700 |
    | 5200      | 41100 |
    | 5200      | 41100 |
    | 6000      | 47100 |
    | (10 rows) |

  - Here the sum is taken from the first (lowest) salary up through the current one, including any duplicates of the current one (notice the results for the duplicated salaries).

  - Window functions are permitted only in the `SELECT` list and the `ORDER BY` clause of the query. They are forbidden elsewhere, such as in `GROUP BY`, `HAVING` and `WHERE` clauses. This is because they logically execute after the processing of those clauses. Also, window functions execute after regular aggregate functions. This means it is valid to include an aggregate function call in the arguments of a window function, but not vice versa.

  - If there is a need to filter or group rows after the window calculations are performed, you can use a sub-select. For example:

    ```
    SELECT depname, empno, salary, enroll_date
    FROM
      (SELECT depname, empno, salary, enroll_date,
              rank() OVER (PARTITION BY depname ORDER BY salary DESC, empno) AS pos
        FROM empsalary
      ) AS ss
    WHERE pos < 3;
    ```

  - The above query only shows the rows from the inner query having rank less than 3.

  - When a query involves multiple window functions, it is possible to write out each one with a separate `OVER` clause, but this is duplicative and error-prone if the same windowing behavior is wanted for several functions. Instead, each windowing behavior can be named in a `WINDOW` clause and then referenced in `OVER`. For example:

    ```
    SELECT sum(salary) OVER w, avg(salary) OVER w
    FROM empsalary
    WINDOW w AS (PARTITION BY depname ORDER BY salary DESC);
    ```

- Through introducing window functions, we have also introduced two statements that you may not be familiar with: `OVER` and `PARTITION BY`. These are key to window functions. Not every window function uses `PARTITION BY`; we can also use `ORDER BY` or no statement at all depending on the query we want to run. You will practice using these clauses in the upcoming quizzes. If you want more details right now, [this resource](https://blog.sqlauthority.com/2015/11/04/sql-server-what-is-the-over-clause-notes-from-the-field-101/) from Pinal Dave is helpful.

- _Note: You can’t use window functions and standard aggregations in the same query. More specifically, you can’t include window functions in a `GROUP BY` clause_.

## Introduction to Window Functions

- It allows you to compare one row to another without doing any joints.
  - That means you want to do simple things like create a running total, as well as tricky things like determine whether one row was greater than the previous row, and classify it based on your finding.

## Winodw Functions

- Query

  ```
  SELECT standard_qty,
         DATE_TRUNC('month', occurred_at) AS month,
         SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occurred_at) ORDER BY occurred_at) AS running_total
  FROM demo.orders
  ```

- Result

  | standard_qty | month               | running_total |
  | ------------ | ------------------- | ------------- |
  | 0            | 2013-12-01 00:00:00 | 0             |
  | 490          | 2013-12-01 00:00:00 | 490           |
  | 528          | 2013-12-01 00:00:00 | 1018          |
  | 0            | 2013-12-01 00:00:00 | 1018          |
  | 492          | 2013-12-01 00:00:00 | 1510          |
  | 502          | 2013-12-01 00:00:00 | 2012          |
  | 53           | 2013-12-01 00:00:00 | 2065          |
  | ...          | ...                 | ...           |
  | 515          | 2014-01-01 00:00:00 | 515           |

  ...

- In case you're still stumped by order by, it simply orders the designated columns the same way the order by clause would, except that it treats every partition as separate.

- Without order by, each value will simply be a sum of all the standard quantity values in its respective month.

## Running Totals and Count

- Query

  ```
  SELECT id,
         account_id,
         occurred_at,
         ROW_NUMBER() OVER (ORDER BY id) AS row_num
  FROM demo.orders
  ```

- Result

  | id  | account_id | occurred_at         | row_num |
  | --- | ---------- | ------------------- | ------- |
  | 1   | 1001       | 2015-10-06 17:31:14 | 1       |
  | 2   | 1001       | 2015-11-05 03:34:33 | 2       |
  | 3   | 1001       | 2015-12-04 04:21:55 | 3       |
  | 4   | 1001       | 2016-01-02 01:18:24 | 4       |
  | 5   | 1001       | 2016-02-01 19:27:27 | 5       |

  ...

- If we order by occurred at, the rows are ordered differently, and the row num column is therefore assigned differently.

  - You can see that the row number no longer matches up with IDs.
  - Query

    ```
    SELECT id,
         account_id,
         occurred_at,
         ROW_NUMBER() OVER (ORDER BY id) AS row_num
      FROM demo.orders
    ```

  - Result:

    | id   | account_id | occurred_at         | row_num |
    | ---- | ---------- | ------------------- | ------- |
    | 5786 | 2861       | 2013-12-04 04:22:44 | 1       |
    | 2415 | 2861       | 2013-12-04 04:45:54 | 2       |
    | 4108 | 4311       | 2013-12-04 04:53:25 | 3       |
    | 4489 | 1281       | 2013-12-05 20:29:16 | 4       |
    | 287  | 1281       | 2013-12-05 20:33:56 | 5       |

    ...

- Using the partitioned by clause, we can start the count over at 1 again in each partition.

  - Let's partition by account ID see what this looks like.

  - This now shows us the row number within each account ID where row 1 is the first order that occurred.

- ROW_NUMBER

  - Query:

    ```
    SELECT id,
         account_id,
         occurred_at,
         ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY occurred_at) AS row_num
      FROM demo.orders
    ```

  - Result:

    | id   | account_id | occurred_at         | row_num |
    | ---- | ---------- | ------------------- | ------- |
    | 1    | 1001       | 2015-10-06 17:31:14 | 1       |
    | 4307 | 1001       | 2015-11-05 03:25:21 | 2       |
    | 4108 | 1001       | 2015-11-05 03:34:33 | 3       |
    | 4489 | 1001       | 2015-12-04 04:01:09 | 4       |
    | 287  | 1001       | 2015-12-04 04:21:55 | 5       |

    ...

- RANK

  - If two lines in a row have the same value for occurred at, they're given the same rank, whereas row number gives them different numbers.

  - Query:

    ```
    SELECT id,
         account_id,
         occurred_at,
         RANK() OVER (PARTITION BY account_id ORDER BY occurred_at) AS row_num
      FROM demo.orders
    ```

  - Result:

    | id   | account_id | occurred_at         | row_num |
    | ---- | ---------- | ------------------- | ------- |
    | 1    | 1001       | 2015-10-01 00:00:00 | 1       |
    | 4307 | 1001       | 2015-11-01 00:00:00 | 2       |
    | 2    | 1001       | 2015-11-01 00:00:00 | 2       |
    | 3    | 1001       | 2015-12-01 00:00:00 | 4       |
    | 4308 | 1001       | 2015-12-01 00:00:00 | 4       |

    ...

- DENSE_RANK

  - It doesn't skip values after assigning several rows with the same rank.

  - Query:

    ```
    SELECT id,
         account_id,
         occurred_at,
         RANK() OVER (PARTITION BY account_id ORDER BY occurred_at) AS row_num
      FROM demo.orders
    ```

  - Result:

    | id   | account_id | occurred_at         | row_num |
    | ---- | ---------- | ------------------- | ------- |
    | 1    | 1001       | 2015-10-01 00:00:00 | 1       |
    | 4307 | 1001       | 2015-11-01 00:00:00 | 2       |
    | 2    | 1001       | 2015-11-01 00:00:00 | 2       |
    | 3    | 1001       | 2015-12-01 00:00:00 | 3       |
    | 4308 | 1001       | 2015-12-01 00:00:00 | 3       |

    ...

## Aggregates in Window Functions

- Query

  ```
  SELECT id,
         account_id,
         standard_qty,
         DATE_TRUNC('month', occurred_at) AS month,
         DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS dense_rank,
         SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS sum_standard_qty,
         COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS count_standard_qty,
         AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS avg_standard_qty,
         MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS min_standard_qty,
         MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS max_standard_qty
  FROM demo.orders
  ```

- Result:

  | id   | account_id | standard_qty | month               | dense_rank | sum_standard_qty | count_standard_qty | avg_standard_qty | min_standard_qty | max_standard_qty |
  | ---- | ---------- | ------------ | ------------------- | ---------- | ---------------- | ------------------ | ---------------- | ---------------- | ---------------- |
  | 1    | 1001       | 123          | 2015-10-01 00:00:00 | 1          | 123              | 1                  | 123              | 123              | 123              |
  | 4307 | 1001       | 506          | 2015-11-01 00:00:00 | 2          | 819              | 3                  | 273              | 123              | 506              |
  | 2    | 1001       | 190          | 2015-11-01 00:00:00 | 2          | 819              | 3                  | 273              | 123              | 506              |
  | 3    | 1001       | 85           | 2015-12-01 00:00:00 | 3          | 1430             | 5                  | 286              | 85               | 526              |
  | 4308 | 1001       | 526          | 2015-12-01-00:00:00 | 3          | 1430             | 5                  | 286              | 85               | 526              |

  ...

## Aliases for Multiple Window Functions

- Query

  ```
  SELECT id,
         account_id,
         standard_qty,
         DATE_TRUNC('month', occurred_at) AS month,
         DENSE_RANK() OVER main_window AS dense_rank,
         SUM(standard_qty) OVER main_window AS sum_standard_qty,
         COUNT(standard_qty) OVER main_window AS count_standard_qty,
         AVG(standard_qty) OVER main_window AS avg_standard_qty,
         MIN(standard_qty) OVER main_window AS min_standard_qty,
         MAX(standard_qty) OVER main_window AS max_standard_qty
  FROM demo.orders
  WINDOW main_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at))
  ```

## Comparing Row to Previous Row

- Use case

  - It can often be useful to compare rows to preceding or following rows, especially if you've got the data in order that makes sense.
  - In this case, we're going to look at how much standard paper each account has purchased over all time.

    - We can see this in our inner query.

  - Now, let's use LAG and LEAD to create columns that pull values from other rows.
    - The syntax describes which column to pull from and how many rows away you'd like to do the pull.

- LAG

  - pulls from the previous rows
  - As you can see, the first row of the LAG column is null because there are no previous rows from which to pull
  - LAG value of the second column is zero.
    - It's pulling from the standard sum value in the prior column.
    - This continues down through the rest of the data set.

- LEAD

  - pulls from the following rows.
  - The LEAD column goes in the opposite direction.

- This can be especially useful for calculating differences between two rows.

  - LAG difference shows the difference between the current row and the prior row.
  - LEAD difference shows the difference between the current row and the next row.

- Query

  ```
  SELECT account_id,
         standard_sum,
         LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag,
         LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead,
         standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference,
         LEAD(standard_sum) OVER (ORDER BY standard_sum) - standard_sum AS lead_difference
  FROM (
    SELECT account_id,
           SUM(standard_qty) AS standard_sum
    FROM demo.orders
    GROUP BY 1
  ) sub
  ```

- Result

  | account_id | standard_sum | lag | lead | lag_difference | lead_difference |
  | ---------- | ------------ | --- | ---- | -------------- | --------------- |
  | 1901       | 0            |     | 79   |                | 79              |
  | 3371       | 79           | 0   | 102  | 79             | 23              |
  | 1961       | 102          | 79  | 116  | 23             | 14              |
  | 3401       | 116          | 102 | 117  | 14             | 1               |
  | 3741       | 117          | 116 | 123  | 1              | 6               |

  ...

## Introduction to Percentiles

- You looked at minimum, maximum, and average order sizes, to get a sense of what size order Parch and Posey should be prepared to fulfill at any given time.
- Really though, the best way to understand this, would be to look at percentiles,to see where the most orders fall.
- We can do this with the **NTILE** window function.

## Percentile

- The **NTILE** function allows you to see the percentile or any other subdivision that a given row falls into.

  - As you can see here, the number specified in the NTILE function is the number of parts into which you'll divide the window.
  - One hundred means percentiles, five means quintiles, and four means quartiles.
  - In this case, order by determines which column to use to determine the quartiles, here using standard quantity.
  - For each row, the NTILE four function will look at the value of standard quantity in that row compared to all the other rows in the window and then print the quartile that the value falls into.
  - So, a standard quantity of zero would fall in the first quartile, while the highest value would fall in the fourth quartile.

- Query

  ```
  SELECT id,
         account_id,
         occurred_at,
         standard_qty,
         NTILE(4) OVER (ORDER BY standard_qty) AS quartile,
         NTILE(5) OVER (ORDER BY standard_qty) AS quintile,
         NTILE(100) OVER (ORDER BY standard_qty) AS percentile
  FROM demo.orders
  ORDER BY standard_qty DESC
  ```

- RESULT

  | id   | account_id | occurred_at         | standard_qty | quartile | quintile | percentile |
  | ---- | ---------- | ------------------- | ------------ | -------- | -------- | ---------- |
  | 3892 | 4161       | 2016-06-24 13:32:55 | 22591        | 4        | 5        | 100        |
  | 4562 | 1341       | 2016-10-26 00:19:31 | 15649        | 4        | 5        | 100        |
  | 5479 | 2441       | 2016-10-21 21:08:01 | 7365         | 4        | 5        | 100        |
  | 5167 | 2041       | 2014-10-05 15:37:22 | 7083         | 4        | 5        | 100        |
  | 1112 | 1781       | 2015-09-05 05:58:04 | 6043         | 4        | 5        | 100        |
