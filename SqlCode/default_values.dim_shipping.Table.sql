USE [CatchCo]
GO
/****** Object:  Table [default_values].[dim_shipping]    Script Date: 5/14/2018 2:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [default_values].[dim_shipping](
	[dim_shipping_key] [int] IDENTITY(1,1) NOT NULL,
	[shipping_description] [nvarchar](128) NOT NULL,
	[shipping_method] [nvarchar](128) NOT NULL
) ON [PRIMARY]
GO
