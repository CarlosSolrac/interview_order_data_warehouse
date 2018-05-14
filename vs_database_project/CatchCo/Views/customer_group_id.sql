

/*

select * from debug.customer_group_id order by customer_email,created_at

*/
CREATE view debug.customer_group_id
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

