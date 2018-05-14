USE [CatchCo]
GO
/****** Object:  StoredProcedure [dbo].[usp_Main]    Script Date: 5/14/2018 2:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_Main]
as

/*
exec dbo.usp_DropFK_DropIdx_TruncateAll
exec dbo.usp_ShrinkDatabase
exec dbo.usp_AutomaticallyCreateForeignKeyRelationships
exec dbo.usp_CreateTablesWithDefaultValues
EXEC dbo.usp_MergeDefaultValuesIntoDimensions
*/


exec dbo.usp_CleanData
exec dbo.usp_Merge_Data


GO
