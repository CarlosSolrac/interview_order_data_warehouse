USE [CatchCo]
GO
/****** Object:  Table [dbo].[dim_subscriptions]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_subscriptions](
	[dim_subscriptions_key] [int] IDENTITY(1,1) NOT NULL,
	[subscription_id] [int] NOT NULL,
	[subscription_desc] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dim_subscriptions] PRIMARY KEY CLUSTERED 
(
	[dim_subscriptions_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_dim_subscriptions]    Script Date: 5/14/2018 2:01:02 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_subscriptions] ON [dbo].[dim_subscriptions]
(
	[subscription_id] ASC
)
WHERE ([dim_subscriptions_key]>(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
