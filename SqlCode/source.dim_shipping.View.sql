USE [CatchCo]
GO
/****** Object:  View [source].[dim_shipping]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
