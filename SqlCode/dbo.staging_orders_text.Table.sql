USE [CatchCo]
GO
/****** Object:  Table [dbo].[staging_orders_text]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging_orders_text](
	[id] [nvarchar](max) NULL,
	[reference_number] [nvarchar](max) NULL,
	[status] [nvarchar](max) NULL,
	[subscription_id] [nvarchar](max) NULL,
	[state] [nvarchar](max) NULL,
	[grand_total] [nvarchar](max) NULL,
	[subtotal] [nvarchar](max) NULL,
	[tax_amount] [nvarchar](max) NULL,
	[total_due] [nvarchar](max) NULL,
	[total_invoiced] [nvarchar](max) NULL,
	[total_item_count] [nvarchar](max) NULL,
	[total_paid] [nvarchar](max) NULL,
	[total_qty_ordered] [nvarchar](max) NULL,
	[total_refunded] [nvarchar](max) NULL,
	[discount_amount] [nvarchar](max) NULL,
	[order_currency_code] [nvarchar](50) NULL,
	[giftcert_amount] [nvarchar](max) NULL,
	[coupon_code] [nvarchar](max) NULL,
	[coupon_rule_name] [nvarchar](max) NULL,
	[customer_group_id] [nvarchar](max) NULL,
	[customer_account_id] [nvarchar](max) NULL,
	[customer_is_guest] [nvarchar](max) NULL,
	[shipping_amount] [nvarchar](max) NULL,
	[shipping_description] [nvarchar](max) NULL,
	[shipping_discount_amount] [nvarchar](max) NULL,
	[shipping_hidden_tax_amount] [nvarchar](max) NULL,
	[shipping_incl_tax] [nvarchar](max) NULL,
	[shipping_invoiced] [nvarchar](max) NULL,
	[shipping_method] [nvarchar](max) NULL,
	[shipping_refunded] [nvarchar](max) NULL,
	[how_did_you_hear] [nvarchar](max) NULL,
	[how_did_you_hear_other] [nvarchar](max) NULL,
	[created_at] [nvarchar](max) NULL,
	[updated_at] [nvarchar](max) NULL,
	[order_has_subscription] [nvarchar](max) NULL,
	[order_has_ecommerce] [nvarchar](max) NULL,
	[customer_email] [nvarchar](320) NULL,
	[customer_fname] [nvarchar](128) NULL,
	[customer_lname] [nvarchar](128) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
