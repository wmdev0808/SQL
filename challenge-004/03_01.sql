-- product ID (product)
-- flavor ID (product/oil_flavor)
-- flavor name (oil_flavor)
-- price (product)

select 
  p.product_id,
  f.flavor_id,
  f.flavor_name,
  p.price
from dbo.product p
inner join dbo.oil_flavor f 
  on p.flavor_id = f.flavor_id 