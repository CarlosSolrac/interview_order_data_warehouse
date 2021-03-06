USE [CatchCo]
GO
/****** Object:  View [source].[dim_order_status]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [source].[dim_order_status]
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

GO
