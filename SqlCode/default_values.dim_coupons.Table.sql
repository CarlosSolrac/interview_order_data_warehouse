USE [CatchCo]
GO
/****** Object:  Table [default_values].[dim_coupons]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [default_values].[dim_coupons](
	[dim_coupons_key] [int] IDENTITY(1,1) NOT NULL,
	[coupon_code] [nvarchar](128) NOT NULL,
	[coupon_rule_name] [nvarchar](128) NOT NULL
) ON [PRIMARY]
GO
