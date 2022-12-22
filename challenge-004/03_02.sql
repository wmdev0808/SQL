--product ID (product)
--flavor ID (product/oil_flavor)
--flavor name (oil_flavor)
--price (product)

--ADD
-- product type ID
-- product type

select 
  p.product_id,
  f.flavor_id,
  f.flavor_name,
  p.price,
  pt.*
from dbo.product p 
inner join dbo.oil_flavor f 
  on p.flavor_id = f.flavor_id
inner join dbo.product_type pt 
  on p.product_type_id = pt.product_type_id
where pt.product_type = 'Case'