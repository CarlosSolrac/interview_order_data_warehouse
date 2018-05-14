
CREATE view [source].[dim_coupons]
as

select distinct
   isnull(coupon_code, '[Not Specified]') as coupon_code
    ,isnull(coupon_rule_name, '[Not Specified]') as coupon_rule_name
from
    dbo.staging_orders
where
    coupon_code is not null
    or coupon_rule_name is not null
--order by 1,2

