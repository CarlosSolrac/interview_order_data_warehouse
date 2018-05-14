USE [CatchCo]
GO
/****** Object:  Table [default_values].[dim_customers]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [default_values].[dim_customers](
	[dim_customers_key] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NOT NULL,
	[email] [nvarchar](320) NOT NULL,
	[fname] [nvarchar](128) NOT NULL,
	[lname] [nvarchar](128) NOT NULL
) ON [PRIMARY]
GO
