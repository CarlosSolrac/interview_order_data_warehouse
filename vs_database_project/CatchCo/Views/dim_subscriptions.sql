
CREATE view [source].[dim_subscriptions]
as

select distinct
    subscription_id
    ,'[Not Specified]' as subscription_desc
from
    dbo.staging_orders
where
    subscription_id is not null


