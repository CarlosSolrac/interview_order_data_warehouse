USE [CatchCo]
GO
/****** Object:  Table [default_values].[dim_subscriptions]    Script Date: 5/14/2018 2:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [default_values].[dim_subscriptions](
	[dim_subscriptions_key] [int] IDENTITY(1,1) NOT NULL,
	[subscription_id] [int] NOT NULL,
	[subscription_desc] [nvarchar](128) NOT NULL
) ON [PRIMARY]
GO
