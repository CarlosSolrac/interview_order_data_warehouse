USE [CatchCo]
GO
/****** Object:  Table [default_values].[dim_order_status]    Script Date: 5/14/2018 2:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [default_values].[dim_order_status](
	[dim_order_status_key] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](128) NOT NULL,
	[state] [nvarchar](128) NOT NULL
) ON [PRIMARY]
GO
