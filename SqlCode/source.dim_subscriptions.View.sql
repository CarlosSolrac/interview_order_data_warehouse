USE [CatchCo]
GO
/****** Object:  View [source].[dim_subscriptions]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [source].[dim_subscriptions]
as

select distinct
    subscription_id
    ,'[Not Specified]' as subscription_desc
from
    dbo.staging_orders
where
    subscription_id is not null


GO
