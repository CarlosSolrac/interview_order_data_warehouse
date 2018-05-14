






CREATE proc [dbo].[usp_DropFK_DropIdx_TruncateAll]
as



EXEC dbo.usp_DropAllForeignKeyConstraints

EXEC dbo.usp_TruncateAll

--EXEC dbo.usp_DropAllIndexes


