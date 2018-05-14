



CREATE view [source].[dim_customers]
as
/*

select * from source.dim_customers
order by email

*/

with cte
as (
        SELECT 
            coalesce(c.email, o.customer_email) as email
            ,coalesce(c.account_id, o.customer_account_id, -1) as account_id
            ,coalesce(c.fname, o.customer_fname, '[Not Specified]') as fname
            ,coalesce(c.lname, o.customer_lname, '[Not Specified]') as lname
            ,row_number() over(partition by coalesce(c.email, o.customer_email) order by 
                coalesce(c.account_id, o.customer_account_id, -1) desc,
                coalesce(c.fname, o.customer_fname, '[Not Specified]'),
                coalesce(c.lname, o.customer_lname, '[Not Specified]')
                ) as sort_order
        FROM 
            dbo.staging_customers c
            full outer join dbo.staging_orders o
                on c.email = o.customer_fname
)
select
    c.email
    ,c.account_id
    ,c.fname
    ,c.lname
from
    cte c
where
    c.sort_order = 1

/*

-- we don't have any cases where the account_id(s) don't match
SELECT distinct
    c.account_id
    ,o.customer_account_id
    ,c.email
    ,o.customer_email
    ,c.fname
    ,o.customer_fname
    ,c.lname
    ,o.customer_lname
FROM 
    dbo.staging_customers c
    full outer join dbo.staging_orders o
        on c.email = o.customer_email
where
    c.account_id is not null
    and o.customer_account_id is not null
    and c.account_id != o.customer_account_id


-- we do have the case where the account_id(s) are both null
SELECT distinct
    c.account_id, o.customer_account_id
    ,c.email, o.customer_email
    ,c.fname, o.customer_fname
    ,c.lname, o.customer_lname
FROM 
    dbo.staging_customers c
    full outer join dbo.staging_orders o
        on c.email = o.customer_email
where
    c.account_id is null
    and o.customer_account_id is null

*/


