
CREATE view [source].[dim_shipping]
as

select distinct
    isnull(shipping_description, '[Not Specified]') as shipping_description
    ,isnull(shipping_method, '[Not Specified]') as shipping_method
from
    dbo.staging_orders
where
    shipping_description is not null
    or shipping_method is not null
--order by 1,2

