USE [CatchCo]
GO
/****** Object:  Table [dbo].[staging_customers]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging_customers](
	[account_id] [int] NULL,
	[email] [nvarchar](320) NULL,
	[fname] [nvarchar](128) NULL,
	[lname] [nvarchar](128) NULL
) ON [PRIMARY]
GO
