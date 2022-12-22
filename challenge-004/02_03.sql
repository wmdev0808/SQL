-- Base query

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service

-- find the rows where the service name is 'Catering - Lunch'

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name = 'Catering - Lunch'

-- find the rows where the service name is not 'Catering - Lunch'

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name != 'Catering - Lunch'

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name <> 'Catering - Lunch'

-- find the rows where the service name is 'Gift Basket Delivery - Small', 'Gift Basket Delivery - Medium', or 'Gift Basket Delivery - Large'

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name IN ('Gift Basket Delivery - Small', 'Gift Basket Delivery - Medium', 'Gift Basket Delivery - Large')

-- find the rows where the service name is not 'Gift Basket Delivery - Small', 'Gift Basket Delivery - Medium', or 'Gift Basket Delivery - Large'

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name NOT IN ( --filtering condition
  'Gift Basket Delivery - Small',
  'Gift Basket Delivery - Medium',
  'Gift Basket Delivery - Large')

-- find the rows where the service name starts with 'Gift Basket Delivery'

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name LIkE 'Gift Basket Delivery%'

-- find the rows where the service name contains 'Party'

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name LIkE '%Party%'

-- find the rows where the service name does not start with 'Gift Basket Delivery'

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name NOT LIkE 'Gift Basket Delivery%'

-- find the rows where the price per person is between $75 and $125

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where per_person_price between 75 and 125

-- find the rows where the price per person is less than $75

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where per_person_price < 75

-- find the rows where the price per person is $125 or more

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where per_person_price >= 125

-- when are NULL values returned?

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where min_participants IS NULL

select
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where min_participants IS NOT NULL