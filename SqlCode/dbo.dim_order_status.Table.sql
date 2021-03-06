USE [CatchCo]
GO
/****** Object:  Table [dbo].[dim_order_status]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_order_status](
	[dim_order_status_key] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](128) NOT NULL,
	[state] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dim_order_status] PRIMARY KEY CLUSTERED 
(
	[dim_order_status_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_dim_order_status]    Script Date: 5/14/2018 2:01:02 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_order_status] ON [dbo].[dim_order_status]
(
	[state] ASC,
	[status] ASC
)
WHERE ([dim_order_status_key]>(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
