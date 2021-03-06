USE [CatchCo]
GO
/****** Object:  StoredProcedure [dbo].[usp_DropAllForeignKeyConstraints]    Script Date: 5/14/2018 2:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE proc [dbo].[usp_DropAllForeignKeyConstraints](
	@verbose bit = 0
	)
as



declare @tblSqlCode dbo.ExecSqlStatementsTableType
DECLARE @GuidExecutionBatch uniqueidentifier

insert into @tblSqlCode(SqlCode)
SELECT 'ALTER TABLE [' + TABLE_SCHEMA + '].[' + TABLE_NAME + '] DROP CONSTRAINT [' + CONSTRAINT_NAME +']'
FROM information_schema.table_constraints
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY' 
	and (Table_Name like 'fact%' OR Table_Name like 'map%' OR Table_Name like 'matrix%')


exec dbo.usp_ExecSqlStatements 
    @TableSqlCode = @tblSqlCode
    ,@verbose = @verbose
    ,@GuidExecutionBatch = @GuidExecutionBatch output


GO
