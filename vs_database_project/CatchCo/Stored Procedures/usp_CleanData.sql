



CREATE proc [dbo].[usp_CleanData]
as

-- In production Regex would be used because TRIM only removes spaces.

UPDATE dbo.staging_orders_text
SET 
id = iif(trim(id) in ('', 'null'), null, trim(id) )
    ,reference_number = iif(trim(reference_number) in ('', 'null'), null, trim(reference_number) )
    ,status = iif(trim(status) in ('', 'null'), null, trim(status) )
    ,subscription_id = iif(trim(subscription_id) in ('', 'null'), null, trim(subscription_id) )
    ,state = iif(trim(state) in ('', 'null'), null, trim(state) )
    ,grand_total = iif(trim(grand_total) in ('', 'null'), null, trim(grand_total) )
    ,subtotal = iif(trim(subtotal) in ('', 'null'), null, trim(subtotal) )
    ,tax_amount = iif(trim(tax_amount) in ('', 'null'), null, trim(tax_amount) )
    ,total_due = iif(trim(total_due) in ('', 'null'), null, trim(total_due) )
    ,total_invoiced = iif(trim(total_invoiced) in ('', 'null'), null, trim(total_invoiced) )
    ,total_item_count = iif(trim(total_item_count) in ('', 'null'), null, trim(total_item_count) )
    ,total_paid = iif(trim(total_paid) in ('', 'null'), null, trim(total_paid) )
    ,total_qty_ordered = iif(trim(total_qty_ordered) in ('', 'null'), null, trim(total_qty_ordered) )
    ,total_refunded = iif(trim(total_refunded) in ('', 'null'), null, trim(total_refunded) )
    ,discount_amount = iif(trim(discount_amount) in ('', 'null'), null, trim(discount_amount) )
    ,order_currency_code = iif(trim(order_currency_code) in ('', 'null'), null, trim(order_currency_code) )
    ,giftcert_amount = iif(trim(giftcert_amount) in ('', 'null'), null, trim(giftcert_amount) )
    ,coupon_code = iif(trim(coupon_code) in ('', 'null'), null, trim(coupon_code) )
    ,coupon_rule_name = iif(trim(coupon_rule_name) in ('', 'null'), null, trim(coupon_rule_name) )
    ,customer_group_id = iif(trim(customer_group_id) in ('', 'null'), null, trim(customer_group_id) )
    ,customer_account_id = iif(trim(customer_account_id) in ('', 'null'), null, trim(customer_account_id) )
    ,customer_is_guest = iif(trim(customer_is_guest) in ('', 'null'), null, trim(customer_is_guest) )
    ,shipping_amount = iif(trim(shipping_amount) in ('', 'null'), null, trim(shipping_amount) )
    ,shipping_description = iif(trim(shipping_description) in ('', 'null'), null, trim(shipping_description) )    
    ,shipping_discount_amount = iif(trim(shipping_discount_amount) in ('', 'null'), null, trim(shipping_discount_amount) )
    ,shipping_hidden_tax_amount = iif(trim(shipping_hidden_tax_amount) in ('', 'null'), null, trim(shipping_hidden_tax_amount) )
    ,shipping_incl_tax = iif(trim(shipping_incl_tax) in ('', 'null'), null, trim(shipping_incl_tax) )
    ,shipping_invoiced = iif(trim(shipping_invoiced) in ('', 'null'), null, trim(shipping_invoiced) )
    ,shipping_method = iif(trim(shipping_method) in ('', 'null'), null, trim(shipping_method) )
    ,shipping_refunded = iif(trim(shipping_refunded) in ('', 'null'), null, trim(shipping_refunded) )
    ,how_did_you_hear = iif(trim(how_did_you_hear) in ('', 'null'), null, trim(how_did_you_hear) )
    ,how_did_you_hear_other = iif(trim(how_did_you_hear_other) in ('', 'null'), null, trim(how_did_you_hear_other) )
    ,created_at = iif(trim(created_at) in ('', 'null'), null, trim(created_at) )
    ,updated_at = iif(trim(updated_at) in ('', 'null'), null, trim(updated_at) )
    ,order_has_subscription = iif(trim(order_has_subscription) in ('', 'null'), null, trim(order_has_subscription) )
    ,order_has_ecommerce = iif(trim(order_has_ecommerce) in ('', 'null'), null, trim(order_has_ecommerce) )
    ,customer_email = iif(trim(customer_email) in ('', 'null'), null, trim(customer_email) )
    ,customer_fname = iif(trim(customer_fname) in ('', 'null'), null, trim(customer_fname) )
    ,customer_lname = iif(trim(customer_lname) in ('', 'null'), null, trim(customer_lname) )


UPDATE dbo.staging_customers_text
SET email = iif(trim(email) in ('', 'null'), null, trim(email) )
    ,fname = iif(trim(fname) in ('', 'null'), null, trim(fname) )
    ,lname = iif(trim(lname) in ('', 'null'), null, trim(lname) )


truncate table dbo.staging_orders
truncate table dbo.staging_customers

-- rely on automatic data conversion.
-- in production we use named columns or at least add code to verify the 
--  order of the columns match
insert into dbo.staging_orders
select * from dbo.staging_orders_text

insert into dbo.staging_customers
select * from dbo.staging_customers_text

