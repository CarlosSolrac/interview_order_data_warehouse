USE [CatchCo]
GO

/****** Object:  View [dbo].[answers_from_data_warehouse]    Script Date: 5/14/2018 2:19:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/*


select * from  dbo.answers_from_data_warehouse


*/
ALTER view [dbo].[answers_from_data_warehouse]
as


/*
●	First order date
●	Latest order date
●	Lifetime gross revenue
●	Lifetime discounts
●	Lifetime net revenue
●	Lifetime # orders
-- Because NULL + 5 = NULL, we need to use isnull to avoid incorrect aggregation
*/
select
    c.email
    ,c.fname
    ,c.lname
    ,min(o.created_at) as first_order_date
    ,max(o.created_at) as lastest_order_date
    ,sum(iif(o.fact_orders_key is null, 0, o.grand_total)) as lifetime_gross_revenue
    ,sum(iif(status = 'canceled' or o.fact_orders_key is null, 0, o.grand_total)) as lifetime_gross_revenue_excluding_cancelations
    ,sum(iif(o.fact_orders_key is null, 0, o.discount_amount)) as lifetime_discounts
    ,sum(iif(status = 'canceled' or o.fact_orders_key is null, 0, o.discount_amount)) as lifetime_discounts_excluding_cancelations
    ,sum(iif(o.fact_orders_key is null, 0, isnull(o.grand_total,0) + isnull(o.discount_amount,0))) as lifetime_net_revenue
    ,sum(iif(status = 'canceled' or o.fact_orders_key is null, 0, isnull(o.grand_total, 0) + isnull(o.discount_amount,0))) as lifetime_net_revenue_excluding_cancelations
    ,count(o.fact_orders_key) as lifetime_number_orders
    ,sum(iif(status = 'canceled' or o.fact_orders_key is null, 0, 1)) as lifetime_number_orders_excluding_cancelations
from
    dbo.dim_customers c
    left join dbo.fact_orders o
        on c.dim_customers_key = o.dim_customers_key
    left join dbo.dim_order_status st
        on st.dim_order_status_key = o.dim_order_status_key
where
    c.dim_customers_key > 0
-- test edge cases
--    c.email = 'DKJOADK@NRCDJHU.PRD' -- account but no orders
--    or status = 'canceled' -- canceled
group by
    c.email
    ,c.fname
    ,c.lname





GO


