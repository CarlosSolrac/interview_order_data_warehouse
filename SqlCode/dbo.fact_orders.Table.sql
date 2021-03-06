USE [CatchCo]
GO
/****** Object:  Table [dbo].[fact_orders]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_orders](
	[fact_orders_key] [int] IDENTITY(1,1) NOT NULL,
	[dim_customers_key] [int] NOT NULL,
	[dim_order_status_key] [int] NOT NULL,
	[dim_subscriptions_key] [int] NOT NULL,
	[dim_coupons_key] [int] NOT NULL,
	[dim_how_did_you_hear_key] [int] NOT NULL,
	[dim_how_did_you_hear_other_key] [int] NOT NULL,
	[dim_shipping_key] [int] NOT NULL,
	[id] [bigint] NOT NULL,
	[reference_number] [bigint] NOT NULL,
	[grand_total] [decimal](28, 6) NULL,
	[subtotal] [decimal](28, 6) NULL,
	[tax_amount] [decimal](28, 6) NULL,
	[total_due] [decimal](28, 6) NULL,
	[total_invoiced] [decimal](28, 6) NULL,
	[total_item_count] [int] NULL,
	[total_paid] [decimal](28, 6) NULL,
	[total_qty_ordered] [int] NULL,
	[total_refunded] [decimal](28, 6) NULL,
	[discount_amount] [decimal](28, 6) NULL,
	[order_currency_code] [char](3) NULL,
	[order_currency_exchange_rate] [decimal](28, 6) NOT NULL,
	[giftcert_amount] [decimal](28, 6) NULL,
	[customer_group_id] [int] NOT NULL,
	[customer_account_id] [int] NULL,
	[customer_is_guest] [bit] NULL,
	[shipping_amount] [decimal](28, 6) NULL,
	[shipping_discount_amount] [decimal](28, 6) NULL,
	[shipping_hidden_tax_amount] [decimal](28, 6) NULL,
	[shipping_incl_tax] [decimal](28, 6) NULL,
	[shipping_invoiced] [decimal](28, 6) NULL,
	[shipping_refunded] [decimal](28, 6) NULL,
	[created_at] [datetime2](7) NULL,
	[updated_at] [datetime2](7) NULL,
	[order_has_subscription] [bit] NULL,
	[order_has_ecommerce] [bit] NULL,
 CONSTRAINT [PK_fact_orders] PRIMARY KEY CLUSTERED 
(
	[fact_orders_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[fact_orders]  WITH CHECK ADD  CONSTRAINT [FK_fact_orders_dim_coupons_0x876c293e3f1cb86ffe792d0ddffefc9c] FOREIGN KEY([dim_coupons_key])
REFERENCES [dbo].[dim_coupons] ([dim_coupons_key])
GO
ALTER TABLE [dbo].[fact_orders] CHECK CONSTRAINT [FK_fact_orders_dim_coupons_0x876c293e3f1cb86ffe792d0ddffefc9c]
GO
ALTER TABLE [dbo].[fact_orders]  WITH CHECK ADD  CONSTRAINT [FK_fact_orders_dim_customers_0x8f174bc5ff5ce14339489cf8dc7f7be5] FOREIGN KEY([dim_customers_key])
REFERENCES [dbo].[dim_customers] ([dim_customers_key])
GO
ALTER TABLE [dbo].[fact_orders] CHECK CONSTRAINT [FK_fact_orders_dim_customers_0x8f174bc5ff5ce14339489cf8dc7f7be5]
GO
ALTER TABLE [dbo].[fact_orders]  WITH CHECK ADD  CONSTRAINT [FK_fact_orders_dim_how_did_you_hear_0x97b14e9ca41576a953def2997f123361] FOREIGN KEY([dim_how_did_you_hear_key])
REFERENCES [dbo].[dim_how_did_you_hear] ([dim_how_did_you_hear_key])
GO
ALTER TABLE [dbo].[fact_orders] CHECK CONSTRAINT [FK_fact_orders_dim_how_did_you_hear_0x97b14e9ca41576a953def2997f123361]
GO
ALTER TABLE [dbo].[fact_orders]  WITH CHECK ADD  CONSTRAINT [FK_fact_orders_dim_how_did_you_hear_other_0x8bfaa4bb9af976916e64700d01844443] FOREIGN KEY([dim_how_did_you_hear_other_key])
REFERENCES [dbo].[dim_how_did_you_hear_other] ([dim_how_did_you_hear_other_key])
GO
ALTER TABLE [dbo].[fact_orders] CHECK CONSTRAINT [FK_fact_orders_dim_how_did_you_hear_other_0x8bfaa4bb9af976916e64700d01844443]
GO
ALTER TABLE [dbo].[fact_orders]  WITH CHECK ADD  CONSTRAINT [FK_fact_orders_dim_order_status_0x79a6dd72358f22f76042f58b6b2c1043] FOREIGN KEY([dim_order_status_key])
REFERENCES [dbo].[dim_order_status] ([dim_order_status_key])
GO
ALTER TABLE [dbo].[fact_orders] CHECK CONSTRAINT [FK_fact_orders_dim_order_status_0x79a6dd72358f22f76042f58b6b2c1043]
GO
ALTER TABLE [dbo].[fact_orders]  WITH CHECK ADD  CONSTRAINT [FK_fact_orders_dim_shipping_0x684b2225161db197adf3b8df36e67b33] FOREIGN KEY([dim_shipping_key])
REFERENCES [dbo].[dim_shipping] ([dim_shipping_key])
GO
ALTER TABLE [dbo].[fact_orders] CHECK CONSTRAINT [FK_fact_orders_dim_shipping_0x684b2225161db197adf3b8df36e67b33]
GO
ALTER TABLE [dbo].[fact_orders]  WITH CHECK ADD  CONSTRAINT [FK_fact_orders_dim_subscriptions_0xee3b0c157a10f0db89f085ab27d0f9de] FOREIGN KEY([dim_subscriptions_key])
REFERENCES [dbo].[dim_subscriptions] ([dim_subscriptions_key])
GO
ALTER TABLE [dbo].[fact_orders] CHECK CONSTRAINT [FK_fact_orders_dim_subscriptions_0xee3b0c157a10f0db89f085ab27d0f9de]
GO
