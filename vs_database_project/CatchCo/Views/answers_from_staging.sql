


/*


select * from  dbo.answers_from_staging


*/
CREATE view [dbo].[answers_from_staging]
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
    coalesce(c.email, o.customer_email) as customer_email
    ,min(coalesce(c.fname, o.customer_fname)) as customer_fname
    ,min(coalesce(c.lname, o.customer_lname)) as customer_lname
    ,min(o.created_at) as first_order_date
    ,max(o.created_at) as lastest_order_date
    ,sum(iif(o.id is null, 0, o.grand_total)) as lifetime_gross_revenue
    ,sum(iif(status = 'canceled' or o.id is null, 0, o.grand_total)) as lifetime_gross_revenue_excluding_cancelations
    ,sum(iif(o.id is null, 0, o.discount_amount)) as lifetime_discounts
    ,sum(iif(status = 'canceled' or o.id is null, 0, o.discount_amount)) as lifetime_discounts_excluding_cancelations
    ,sum(iif(o.id is null, 0, isnull(o.grand_total,0) + isnull(o.discount_amount,0))) as lifetime_net_revenue
    ,sum(iif(status = 'canceled' or o.id is null, 0, isnull(o.grand_total, 0) + isnull(o.discount_amount,0))) as lifetime_net_revenue_excluding_cancelations
    ,count(o.id) as lifetime_number_orders
    ,sum(iif(status = 'canceled' or o.id is null, 0, 1)) as lifetime_number_orders_excluding_cancelations
from
    dbo.staging_customers c
    full outer join dbo.staging_orders o
        on c.email = o.customer_email
-- test edge cases
--where
--    c.email = 'DKJOADK@NRCDJHU.PRD' -- account but no orders
--    or status = 'canceled' -- canceled
group by
    coalesce(c.email, o.customer_email)





