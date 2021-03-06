USE [CatchCo]
GO
/****** Object:  View [debug].[customer_group_id]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*

select * from debug.customer_group_id order by customer_email,created_at

*/
CREATE view [debug].[customer_group_id]
as

select  
    customer_email,
    cast(created_at as datetime2) as created_at,
    customer_group_id
from
    staging_orders
where
    customer_email in (
        select  
            customer_email
        from
            staging_orders
        group by
            customer_email
        having
            count(distinct customer_group_id) > 1
    )
--order by 1,2

GO
