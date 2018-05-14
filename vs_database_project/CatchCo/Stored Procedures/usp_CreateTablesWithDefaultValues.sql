
/*


EXEC dbo.[usp_CreateTablesWithDefaultValues] @verbose = 1


EXEC dbo.[usp_CreateTablesWithDefaultValues] @verbose = 0


*/
CREATE proc [dbo].[usp_CreateTablesWithDefaultValues](
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
	c.TABLE_SCHEMA
	,c.TABLE_NAME
	,c.ORDINAL_POSITION
	,c.COLUMN_NAME
	,c.IS_NULLABLE
	,c.DATA_TYPE
	,c.CHARACTER_MAXIMUM_LENGTH
	,c.NUMERIC_PRECISION
	,c.NUMERIC_SCALE
	,c.DATETIME_PRECISION
into #src
from
	INFORMATION_SCHEMA.tables t with(nolock)
	JOIN INFORMATION_SCHEMA.COLUMNS c with(nolock)
		ON t.TABLE_SCHEMA = c.TABLE_SCHEMA
			AND t.TABLE_NAME = c.TABLE_NAME
WHERE
	t.TABLE_TYPE = 'base table'
    and t.TABLE_SCHEMA = 'dbo'
	AND t.TABLE_NAME LIKE 'dim_%'
	and COLUMNPROPERTY(OBJECT_ID('[' + c.table_schema + '].[' + c.table_name + ']'), c.COLUMN_NAME, 'IsComputed') = 0



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
-- Get the list of dimensions. Schema = 'default_values'
-- ************************************************************************************************
-- ************************************************************************************************
if object_id('tempdb..#dst') is not null
	drop table #dst


-- ************************************************************************************************
select distinct
	c.TABLE_SCHEMA
	,c.TABLE_NAME
	--,c.ORDINAL_POSITION
	--,c.COLUMN_NAME
	--,c.IS_NULLABLE
	--,c.DATA_TYPE
	--,c.CHARACTER_MAXIMUM_LENGTH
	--,c.NUMERIC_PRECISION
	--,c.NUMERIC_SCALE
	--,c.DATETIME_PRECISION
into #dst
from
	INFORMATION_SCHEMA.tables t with(nolock)
	JOIN INFORMATION_SCHEMA.COLUMNS c with(nolock)
		ON t.TABLE_SCHEMA = c.TABLE_SCHEMA
			AND t.TABLE_NAME = c.TABLE_NAME
WHERE
	t.TABLE_TYPE = 'base table'
	AND t.TABLE_SCHEMA = 'default_values'
	AND t.TABLE_NAME LIKE 'dim%' 
	and COLUMNPROPERTY(OBJECT_ID('[' + c.table_schema + '].[' + c.table_name + ']'), c.COLUMN_NAME, 'IsComputed') = 0



-- ************************************************************************************************
IF @verbose=1
BEGIN
	SELECT
		'#dst' AS tablename
		,*
	FROM
		#dst
end



	
-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
DELETE FROM @TableSqlCode

-- ************************************************************************************************
insert into @TableSqlCode(SqlCode)
select distinct
	'drop table [' + #dst.TABLE_SCHEMA + '].[' + #dst.TABLE_NAME + ']' as SqlCode
from
	#dst


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
-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
delete from @TableSqlCode

-- ************************************************************************************************
insert into @TableSqlCode(SqlCode)
select distinct
	isnull('select ' + dbo.fn_TableColumnList(q.table_schema, q.TABLE_NAME, NULL, 1, 0, 1, 1) 
        + ' into default_values.[' + q.TABLE_NAME + '] from [' + q.table_schema + '].[' + q.TABLE_NAME 
        + '] where 1=0',
        concat('fn_TableColumnList returned null:', q.table_schema, '.', q.TABLE_NAME))
from
	(
		select distinct
			TABLE_NAME
			,table_schema
		from
			#src
	) q


-- ************************************************************************************************
IF @verbose=1
BEGIN
	SELECT
		'@TableSqlCode - select into' AS tablename
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
-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
delete from @TableSqlCode


-- ************************************************************************************************
if object_id('tempdb..#InsertDefaultValues') is not null
	drop table #InsertDefaultValues

create table #InsertDefaultValues 
(
	TABLE_NAME sysname
	,SQLCODE NVARCHAR(max)
)

insert into #InsertDefaultValues
exec dbo.usp_SqlCodeToInsertDefaultValuesIntoTables


-- ************************************************************************************************
IF @verbose=1
BEGIN
	SELECT
		'#InsertDefaultValues' AS tablename
		,*
	FROM
		#InsertDefaultValues
    ORDER BY 2
end


-- ************************************************************************************************
insert into @TableSqlCode(SqlCode)
SELECT
	d.SQLCODE
FROM
	#InsertDefaultValues d
	JOIN (
		SELECT DISTINCT
			TABLE_NAME
		FROM
			#src
	) q      
        ON d.TABLE_NAME = q.TABLE_NAME


-- ************************************************************************************************
IF @verbose=1
BEGIN
	SELECT
		'@TableSqlCode' AS tablename
		,*
	FROM
		@TableSqlCode
END


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


	















