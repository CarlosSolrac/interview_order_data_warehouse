USE [CatchCo]
GO
/****** Object:  StoredProcedure [dbo].[usp_DropFK_DropIdx_TruncateAll]    Script Date: 5/14/2018 2:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE proc [dbo].[usp_DropFK_DropIdx_TruncateAll]
as



EXEC dbo.usp_DropAllForeignKeyConstraints

EXEC dbo.usp_TruncateAll

--EXEC dbo.usp_DropAllIndexes


GO
