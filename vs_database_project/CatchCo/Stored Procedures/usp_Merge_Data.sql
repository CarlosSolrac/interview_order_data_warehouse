


CREATE proc [dbo].[usp_Merge_Data]
as


--     truncate table dbo.dim_customers;


MERGE dbo.dim_coupons AS Tgt
USING source.dim_coupons AS Src
ON (Tgt.[coupon_code] = Src.[coupon_code] and Tgt.[coupon_rule_name] = Src.[coupon_rule_name]) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT([coupon_code], [coupon_rule_name]) 
	VALUES([coupon_code], [coupon_rule_name])
    ;


MERGE dbo.dim_customers AS Tgt
USING source.dim_customers AS Src
ON (Tgt.[email] = Src.[email]) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT([account_id], [email], [fname], [lname]) 
	VALUES([account_id], [email], [fname], [lname])
WHEN MATCHED AND (
	dbo.ufn_IsValuesIdentical(Src.[account_id], Tgt.[account_id]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[fname], Tgt.[fname]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[lname], Tgt.[lname]) = 0
    ) THEN UPDATE SET 
	Tgt.[account_id] = Src.[account_id],	
	Tgt.[fname] = Src.[fname],	
	Tgt.[lname] = Src.[lname] 
    ;

    
MERGE dbo.dim_how_did_you_hear AS Tgt
USING source.dim_how_did_you_hear AS Src
ON (Tgt.[how_did_you_hear] = Src.[how_did_you_hear]) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT([how_did_you_hear]) 
	VALUES([how_did_you_hear])
    ;

    
MERGE dbo.dim_how_did_you_hear_other AS Tgt
USING source.dim_how_did_you_hear_other AS Src
ON (Tgt.[how_did_you_hear_other] = Src.[how_did_you_hear_other]) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT([how_did_you_hear_other]) 
	VALUES([how_did_you_hear_other])
    ;

MERGE dbo.dim_order_status AS Tgt
USING source.dim_order_status AS Src
ON (Tgt.[state] = Src.[state] and Tgt.[status] = Src.[status]) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT([state], [status]) 
	VALUES([state], [status])
    ;


MERGE dbo.dim_shipping AS Tgt
USING source.dim_shipping AS Src
ON (Tgt.[shipping_description] = Src.[shipping_description] and Tgt.[shipping_method] = Src.[shipping_method]) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT([shipping_description], [shipping_method]) 
	VALUES([shipping_description], [shipping_method])
    ;


MERGE dbo.dim_subscriptions AS Tgt
USING source.dim_subscriptions AS Src
ON (Tgt.[subscription_id] = Src.[subscription_id]) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT([subscription_desc], [subscription_id]) 
	VALUES([subscription_desc], [subscription_id])
WHEN MATCHED AND (
	dbo.ufn_IsTextIdentical(Src.[subscription_desc], Tgt.[subscription_desc]) = 0
    ) THEN UPDATE SET 
	Tgt.[subscription_desc] = Src.[subscription_desc] 
    ;


MERGE dbo.fact_orders AS Tgt
USING source.fact_orders AS Src
ON (Tgt.[id] = Src.[id]) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT([created_at], [customer_account_id], [customer_group_id], [customer_is_guest], [dim_coupons_key], [dim_customers_key], [dim_how_did_you_hear_key], [dim_how_did_you_hear_other_key], [dim_order_status_key], [dim_shipping_key], [dim_subscriptions_key], [discount_amount], [giftcert_amount], [grand_total], [id], [order_currency_code], [order_currency_exchange_rate], [order_has_ecommerce], [order_has_subscription], [reference_number], [shipping_amount], [shipping_discount_amount], [shipping_hidden_tax_amount], [shipping_incl_tax], [shipping_invoiced], [shipping_refunded], [subtotal], [tax_amount], [total_due], [total_invoiced], [total_item_count], [total_paid], [total_qty_ordered], [total_refunded], [updated_at]) 
	VALUES([created_at], [customer_account_id], [customer_group_id], [customer_is_guest], [dim_coupons_key], [dim_customers_key], [dim_how_did_you_hear_key], [dim_how_did_you_hear_other_key], [dim_order_status_key], [dim_shipping_key], [dim_subscriptions_key], [discount_amount], [giftcert_amount], [grand_total], [id], [order_currency_code], [order_currency_exchange_rate], [order_has_ecommerce], [order_has_subscription], [reference_number], [shipping_amount], [shipping_discount_amount], [shipping_hidden_tax_amount], [shipping_incl_tax], [shipping_invoiced], [shipping_refunded], [subtotal], [tax_amount], [total_due], [total_invoiced], [total_item_count], [total_paid], [total_qty_ordered], [total_refunded], [updated_at])
WHEN MATCHED AND (
	dbo.ufn_IsValuesIdentical(Src.[created_at], Tgt.[created_at]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[customer_account_id], Tgt.[customer_account_id]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[customer_group_id], Tgt.[customer_group_id]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[customer_is_guest], Tgt.[customer_is_guest]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[dim_coupons_key], Tgt.[dim_coupons_key]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[dim_customers_key], Tgt.[dim_customers_key]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[dim_how_did_you_hear_key], Tgt.[dim_how_did_you_hear_key]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[dim_how_did_you_hear_other_key], Tgt.[dim_how_did_you_hear_other_key]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[dim_order_status_key], Tgt.[dim_order_status_key]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[dim_shipping_key], Tgt.[dim_shipping_key]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[dim_subscriptions_key], Tgt.[dim_subscriptions_key]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[discount_amount], Tgt.[discount_amount]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[giftcert_amount], Tgt.[giftcert_amount]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[grand_total], Tgt.[grand_total]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[order_currency_code], Tgt.[order_currency_code]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[order_currency_exchange_rate], Tgt.[order_currency_exchange_rate]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[order_has_ecommerce], Tgt.[order_has_ecommerce]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[order_has_subscription], Tgt.[order_has_subscription]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[reference_number], Tgt.[reference_number]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[shipping_amount], Tgt.[shipping_amount]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[shipping_discount_amount], Tgt.[shipping_discount_amount]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[shipping_hidden_tax_amount], Tgt.[shipping_hidden_tax_amount]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[shipping_incl_tax], Tgt.[shipping_incl_tax]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[shipping_invoiced], Tgt.[shipping_invoiced]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[shipping_refunded], Tgt.[shipping_refunded]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[subtotal], Tgt.[subtotal]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[tax_amount], Tgt.[tax_amount]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[total_due], Tgt.[total_due]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[total_invoiced], Tgt.[total_invoiced]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[total_item_count], Tgt.[total_item_count]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[total_paid], Tgt.[total_paid]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[total_qty_ordered], Tgt.[total_qty_ordered]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[total_refunded], Tgt.[total_refunded]) = 0 OR	
	dbo.ufn_IsValuesIdentical(Src.[updated_at], Tgt.[updated_at]) = 0
    ) THEN UPDATE SET 
	Tgt.[created_at] = Src.[created_at],	
	Tgt.[customer_account_id] = Src.[customer_account_id],	
	Tgt.[customer_group_id] = Src.[customer_group_id],	
	Tgt.[customer_is_guest] = Src.[customer_is_guest],	
	Tgt.[dim_coupons_key] = Src.[dim_coupons_key],	
	Tgt.[dim_customers_key] = Src.[dim_customers_key],	
	Tgt.[dim_how_did_you_hear_key] = Src.[dim_how_did_you_hear_key],	
	Tgt.[dim_how_did_you_hear_other_key] = Src.[dim_how_did_you_hear_other_key],	
	Tgt.[dim_order_status_key] = Src.[dim_order_status_key],	
	Tgt.[dim_shipping_key] = Src.[dim_shipping_key],	
	Tgt.[dim_subscriptions_key] = Src.[dim_subscriptions_key],	
	Tgt.[discount_amount] = Src.[discount_amount],	
	Tgt.[giftcert_amount] = Src.[giftcert_amount],	
	Tgt.[grand_total] = Src.[grand_total],	
	Tgt.[order_currency_code] = Src.[order_currency_code],	
	Tgt.[order_currency_exchange_rate] = Src.[order_currency_exchange_rate],	
	Tgt.[order_has_ecommerce] = Src.[order_has_ecommerce],	
	Tgt.[order_has_subscription] = Src.[order_has_subscription],	
	Tgt.[reference_number] = Src.[reference_number],	
	Tgt.[shipping_amount] = Src.[shipping_amount],	
	Tgt.[shipping_discount_amount] = Src.[shipping_discount_amount],	
	Tgt.[shipping_hidden_tax_amount] = Src.[shipping_hidden_tax_amount],	
	Tgt.[shipping_incl_tax] = Src.[shipping_incl_tax],	
	Tgt.[shipping_invoiced] = Src.[shipping_invoiced],	
	Tgt.[shipping_refunded] = Src.[shipping_refunded],	
	Tgt.[subtotal] = Src.[subtotal],	
	Tgt.[tax_amount] = Src.[tax_amount],	
	Tgt.[total_due] = Src.[total_due],	
	Tgt.[total_invoiced] = Src.[total_invoiced],	
	Tgt.[total_item_count] = Src.[total_item_count],	
	Tgt.[total_paid] = Src.[total_paid],	
	Tgt.[total_qty_ordered] = Src.[total_qty_ordered],	
	Tgt.[total_refunded] = Src.[total_refunded],	
	Tgt.[updated_at] = Src.[updated_at] 
    ;


