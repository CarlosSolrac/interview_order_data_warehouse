

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


