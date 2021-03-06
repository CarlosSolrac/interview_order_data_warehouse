USE [CatchCo]
GO
/****** Object:  Table [dbo].[dim_coupons]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_coupons](
	[dim_coupons_key] [int] IDENTITY(1,1) NOT NULL,
	[coupon_code] [nvarchar](128) NOT NULL,
	[coupon_rule_name] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dim_coupons] PRIMARY KEY CLUSTERED 
(
	[dim_coupons_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_dim_coupons_1]    Script Date: 5/14/2018 2:01:02 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_coupons_1] ON [dbo].[dim_coupons]
(
	[coupon_code] ASC,
	[coupon_rule_name] ASC
)
WHERE ([dim_coupons_key]>(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
