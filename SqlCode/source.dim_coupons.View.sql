USE [CatchCo]
GO
/****** Object:  View [source].[dim_coupons]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
