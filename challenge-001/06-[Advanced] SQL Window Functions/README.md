# Window Functions

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
