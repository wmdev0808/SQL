declare @number int = 5

select 
  divisible = case 
    when @number % 2 = 0
      then 'divisible by 2'
    when @number % 3 = 0
      then 'divisible by 3'
    else 'does not meet the criteria' 
  end

-- return the full_name and spending tier for orders placed after 8/1/2020 by customers in CA
-- spending tier '1 - low' = order less than $20
-- spending tier '2 - medium' = order total between $20 and $100
-- spending tier '3 - high' = order total higher than $100
-- else = '0 - no recent orders'

select distinct
  c.full_name,
  spending_tier = case 
    when po.order_total < 20
      then '1 - low'
    when po.order_total between 20 and 100
      then '2 - medium'
    when po-order_total > 100
      then '3 - high'
    else '0 - no recent order'
  end 
from dbo.customer c 
left join dbo.product_order po 
  on c.customer_id = po.customer_id 
  and po.order_date > '8/1/2020'
where c.city_state_zip_id in (
    select z.city_state_zip_id
    from dbo.city_state_zip z 
    where z.state_name = 'California'
  )
order by c.full_name desc 