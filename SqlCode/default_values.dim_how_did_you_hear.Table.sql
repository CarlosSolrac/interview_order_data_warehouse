USE [CatchCo]
GO
/****** Object:  Table [default_values].[dim_how_did_you_hear]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [default_values].[dim_how_did_you_hear](
	[dim_how_did_you_hear_key] [int] IDENTITY(1,1) NOT NULL,
	[how_did_you_hear] [nvarchar](256) NOT NULL
) ON [PRIMARY]
GO
