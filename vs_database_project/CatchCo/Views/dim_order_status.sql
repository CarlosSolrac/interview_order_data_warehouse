
CREATE view [source].dim_order_status
as

select distinct
    isnull(state, '[Not Specified]') as state
    ,isnull(status, '[Not Specified]') as status
from
    dbo.staging_orders
where
    status is not null
    or state is not null
--order by 1,2

