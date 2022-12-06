# SQL Subqueries and Temporary Tables

## Introduction to Subqueries

- Allow you to answer more complex questions than you can with a single database table

- Some queries, also known as inner queries or nested queries, are a tool for performing operations in multiple steps.

  - For example, let's put our marketing manager hats back on.
    - We'd like to know which channels send the most traffic per day on average to Patch and Posey.
    - In order to do that, we'll need to aggregate events by channel by day, then we need to take those and average them.

## Your First Subquery

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
