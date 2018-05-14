CREATE view source.[dim_how_did_you_hear]
as

select distinct
    how_did_you_hear
from
    dbo.staging_orders
where
    how_did_you_hear is not null
--order by 1,2

