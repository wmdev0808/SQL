-- get the full name and order total for every customer named in Sydney

select 
  c.full_name,
  po.order_total
from dbo.customer c  
left outer join dbo.product_order po 
  on c.customer_id = po.customer_id
where first_name = 'Sydney'

-- To get the customers who haven't yet placed orders

select 
  c.full_name,
  po.order_total
from dbo.customer c  
left outer join dbo.product_order po 
  on c.customer_id = po.customer_id
where po.order_total IS NULL