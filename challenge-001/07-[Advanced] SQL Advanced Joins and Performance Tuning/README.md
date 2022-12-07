# [Advanced] SQL Advanced Joins and Performance Tuning

## Introduction to Advanced SQL

- we're going to cover more advanced joints and learn how to make queries that run quickly even over giant data sets.
- Most of the work in this lesson is about covering edge cases.

## JOINs with Comparison Operators Motivation

- So far, we've only performed joins by exactly matching values from one table to another.
- There are plenty of cases where you might not want to join this way, though.
- In order to understand how effective our campaigns are, we want to look at all the actions that a customer took prior to making their first paper purchase from Parch and Posey.
- To re-frame this, we want to look at all of the web traffic events that occurred before that account's first order.

## JOINs with Comparison Operators

- We'll start with a query that returns the first order from each account.
- Now, let's join the web events full table using an inequality join.
- You can see here that there are multiple conditional statements in the JOIN clause.

  - The first thing this query does is join events for which the account ID matches the account ID from the orders table.
  - The next line adds an additional filter using a less than operator.
    - Each row in the web events table is evaluated using that statement and the rows that are evaluated to be true are joined.

- One thing to keep in mind is that it's a little bit harder to predict what the results will look like when joining using inequalities.

- Query

  ```
  SELECT orders.id,
         orders.occurred_at AS order_date,
         events.*
  FROM demo.orders orders
  LEFT JOIN demo.web_events_full events
    ON events.account_id = orders.account_id
    AND events.occurred_at < orders.occurred_at
  WHERE DATE_TRUNC('month', orders.occurred_at) =
    (SELECT DATE_TRUNC('month', MIN(orders.occurred_at)) FROM demo.orders)
  ORDER BY orders.account_id, orders.occurred_at
  ```

- Result

  | id   | order_date          | account_id | occurred_at         | channel | referrer_url                                                          |
  | ---- | ------------------- | ---------- | ------------------- | ------- | --------------------------------------------------------------------- |
  | 153  | 2013-12-17 23:02:57 | 1181       | 2013-12-17 22:46:00 | direct  |                                                                       |
  | 4563 | 2013-12-17 23:02:57 | 1181       | 2013-12-17 04:45:00 | awards  | https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&... |
  | 250  | 2013-12-11 20:36:06 | 1251       | 2013-12-11 20:17:00 | direct  |                                                                       |
  | 4677 | 2013-12-11 20:36:06 | 1251       | 2013-12-11 02:43:00 | organic | http://blog.officezilla.com                                           |
  | 250  | 2013-12-11 20:42:09 | 1251       | 2013-12-11 20:17:00 | direct  |                                                                       |

## Self JOINs

- Sometimes it can be useful to join a table onto itself.
- Most of the time, you'll do this in order to find cases where two events both occur one after another.
- For example, imagine you want to know which accounts made multiple orders within 30 days.

  - One way to do this, would be to join the orders table onto itself with an inequality join.

- Query

  ```
  SELECT o1.id AS o1_id,
         o1.account_id AS o1_account_id,
         o1.occurred_at AS o1_occurred_at,
         o2.id AS o2_id,
         o2.account_id AS o2_account_id,
         o2.occurred_at AS o2_occurred_at
  FROM demo.orders o1
  LEFT JOIN demo.orders o2
    ON o1.account_id = o2.account_id
    AND o2.occurred_at > o1.occurred_at
    AND o2.occurred_at <= o1.occurred_at + INTERVAL '28 days'
  ORDER BY o1.account_id, o1.occurred_at
  ```

- Result

  | o1_id | o1_account_id | o1_occurred_at      | o2_id | o2_account_id | o2_occurred_at      |
  | ----- | ------------- | ------------------- | ----- | ------------- | ------------------- |
  | 1     | 1001          | 2015-10-06 17:31:14 |       |               |                     |
  | 4307  | 1001          | 2015-11-05 03:25:21 | 2     | 1001          | 2015-11-05 03:34:33 |
  | 2     | 1001          | 2015-11-05 03:34:33 |       |               |                     |
  | 4308  | 1001          | 2015-12-04 04:01:09 | 3     | 1001          | 2015-12-04 04:21:55 |
  | 3     | 1001          | 2015-12-04 04:21:55 |       |               |                     |
  | 4309  | 1001          | 2016-01-02 00:59:09 | 4     | 1001          | 2016-01-02 01:18:24 |
  | 4     | 1001          | 2016-01-02 01:18:24 |       |               |                     |
  | 4310  | 1001          | 2016-02-01 19:07:32 | 5     | 1001          | 2016-02-01 19:27:27 |
  | 5     | 1001          | 2016-02-01 19:27:27 |       |               |                     |
  | 6     | 1001          | 2016-03-02 15:29:32 | 4311  | 1001          | 2016-03-02 15:40:29 |

  ...

## UNION Motivation

- Joins allow you to combine two data sets side by side.
- But sometimes, it's necessary to stack one on top of another.
  - This might come in the form of several lists of events, email addresses, or anything else that might be stored in a few different places.
  - Alternatively, you might want to append an aggregation, like a sum, to the end of a list of individual records.
- You can do this with a union.

## UNION 1

- SQL has strict rules for appending data.

  - First, both tables must have the same number of columns.
  - Second, those columns must have the same data types in the same order as the first table.

- While the column names don't necessarily have to be the same, you'll find that they typically are.

  - This is because most instances in which you'd want to use UNION involve stitching together different parts of the same dataset.

- One thing to note is, that UNION only appends distinct values.

  - More specifically, when you use UNION, the dataset is appended and any rows in the appended dataset that are exactly identical to rows in the first table are dropped.

- If you'd like to append all of the values from the second table, use UNION ALL.

  - You'll likely use UNION ALL far more often than you use UNION.

- Query

  ```
  SELECT *
    FROM web_events
  UNION ALL
  SELECT *
    FROM web_events_2
  ```

## UNION 2

- Since you're writing two separate select statements when you union, you can treat them differently before appending.

  - For example, you can filter them differently using different where clauses.

    - Query

      ```
      SELECT *
        FROM web_events
        WHERE channel = 'fackebook'
      UNION ALL
      SELECT *
        FROM web_events_2
      ```

    - These results show only rows where the channel is equal to Facebook coming from demo.webevents.
    - These results show only rows from the Facebook channel for the first event table where all rows from the events two table will be returned.

## UNION 3

- Once you union two select statements together, you can perform operations on the entire combined data set rather than just on the individual parts.

- You can do this by unioning them together in a subquery so the combined results are treated as a single result set.

- Query

  ```
  WITH web_events AS (
    SELECT * FROM demo.web_events
    UNION ALL
    SELECT * FROM demo.web_events_2
  )

  SELECT channel,
         COUNT(*) AS sessions
    FROM web_events
  GROUP BY 1
  ORDER BY 2 DESC

  ```

- Result:

  | channel  | sessions |
  | -------- | -------- |
  | direct   | 10596    |
  | facebook | 1934     |
  | organic  | 1904     |
  | adwords  | 1812     |
  | banner   | 952      |
  | twitter  | 948      |

## Performance Tuning Motivation

- Even though databases are powerful, you may still find yourself running queries that take hours to return.
- In those cases, you want to take a little extra effort to write your queries in ways that will allow the database to execute them as fast as possible.
- you'll learn to identify when your queries can be improved and how to improve them.

## More on Performance Tuning

- It can only process as much information as the hardware is capable of handling.
- The way to make a query run faster, is to reduce the number of calculations that need to be performed.
- To do this, you'll need some understanding of how SQL actually makes those calculations.
- First, let's address some of the high level things that will affect the number of calculations a given query will make.

  - Table size is incredibly important.
    - If your query hits one or more tables with millions of rows or more, it could affect performance.
    - If your query joins two tables, in a way that substantially increases the row count of the result set, your query is likely to be slow.
    - And finally, aggregations can dramatically impact query runtime.
  - Combining multiple rows to produce a result requires more computation than simply retrieving those rows.

    - In particular, count distinct takes a very long time compared to the regular count, because it must check all rows against one another for duplicate values.

  - Query runtime is also dependent on some things that you really can't control that are related to the database itself.
    - The more queries running concurrently on a database, the more the database must process at a given time, and the slower everything will run.
    - It can be especially bad if others are running particularly resource intensive queries that fulfill some of the criteria that we just went over.
    - Also, different databases vary in speed for a given task.
      - For example, Postgres is optimized to read and write new rows quickly, while Redshift is optimized to perform fast aggregations.
    - This is something you probably can't control, but, if you know the system you're using, you can work within its bounds to make your queries more efficient.

## Performance Tuning 1

- Filtering the data to include only the observations you need, can dramatically improve query speed.

  - How you do this will depend entirely on the problem you're trying to solve.
    - For example, if you've got time series data, limiting to a small time window can make your queries run much more quickly.
    - Keep in mind that you can always perform exploratory analysis on a subset of data.
    - Refine your work into a final query, then remove the limitation and run your work across the entire data set.
      - The final query might take a long time to run, but at least you can run the intermediate steps quickly.
      - This is why most SQL editors automatically append a limit to most SQL queries.
    - It's worth noting that limit doesn't quite work the same way with aggregations.
      - The aggregation is performed first, then the results are limited to the specified number of rows.
      - So, if you're aggregating into one row, limit 10 will do nothing to speed up your query.
    - If you want to limit the data set before performing the count to speed things up a little more, you'll need to do it in a sub query.
      - In general, when working with sub queries, you should make sure to limit the amount of data you're working with in the place where it will be executed first, in order for it to have maximum impact on a query runtime.
        - This means usually putting limit in the sub query not the outer query.
      - Keep in mind, that applying a limit to a sub query will dramatically alter your results.
        - So, you should use it to test query logic but not to get actual results.

- Query

  ```
  SELECT account_id,
         SUM(poster_qty) AS sum_poster_qty
  FROM (SELECT * FROM demo.orders LIMIT 100) sub
  WHERE occurred_at >= '2016-01-01'
  AND occurred_at < '2016-07-01'
  GROUP BY 1
  ```

- RESULT:

  | account_id | sum_poster_qty |
  | ---------- | -------------- |
  | 1081       | 329            |
  | 1091       | 147            |
  | 1021       | 47             |
  | 1001       | 347            |
  | 1101       | 58             |

## Performance Tuning 2

- The second thing you can do, is make your joins less complicated.

  - Meaning, you can reduce the number of rows that are evaluated during the join.
  - In the same way that it's better to reduce data at a point in the query that is executed early, it's better to reduce table sizes before joining them.

    - Take this example, which joins the accounts table onto the events table.

      ```
      SELECT accounts.name,
             COUNT(*) AS web_events
      FROM demo.accounts accounts
      JOIN demo.web_events_full events
        ON events.account_id = accounts.id
      GROUP BY 1
      ORDER BY 2 DESC
      ```

    - There are 9,073 rows in the web events table. That means, that 9,073 rows need to be evaluated for matches in the other table.

    - But, if the web events table was pre-aggregated, you could reduce the number of rows that need to be evaluated in the join.

      - First, let's take a look at just a pre-aggregation.
        - This query returns only 351 rows.
        - So dropping this in a sub query and then joining it to the outer query, will reduce the cost of the join substantially.

      ```
      SELECT a.name,
             sub.web_events
      FROM (
        SELECT account_id,
               COUNT(*) AS web_events
        FROM demo.web_events_full events
        GROUP BY 1
      ) sub
      JOIN demo.accounts a
        On a.id = sub.account_id
      ORDER BY 2 DESC
      ```

## Performance Tuning 3

- You can add explain at the beginning of any working query to get a sense of how long it will take.

  - It's not perfectly accurate, but it's a useful tool.

- Query

  ```
  EXPLAIN
  SELECT *
    FROM demo.web_events_full
    WHERE occurred_at >= '2016-01-01'
    AND occurred_at < '2016-02-01'
  ```

- You'll get this output, which is called the query plan, and it shows the order in which your query will be executed.

  | QUERY PLAN                                                                                                                                           |
  | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
  | Seq Scan on web_events (cost=0.00..195.09 rows=280 width=23)                                                                                         |
  | Filter: ((occurred_at >= '2016-01-01 00:00:00'::timestamp without time zone) AND (occurred_at < '2016-02-01 00:00:00'::timestamp without time zone)) |

  - This is a pretty simple query plan.

- Let's add a limit and see how this changes.

  ```
  EXPLAIN
  SELECT *
      FROM web_events
      WHERE occurred_at >= '2016-01-01'
      AND occurred_at < '2016-02-01'
  LIMIT 100
  ```

  - Result =>

    | QUERY PLAN                                                                                                                                           |
    | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
    | Limit (cost=0.00..69.68 rows=100 width=23)                                                                                                           |
    | -> Seq Scan on web_events (cost=0.00..195.09 rows=280 width=23)                                                                                      |
    | Filter: ((occurred_at >= '2016-01-01 00:00:00'::timestamp without time zone) AND (occurred_at < '2016-02-01 00:00:00'::timestamp without time zone)) |

  - Since we know that the limit happens last, you can get a sense of the order in which the query plan is executed.

    - First, the filter is applied.
    - Then, the database reads the remaining rows and limits them, if applicable, to 100 rows.

  - You can see this measure of cost listed next to the number of rows.
    - Higher numbers means a longer run time.
    - You should use this more as a reference than an absolute measure.

- To be clear, this is most useful if you run explain on a query, modify the steps that are expensive, then run explain again to see if the cost is reduced.

## Joining Subqueries

- Sub queries can be especially helpful in improving the performance of your queries.

  - Imagine you're doing some high level reporting for Parch and Posey.
  - You'd like to see a bunch of metrics rolled up on a daily basis.
  - You could use this to power a dashboard that would help run the business day to day by quickly identifying anomalies.
  - To do this, you'll need to join data from a few tables and then aggregate by day.

- You could do all of this in one main query, but there are some big advantages to aggregating the tables individually in sub queries, then joining the pre-aggregated sub queries.

- First, let's look at how we would do this with one big query.

  - Query:

    ```
    SELECT DATE_TRUNC('day', o.occurred_at) AS date,
          COUNT(DISTINCT a.sales_rep_id) AS active_sales_reps,
          COUNT(DISTINCT o.id) AS orders,
          COUNT(DISTINCT we.id) AS web_visits
    FROM demo.accounts a
    JOIN demo.orders o
      ON o.account_id = a.id
    JOIN demo.web_events_full we
      ON DATE_TRUNC('day', we.occurred_at) = DATE_TRUNC('day', o.occurred_at)
    GROUP BY 1
    ORDER BY 1 DESC
    ```

  - One thing you can see here is that to do this properly, we have to join date fields which causes what you might call a data explosion.

  - Basically, what happens is that you're joining every row in a given day from one table onto every row with the same day in the other table.
  - So the number of rows returned is incredibly great.
  - Because of this multiplicative effect, you need to use count distinct instead of regular counts to get accurate counts of the sales rep, the orders, and ultimately, the web visits.
  - Just take a look at how big this data set gets before aggregating.

    ```
    SELECT o.occurred_at AS date,
           a.sales_rep_id,
           o.id AS order_id,
           we.id AS web_event_id
    FROM demo.accounts a
    JOIN demo.orders o
      ON o.account_id = a.id
    JOIN demo.web_events_full we
      ON DATE_TRUNC('day', we.occurred_at) = DATE_TRUNC('day', o.occurred_at)
    ORDER BY 1 DESC
    ```

  - You can see that executing the join this way returned 79,000 rows which then needed to be aggregated.

- You can get the same result set much more efficiently by aggregating the tables separately so that the counts are performed across far smaller data sets.

  - Here, we have written the first sub query.

    ```
    SELECT DATE_TRUNC('day', o.occurred_at) AS date,
           COUNT(a.sales_rep_id) AS active_sales_reps,
           COUNT(o.id) AS orders
    FROM demo.accounts a
    JOIN demo.orders o
      ON o.account_id = a.id
    GROUP BY 1
    ```

  - And here's the second sub query.

    ```
    SELECT DATE_TRUNC('day', we.occurred_at) AS date,
           COUNT(we.id) AS web_visits
    FROM dem.web_events_full we
    GROUP BY 1
    ```

  - As you can see, both of these sub queries are around 1000 rows.

  - This way, when we write our join, we'll be joining 1000 onto 1000 rows and joining dates onto other dates that match so it would be much less expensive.

  ```
  SELECT COALESCE(orders.date, web_events.date) AS date,
         orders.active_sales_reps,
         orders.orders,
         web_events.web_visits
  FROM (
    SELECT DATE_TRUNC('day', o.occurred_at) AS date,
           COUNT(a.sales_rep_id) AS active_sales_reps,
           COUNT(o.id) AS orders
    FROM demo.accounts a
    JOIN demo.orders o
      ON o.account_id = a.id
    GROUP BY 1
  ) orders

  FULL JOIN

  (
    SELECT DATE_TRUNC('day', we.occurred_at) AS date,
           COUNT(we.id) AS web_visits
    FROM demo.web_events_full we
    GROUP BY 1
  ) web_events

    ON web_events.date = orders.date
  ORDER BY 1 DESC
  ```

  - We're using a full join here just in case one table has observations in a month that the other table doesn't.

  - As we saw, both sub queries resolved to just about a 1000 rows, and the final query ends up at just about a 1000 rows as well.

  - So this is a whole lot better than the 79,000 rows that we saw earlier when we were joining without pre-aggregating in sub queries.
