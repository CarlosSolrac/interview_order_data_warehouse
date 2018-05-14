







CREATE proc [dbo].[usp_DropAllIndexes](
	@verbose bit = 0
	)
as



declare @tblSqlCode dbo.ExecSqlStatementsTableType
DECLARE @GuidExecutionBatch uniqueidentifier



insert into @tblSqlCode(SqlCode)
SELECT
	CONCAT('DROP INDEX [', INDEX_NAME, '] on [', TABLE_SCHEMA, '].[', TABLE_NAME, ']')
FROM
	(
		SELECT distinct
			s.name AS TABLE_SCHEMA
		   ,t.name AS TABLE_NAME
		   ,ind.name AS INDEX_NAME
		FROM
			sys.indexes ind

			INNER JOIN sys.tables t
				ON ind.object_id = t.object_id

			JOIN sys.schemas s
				ON t.schema_id = s.schema_id
		WHERE
            ind.name IS NOT NULL
            AND ind.is_primary_key = 0 
			 --AND ind.is_unique = 0 
			 --AND ind.is_unique_constraint = 0 
			 --AND t.is_ms_shipped = 0 
			AND t.name NOT IN ('sysdiagrams')
			--AND s.name NOT IN ('dbo')
	) q


exec dbo.usp_ExecSqlStatements 
    @TableSqlCode = @tblSqlCode
    ,@verbose = @verbose
    ,@GuidExecutionBatch = @GuidExecutionBatch output


