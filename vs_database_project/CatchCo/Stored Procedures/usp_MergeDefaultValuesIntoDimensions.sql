

/*


EXEC dbo.[usp_MergeDefaultValuesIntoDimensions] @verbose = 1


EXEC dbo.[usp_MergeDefaultValuesIntoDimensions] @verbose = 0


*/
CREATE proc [dbo].usp_MergeDefaultValuesIntoDimensions(
	@verbose BIT = 0
	,@ExecSQL BIT = 1
	)
as



SET NOCOUNT on



-- ************************************************************************************************
-- ************************************************************************************************
-- Use this to execute a series of SQL statements
-- ************************************************************************************************
-- ************************************************************************************************
declare @TableSqlCode ExecSqlStatementsTableType
DECLARE @GuidExecutionBatch uniqueidentifier


-- ************************************************************************************************
-- ************************************************************************************************
-- Get the list of dimensions. Schema = 'dbo'
-- ************************************************************************************************
-- ************************************************************************************************
if object_id('tempdb..#src') is not null
	drop table #src


-- ************************************************************************************************
select distinct
	t.TABLE_SCHEMA
	,t.TABLE_NAME
into #src
from
	INFORMATION_SCHEMA.tables t with(nolock)
WHERE
	t.TABLE_TYPE = 'base table'
	AND t.TABLE_NAME LIKE 'dim_%'
    and t.TABLE_SCHEMA = 'dbo'



-- ************************************************************************************************
IF @verbose=1
BEGIN
	SELECT
		'#src' AS tablename
		,*
	FROM
		#src
end

	
-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
DELETE FROM @TableSqlCode

-- ************************************************************************************************
insert into @TableSqlCode(SqlCode)
select distinct
	'exec [dbo].[usp_MergeDefaultValues] ''' + #src.TABLE_SCHEMA + ''', ''' + #src.TABLE_NAME + '''' as SqlCode
from
	#src


-- ************************************************************************************************
IF @verbose=1
BEGIN
	SELECT
		'@TableSqlCode' AS tablename
		,*
	FROM
		@TableSqlCode
end


-- ************************************************************************************************
exec dbo.usp_ExecSqlStatements 
    @TableSqlCode = @TableSqlCode
    ,@verbose = @verbose
    ,@GuidExecutionBatch = @GuidExecutionBatch output
    ,@StopOnError=1
    ,@RaiseError=1


-- ************************************************************************************************
IF @verbose=1
BEGIN
    SELECT 
	     r.RowId
	    ,r.SqlCode
	    ,r.ExecuteStartTime 
	    ,r.TotalExecutionTimeSeconds 
	    ,r.ErrorExecuting
	    ,r.ErrorMessage 
	    ,r.ErrorSeverity 
	    ,r.ErrorState
        ,r.*
    FROM 
	    dbo.tblExecSqlStatements_Results_TableType_V01 r
    where
        r.GuidExecutionBatch = @GuidExecutionBatch
        and r.ErrorExecuting = 1
end

IF EXISTS(SELECT TOP 1 1 FROM dbo.tblExecSqlStatements_Results_TableType_V01 r WHERE r.GuidExecutionBatch = @GuidExecutionBatch and r.ErrorExecuting = 1)
BEGIN
    --RAISERROR('Error executing code', 18, 0)
	print 'Error detected'
END


	















