USE [CatchCo]
GO
/****** Object:  View [source].[dim_how_did_you_hear_other]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [source].[dim_how_did_you_hear_other]
as

select distinct
    how_did_you_hear_other
from
    dbo.staging_orders
where
    how_did_you_hear_other is not null
--order by 1,2

GO
