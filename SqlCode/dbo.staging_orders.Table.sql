USE [CatchCo]
GO
/****** Object:  Table [dbo].[staging_orders]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging_orders](
	[id] [int] NULL,
	[reference_number] [int] NULL,
	[status] [nvarchar](max) NULL,
	[subscription_id] [int] NULL,
	[state] [nvarchar](max) NULL,
	[grand_total] [decimal](28, 6) NULL,
	[subtotal] [decimal](28, 6) NULL,
	[tax_amount] [decimal](28, 6) NULL,
	[total_due] [decimal](28, 6) NULL,
	[total_invoiced] [decimal](28, 6) NULL,
	[total_item_count] [decimal](28, 6) NULL,
	[total_paid] [decimal](28, 6) NULL,
	[total_qty_ordered] [int] NULL,
	[total_refunded] [decimal](28, 6) NULL,
	[discount_amount] [decimal](28, 6) NULL,
	[order_currency_code] [char](3) NULL,
	[giftcert_amount] [decimal](28, 6) NULL,
	[coupon_code] [nvarchar](max) NULL,
	[coupon_rule_name] [nvarchar](max) NULL,
	[customer_group_id] [int] NULL,
	[customer_account_id] [int] NULL,
	[customer_is_guest] [bit] NULL,
	[shipping_amount] [decimal](28, 6) NULL,
	[shipping_description] [nvarchar](max) NULL,
	[shipping_discount_amount] [decimal](28, 6) NULL,
	[shipping_hidden_tax_amount] [decimal](28, 6) NULL,
	[shipping_incl_tax] [decimal](28, 6) NULL,
	[shipping_invoiced] [decimal](28, 6) NULL,
	[shipping_method] [nvarchar](max) NULL,
	[shipping_refunded] [decimal](28, 6) NULL,
	[how_did_you_hear] [nvarchar](max) NULL,
	[how_did_you_hear_other] [nvarchar](max) NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
	[order_has_subscription] [bit] NULL,
	[order_has_ecommerce] [bit] NULL,
	[customer_email] [nvarchar](320) NULL,
	[customer_fname] [nvarchar](128) NULL,
	[customer_lname] [nvarchar](128) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
