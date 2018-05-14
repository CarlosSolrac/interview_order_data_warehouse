



/*


exec dbo.usp_DropAllForeignKeyConstraints


exec dbo.usp_AutomaticallyCreateForeignKeyRelationships_All


exec dbo.usp_AutomaticallyCreateForeignKeyRelationships @verbose = 1, @ExecSql = 1


exec dbo.usp_AutomaticallyCreateForeignKeyRelationships @verbose = 1, @ExecSql = 0


exec dbo.usp_AutomaticallyCreateForeignKeyRelationships @verbose = 0, @ExecSql = 1


exec dbo.usp_AutomaticallyCreateForeignKeyRelationships @verbose = 0, @ExecSql = 0


*/
CREATE proc dbo.usp_AutomaticallyCreateForeignKeyRelationships(
	@verbose bit = 0
	,@ExecSql bit = 1
	)
as


/*

select * from #cols order by 3 desc

*/

--DECLARE @verbose bit = 1
--	,@ExecSql bit = 1


DECLARE @fkdel varchar(4000)

--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
if object_id('tempdb..#cols') is not null
	drop table #cols


--*************************************************************************************************
--*************************************************************************************************
select
	c.TABLE_CATALOG
	,c.TABLE_SCHEMA
	,c.TABLE_NAME
	,c.COLUMN_NAME
	,case
		when t.TABLE_NAME like 'dim%' then cast(1 as bit)
		else cast(0 as bit)
	end as IsDimension
	,case
		when t.TABLE_NAME like 'fact%' then cast(1 as bit)
		else cast(0 as bit)
	end as IsFact
	,c.COLUMN_NAME as DimKeyName
into #cols
from
	INFORMATION_SCHEMA.TABLES t
	join INFORMATION_SCHEMA.COLUMNS c
		on t.TABLE_CATALOG = c.TABLE_CATALOG
			and t.TABLE_SCHEMA = c.TABLE_SCHEMA
			and t.TABLE_NAME = c.TABLE_NAME
	left join INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
		on t.TABLE_CATALOG = tc.TABLE_CATALOG
			and t.TABLE_SCHEMA = tc.TABLE_SCHEMA
			and t.TABLE_NAME = tc.TABLE_NAME
			and tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
	left join INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
		on tc.CONSTRAINT_CATALOG = ccu.CONSTRAINT_CATALOG
			and tc.CONSTRAINT_SCHEMA = ccu.CONSTRAINT_SCHEMA
			and tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
			and c.COLUMN_NAME = ccu.COLUMN_NAME
where
	t.TABLE_NAME not in ('sysdiagrams', 'TallyLarge', 'Tally')
	AND t.TABLE_SCHEMA = 'dbo'
	and t.TABLE_TYPE = 'base table'
	and (
		(t.TABLE_NAME like 'dim%' and ccu.COLUMN_NAME is not null)
		or (t.TABLE_NAME like 'fact%')
	)


--*************************************************************************************************
--*************************************************************************************************
SELECT * FROM #cols WHERE @verbose=1 ORDER BY 3


--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
SELECT
    q.*
    ,IIF(rc.CONSTRAINT_NAME IS NULL, 0, 1) AS ForeignKeyExists
FROM
    (
        SELECT
             fact.TABLE_SCHEMA as fact_TABLE_SCHEMA
            ,fact.TABLE_NAME   as fact_TABLE_NAME  
            ,fact.COLUMN_NAME  as fact_COLUMN_NAME  
            ,dim.TABLE_SCHEMA  as dim_TABLE_SCHEMA 
            ,dim.TABLE_NAME    as dim_TABLE_NAME   
            ,dim.COLUMN_NAME   as dim_COLUMN_NAME  
            ,dbo.ufn_CreateForeignKeyName(fact.TABLE_SCHEMA, fact.TABLE_NAME, fact.COLUMN_NAME, dim.TABLE_SCHEMA, dim.TABLE_NAME, dim.COLUMN_NAME) AS FKeyName
        FROM
	        #cols fact
	        join #cols dim
		        on dim.COLUMN_NAME = fact.DimKeyName
        where
	        fact.IsFact = 1
	        and dim.IsDimension = 1
            --AND @verbose = 1
    ) q
    LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
        ON rc.CONSTRAINT_NAME = q.FKeyName
ORDER BY 1,2,3,4,5,6





--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
declare @tblSqlCode dbo.ExecSqlStatementsTableType
DECLARE @GuidExecutionBatch uniqueidentifier

insert into @tblSqlCode(SqlCode)
select 
	replace(replace(replace(replace(replace(replace(replace('IF NOT EXISTS(SELECT TOP 1 1 FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE WHERE CONSTRAINT_NAME = ''<<hash>>'')
BEGIN
	ALTER TABLE [<<fschema>>].[<<ftable>>] ADD CONSTRAINT
		<<hash>> FOREIGN KEY
		(
			<<fcolumn>>
		) REFERENCES [<<dschema>>].[<<dtable>>]
		(
			<<dcolumn>>
		) ON UPDATE  NO ACTION 
			ON DELETE  NO ACTION
end'
		, '<<fschema>>', fact.TABLE_SCHEMA), '<<ftable>>', fact.TABLE_NAME)
		, '<<dschema>>', dim.TABLE_SCHEMA), '<<dtable>>', dim.TABLE_NAME)
		,'<<fcolumn>>', fact.COLUMN_NAME)
		,'<<dcolumn>>', dim.COLUMN_NAME)
		,'<<hash>>', dbo.ufn_CreateForeignKeyName(fact.TABLE_SCHEMA, fact.TABLE_NAME, fact.COLUMN_NAME, dim.TABLE_SCHEMA, dim.TABLE_NAME, dim.COLUMN_NAME)
		)
from 
	#cols fact
	join #cols dim
		on dim.COLUMN_NAME = fact.DimKeyName
where
	fact.IsFact = 1
	and dim.IsDimension = 1


--*************************************************************************************************
--*************************************************************************************************
SELECT * FROM @tblSqlCode WHERE @verbose = 1



--*************************************************************************************************
--*************************************************************************************************
EXEC dbo.usp_ExecSqlStatements @TableSqlCode=@tblSqlCode
	,@verbose = @verbose
	,@ExecSql = @ExecSql
	,@UseTransactions = 0
	,@StopOnError = 0
    ,@GuidExecutionBatch = @GuidExecutionBatch output



--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
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


--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
--*************************************************************************************************
IF EXISTS(SELECT TOP 1 1 FROM dbo.tblExecSqlStatements_Results_TableType_V01 r WHERE r.GuidExecutionBatch = @GuidExecutionBatch and r.ErrorExecuting = 1)
BEGIN
    DECLARE @ErrorMsg NVARCHAR(4000) = CONCAT('Error executing code: select * FROM dbo.dbo.tblExecSqlStatements_Results_TableType_V01 r where r.GuidExecutionBatch = ''', @GuidExecutionBatch, ''' and r.ErrorExecuting = 1')

    RAISERROR(@ErrorMsg, 18, 0)

	--print 'Error detected'
end








