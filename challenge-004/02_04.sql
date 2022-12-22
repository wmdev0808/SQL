select 
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service

-- find the rows for services that require no more than 6 participants and costs no more than $25 per person

select 
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where min_participants <= 6 
  and per_person_price <= 25


-- filter again to just show the catering services that meet the last criteria

select 
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where min_participants <= 6 
  and per_person_price <= 25
  and srvc_name like 'catering%'

-- find the rows for either catering services, gift baskets, or the Two Trees Tasting Party

select 
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where srvc_name like 'catering%'
  or srvc_name like 'gift%'
  or srvc_name = 'two Trees Tasting Party'

-- find the rows for services that cost less than $30 that are either catering or gift baskets

select 
  srvc_name,
  min_participants,
  per_person_price
from dbo.additional_service
where per_person_price < 30
  and 
  (
    srvc_name like 'catering%'
    or 
    srvc_name like 'gift%'
  )

