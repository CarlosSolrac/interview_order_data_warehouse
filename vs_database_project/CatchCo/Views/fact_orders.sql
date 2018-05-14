
create view [source].[fact_orders]
as
/*
select * from [source].[fact_orders]
*/

SELECT 
     o.id
    ,isnull(cu.dim_customers_key, -1) as dim_customers_key
    ,isnull(st.[dim_order_status_key], -1) as dim_order_status_key
    ,isnull(s.dim_subscriptions_key, -1) as dim_subscriptions_key
    ,isnull(co.dim_coupons_key, -1) as dim_coupons_key
    ,isnull(how.dim_how_did_you_hear_key, -1) as dim_how_did_you_hear_key
    ,isnull(other.dim_how_did_you_hear_other_key, -1) as dim_how_did_you_hear_other_key
    ,coalesce(ship.dim_shipping_key, -1) as dim_shipping_key
    ,o.reference_number
    ,o.grand_total
    ,o.subtotal
    ,o.tax_amount
    ,o.total_due
    ,o.total_invoiced
    ,o.total_item_count
    ,o.total_paid
    ,o.total_qty_ordered
    ,o.total_refunded
    ,o.discount_amount
    ,o.order_currency_code
    ,1 as order_currency_exchange_rate
    ,o.giftcert_amount
    ,o.customer_group_id
    ,o.customer_account_id
    ,o.customer_is_guest
    ,o.shipping_amount
    ,o.shipping_discount_amount
    ,o.shipping_hidden_tax_amount
    ,o.shipping_incl_tax
    ,o.shipping_invoiced
    ,o.shipping_refunded
    ,o.created_at
    ,o.updated_at
    ,o.order_has_subscription
    ,o.order_has_ecommerce
FROM 
    dbo.staging_orders o
    left join dbo.dim_customers as cu
        on o.customer_email = cu.email
    left join dbo.dim_order_status as st
        on st.state = o.state
            and st.status = o.status
    left join dbo.dim_subscriptions as s
        on s.subscription_id = o.subscription_id
    left join dbo.dim_coupons as co
        on co.coupon_code = o.coupon_code
            and co.coupon_rule_name = o.coupon_rule_name
    left join dbo.dim_how_did_you_hear as how
        on how.how_did_you_hear = o.how_did_you_hear
    left join dbo.dim_how_did_you_hear_other as other
        on other.how_did_you_hear_other = o.how_did_you_hear_other
    left join dbo.dim_shipping as ship
        on ship.shipping_description = o.shipping_description
            and ship.shipping_method = o.shipping_method

