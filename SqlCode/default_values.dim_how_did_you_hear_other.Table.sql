USE [CatchCo]
GO
/****** Object:  Table [default_values].[dim_how_did_you_hear_other]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [default_values].[dim_how_did_you_hear_other](
	[dim_how_did_you_hear_other_key] [int] IDENTITY(1,1) NOT NULL,
	[how_did_you_hear_other] [nvarchar](256) NOT NULL
) ON [PRIMARY]
GO
