
-- The number of orders per customer
select count(*), c.full_name
from dbo.customer c 
inner join dbo.product_order o 
  on c.customer_id = o.customer_id 
group by c.full_name

-- The order total per customer
select sum(o.order_total), c.full_name
from dbo.customer c 
inner join dbo.product_order o 
  on c.customer_id = o.customer_id 
group by c.full_name

-- The highest order total per year per customer
select 
  c.full_name,
  yr = year(o.order_date),
  highest_order_total = MAX(o.order_total)
from dbo.customer c 
inner join dbo.product_order o 
  on c.customer_id = o.customer_id 
group by c.full_name, year(o.order_date)
