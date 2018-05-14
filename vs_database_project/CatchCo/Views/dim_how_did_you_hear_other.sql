CREATE view source.dim_how_did_you_hear_other
as

select distinct
    how_did_you_hear_other
from
    dbo.staging_orders
where
    how_did_you_hear_other is not null
--order by 1,2

