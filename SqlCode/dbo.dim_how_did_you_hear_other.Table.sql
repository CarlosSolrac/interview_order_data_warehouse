USE [CatchCo]
GO
/****** Object:  Table [dbo].[dim_how_did_you_hear_other]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_how_did_you_hear_other](
	[dim_how_did_you_hear_other_key] [int] IDENTITY(1,1) NOT NULL,
	[how_did_you_hear_other] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dim_how_did_you_hear_other] PRIMARY KEY CLUSTERED 
(
	[dim_how_did_you_hear_other_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_dim_how_did_you_hear_other]    Script Date: 5/14/2018 2:01:02 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_how_did_you_hear_other] ON [dbo].[dim_how_did_you_hear_other]
(
	[how_did_you_hear_other] ASC
)
WHERE ([dim_how_did_you_hear_other_key]>(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
