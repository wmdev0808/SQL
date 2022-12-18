# SQL Subqueries and Temporary Tables

- Topics

  1. Subqueries
  2. Table Expressions
  3. Persistent Derived Tables

- Both `subqueries` and `table expressions` are methods for being able to write a query that creates a table, and then write a query that interacts with this newly created table. Sometimes the question you are trying to answer doesn't have an answer when working directly with existing tables in database.

- However, if we were able to create new tables from the existing tables, we know we could query these new tables to answer our question. This is where the queries of this lesson come to the rescue.

## Introduction to Subqueries

- Allow you to answer more complex questions than you can with a single database table

- Some queries, also known as inner queries or nested queries, are a tool for performing operations in multiple steps.

  - For example, let's put our marketing manager hats back on.
    - We'd like to know which channels send the most traffic per day on average to Patch and Posey.
    - In order to do that, we'll need to aggregate events by channel by day, then we need to take those and average them.

- Whenever we need to use existing tables to create a new table that we then want to query again, this is an indication that we will need to use some sort of `subquery`.

## Your First Subquery

- We want to find the average number of events for each day for each channel. The first table will provide us the number of events for each day and channel, and then we will need to average these values together using a second query.

```
SELECT  channel,
        AVG(event_count) AS avg_event_count
FROM
(
  SELECT  DATE_TRUNC('day', occurred_at) AS day,
        channel,
        COUNT(*) as event_count
  FROM demo.web_events_full
  GROUP BY 1, 2
) sub
GROUP BY 1
ORDER BY 2 DESC
```

=>

| channel  | avg_event_count    |
| -------- | ------------------ |
| direct   | 4.8964879852125693 |
| organic  | 1.6672504378283713 |
| facebook | 1.5983471074380165 |
| adwords  | 1.5701906412478336 |
| twitter  | 1.3166666666666667 |
| banner   | 1.2899728997289973 |

## Subquery Formatting

- When writing Subqueries, it is easy for your query to look incredibly complex. In order to assist your reader, which is often just yourself at a future date, formatting SQL will help with understanding your code.

- The important thing to remember when using subqueries is to provide some way for the reader to easily determine which parts of the query will be executed together. Most people do this by indenting the subquery in some way.

### Badly Formatted Queries

- Though these poorly formatted examples will execute the same way as the well formatted examples, they just aren't very friendly for understanding what is happening!

- Here is the first, where it is impossible to decipher what is going on:

  ```
  SELECT * FROM (SELECT DATE_TRUNC('day',occurred_at) AS day, channel, COUNT(*) as events FROM web_events GROUP BY 1,2 ORDER BY 3 DESC) sub;
  ```

- This second version, which includes some helpful line breaks, is easier to read than that previous version, but it is still not as easy to read as the queries in the **Well Formatted Query** section.

  ```
  SELECT *
  FROM (
  SELECT DATE_TRUNC('day',occurred_at) AS day,
  channel, COUNT(*) as events
  FROM web_events
  GROUP BY 1,2
  ORDER BY 3 DESC) sub;
  ```

### Well Formatted Query

- Now for a well formatted example, you can see the table we are pulling from much easier than in the previous queries.

  ```
  SELECT *
  FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                  channel, COUNT(*) as events
        FROM web_events
        GROUP BY 1,2
        ORDER BY 3 DESC) sub;
  ```

- Additionally, if we have a `GROUP BY`, `ORDER BY`, `WHERE`, `HAVING`, or any other statement following our subquery, we would then indent it at the same level as our outer query.

- The query below is similar to the above, but it is applying additional statements to the outer query, so you can see there are `GROUP BY` and `ORDER BY` statements used on the output are not tabbed. The inner query `GROUP BY` and `ORDER BY` statements are indented to match the inner table.

  ```
  SELECT *
  FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                  channel, COUNT(*) as events
        FROM web_events
        GROUP BY 1,2
        ORDER BY 3 DESC) sub
  GROUP BY day, channel, events
  ORDER BY 2 DESC;
  ```

- These final two queries are so much easier to read!

## Subqueries Part II

- Subqueries can be used in several places within a query.
  - It can really be used anywhere you might use a table name or even a column name or an individual value.
- They're especially useful in conditional logic, in conjunction with where or Join clauses, or in the when portion of a case statement.

  - For example, you might want to return only orders that occurred in the same month as Parch and Posies first order ever.

    ```
    SELECT *
      FROM demo.orders
      WHERE DATE_TRUNC('month', occurred_at) =
        (SELECT DATE_TRUNC('month', MIN(occurred_at)) AS min_month
          FROM demo.orders)
      ORDER BY occurred_at
    ```

- Expert Tip

  - Note that you should not include an alias when you write a subquery in a conditional statement. This is because the subquery is treated as an individual value (or set of values in the `IN` case) rather than as a table.

  - Also, notice the query here compared a single value. If we returned an entire column `IN` would need to be used to perform a logical argument. If we are returning an entire table, then we must use an `ALIAS` for the table, and perform additional logic on the entire table.

## SQL Subquery

- Consider we want to know the top channel used by each account.

  - We can break this down into a couple of different tables and nest them within one another using subqueries.

  - It's really important that we first try to figure out what our ending table will look like.

  - we need to get an intermediate table first.

  ```
  SELECT t3.id, t3.name, t3.channel, t3.ct
  FROM (
    SELECT a.id, a.name, we.channel, COUNT(*) ct
    FROM accounts a
    JOIN web_events we
    ON a.id = we.account_id
    GROUP BY a.id, a.name, we.channel
  ) t3
  JOIN (
    SELECT t1.id, t1.name, MAX(ct) max_chan
    FROM (
      SELECT a.id, a.name, we.channel, COUNT(*) ct
      FROM accounts a
      JOIN web_events we
      ON a.id = we.account_id
      GROUP BY a.id, a.name, we.channel
    ) t1
    GROUP BY t1.id, t1.name
  ) t2
  ON t2.id = t3.id AND t2.max_chan = t3.ct
  ORDER BY t3.id, t3.ct;
  ```

=>

| id   | name               | channel  | ct  |
| ---- | ------------------ | -------- | --- |
| 1001 | Walmart            | direct   | 22  |
| 1011 | Exxon Mobil        | facebook | 1   |
| 1011 | Exxon Mobil        | adwords  | 1   |
| 1011 | Exxon Mobil        | direct   | 1   |
| 1021 | Apple              | facebook | 9   |
| 1021 | Apple              | direct   | 9   |
| 1031 | Berkshire Hathaway | facebook | 1   |
| 1031 | Berkshire Hathaway | direct   | 1   |

...

## Subquery Solution

## Common Table Expressions

- If you have a common table expression or subquery that takes a really long time to run, you might want to run it as a completely separate query and then write it back into the database as it's own table.

- Then, you can simply query the new table as you would any other, to finish the things you're trying to calculate.

- The big benefit to this approach is that you can improve the speed at which you explore.

  - Let's say you've got a subquery that takes an hour to run, and then you've got an outer query that's pretty fast.

  - If you run both of them every time you want to make a small tweak to the outer query, you're going to get really frustrated.

  - Instead, you can run that inner query once and write it to a table, then iterating on the outer query will be quick and easy.

## Subqueries Using WITH

```
SELECT  channel,
        AVG(event_count) AS avg_event_count
FROM (
  SELECT  DATE_TRUNC('day', occurred_at) AS day,
          channel,
          COUNT(*) AS event_count
  FROM demo.web_events_full
  GROUP BY 1, 2
) sub
GROUP BY 1
ORDER BY 2 DESC
```

- One problem with subqueries is that they can make your queries lengthy and difficult to read.

- Common Table expressions or CTEs can help break your query into separate components so that your query logic is more easily readable.

- Let's break the subquery out into his own common table expression which we'll create using the WITH command.

- Each common table expression gets an alias just like a subquery.

```
WITH events AS (SELECT DATE_TRUNC('day', occurred_at) AS day,
        channel,
        COUNT(*) AS event_count
  FROM demo.web_events_full
  GROUP BY 1, 2)

SELECT channel,
        AVG(event_count) AS avg_event_count
  FROM events
GROUP BY 1
ORDER BY 2 DESC
```

Result =>

| channel  | avg_event_count    |
| -------- | ------------------ |
| direct   | 4.8964879852125693 |
| organic  | 1.6672504378283713 |
| facebook | 1.5983471074380165 |
| adwords  | 1.5701906412478336 |
| twitter  | 1.3166666666666667 |
| banner   | 1.2899728997289973 |
