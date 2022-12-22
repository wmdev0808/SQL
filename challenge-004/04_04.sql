-- Use alias in ORDER BY
select
  c.full_name,
  order_count = count(*)
from dbo.customer c 
inner join dbo.product_order o 
  on c.customer_id = o.customer_id 
group by c.full_name
order by order_count, c.full_name

-- Use HAVING to filter out the aggregated result
-- [Error]
select 
  customer_name = c.full_name,
  order_total = sum(o.order_total)
from dbo.customer c 
inner join dbo.product_order o 
  on c.customer_id = o.customer_id 
where sum(o.order_total) > 500
group by c.full_name

-- [Correct]
select 
  customer_name = c.full_name,
  order_total = sum(o.order_total)
from dbo.customer c 
inner join dbo.product_order o 
  on c.customer_id = o.customer_id 
group by c.full_name
having sum(o.order_total) > 500