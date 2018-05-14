USE [CatchCo]
GO
/****** Object:  Table [dbo].[staging_customers_text]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging_customers_text](
	[account_id] [int] NULL,
	[email] [nvarchar](320) NULL,
	[fname] [nvarchar](128) NULL,
	[lname] [nvarchar](128) NULL
) ON [PRIMARY]
GO
