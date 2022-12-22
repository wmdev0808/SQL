-- give the names of all of the customers who live in Boston

select full_name
from dbo.customer c 
where city_state_zip_id IN (
  select city_state_zip_id
  from dbo.city_state_zip
  where city_name = 'Boston'
)

select 
  c.full_name,
  z.city_name
from dbo.customer c 
inner join dbo.city_state_zip z 
  on c.city_state_zip_id = z.city_state_zip_id
where z.city_name = 'Boston'