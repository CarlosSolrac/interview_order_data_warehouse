




/*


if object_id('tempdb..#SqlCode') is not null
	drop table #SqlCode

create table #SqlCode 
(
	TABLE_NAME sysname
	,SQLCODE NVARCHAR(max)
)


insert into #SqlCode
exec dbo.usp_SqlCodeToInsertDefaultValuesIntoTables

declare @tmp nvarchar(max)
select @tmp = SQLCODE from #SqlCode s
where s.TABLE_NAME = 'dim_coupons'

print @tmp

*/

CREATE proc [dbo].[usp_SqlCodeToInsertDefaultValuesIntoTables]
as

-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
if object_id('tempdb..#DefText') is not null
	drop table #DefText

if object_id('tempdb..#DefValue') is not null
	drop table #DefValue

if object_id('tempdb..#DataTypes') is not null
	drop table #DataTypes

if object_id('tempdb..#InsertDeclare') is not null
	drop table #InsertDeclare

if object_id('tempdb..#final') is not null
	drop table #final

if object_id('tempdb..#MinMax') is not null
	drop table #MinMax



-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
select -1 as PriKey,'[Not Specified]' as TextVal into #DefText union all
select -2 as PriKey,'[Missing Data]' as TextVal union all
select -3 as PriKey,'[Detail Data Unavailable]' as TextVal union all
select -4 as PriKey,'[N/A]' as TextVal union all
select -5 as PriKey,'[Unknown due to bad data]' as TextVal

create table #DataTypes(
	Data_Type nvarchar(4000)
)

-- ************************************************************************************************
insert into #DataTypes(Data_Type)
values('char'),('varchar'),('text'),('nchar'),('nvarchar'),('ntext'),('bigint'),('smallint'),('int'),('tinyint'),('bit'),('numeric'),(
		'decimal'),('money'),('smallmoney'),('float'),('real'),('date'),('datetimeoffset'),('datetime2'),('smalldatetime'),(
		'datetime'),('time'),('date'),('datetimeoffset'),('datetime2'),('smalldatetime'),('datetime'),('time'),('binary'),(
		'varbinary'),('image'),('timestamp'),('hierarchyid'),('uniqueidentifier'),('sql_variant'),('xml')



-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
select
	case 
		when c.COLUMN_NAME = c.table_name + 'Key' then cast(v.PriKey as sql_variant)
		WHEN c.COLUMN_NAME LIKE 'dim%Key%' OR c.COLUMN_NAME LIKE 'dim%Key\_%' ESCAPE '\' THEN cast(v.PriKey as sql_variant)
		when c.DATA_TYPE IN ('char','varchar','text','nchar','nvarchar','ntext') then cast(v.TextVal as sql_variant)
		when c.DATA_TYPE IN ('bigint') then cast(cast(-999999999999999999 as bigint) as sql_variant)
		when c.DATA_TYPE IN ('smallint') then cast(cast(-9999 as smallint) as sql_variant)
		when c.DATA_TYPE IN ('int') then cast(cast(-99999999 as int) as sql_variant)
		when c.DATA_TYPE IN ('tinyint') then cast(cast(255 as tinyint) as sql_variant)
		when c.DATA_TYPE IN ('bit') then cast(cast(0 as bit) as sql_variant)
		when c.DATA_TYPE IN ('numeric','decimal') then cast(('-' + isnull(replicate('9', c.numeric_precision - c.NUMERIC_SCALE), '') + '.' + replicate('9',c.NUMERIC_SCALE)) as sql_variant)
		when c.DATA_TYPE IN ('money') then cast(cast(-99999999999999.9999 as money) as sql_variant)
		when c.DATA_TYPE IN ('smallmoney') then cast(cast(-99999.9999 as smallmoney) as sql_variant)
		when c.DATA_TYPE IN ('float','real') then cast(cast(-9999999 as float) as sql_variant)
		when c.DATA_TYPE IN ('date','datetimeoffset','datetime2','smalldatetime','datetime','time') and c.is_nullable = 'yes' then cast(null as sql_variant)
		when c.DATA_TYPE IN ('date') and c.is_nullable = 'no' then cast(cast('9/9/9999' as date) as sql_variant)
		when c.DATA_TYPE IN ('datetimeoffset') and c.is_nullable = 'no' then cast(cast('9/9/9999 9:9:9.9999' as datetimeoffset) as sql_variant)
		when c.DATA_TYPE IN ('datetime2') and c.is_nullable = 'no' then cast(cast('9/9/9999 9:9:9.9999' as datetime2) as sql_variant)
		when c.DATA_TYPE IN ('smalldatetime') and c.is_nullable = 'no' then cast(cast('9/9/9999 9:9:9.9999' as smalldatetime) as sql_variant)
		when c.DATA_TYPE IN ('datetime') and c.is_nullable = 'no' then cast(cast('9/9/9999 9:9:9.9999' as datetime) as sql_variant)
		when c.DATA_TYPE IN ('time') and c.is_nullable = 'no' then cast(cast('9:9:9.9999' as time) as sql_variant)
		when c.DATA_TYPE IN ('image') then cast(null as sql_variant)
		when c.DATA_TYPE IN ('binary','varbinary') then cast(0 as sql_variant)
		when c.DATA_TYPE IN ('timestamp','hierarchyid','uniqueidentifier','sql_variant','xml') then cast(null as sql_variant)
	end ValueToInsert
	,case 
		when c.COLUMN_NAME = c.table_name + 'Key' then cast(v.PriKey as nvarchar(max))
		WHEN c.COLUMN_NAME LIKE 'dim%Key' OR c.COLUMN_NAME LIKE 'dim%Key\_%' ESCAPE '\' THEN cast(v.PriKey as nvarchar(max))
		when c.DATA_TYPE IN ('char','varchar','text','nchar','nvarchar','ntext') then cast(v.TextVal as nvarchar(max))
		when c.DATA_TYPE IN ('bigint') then cast('-999999999999999999' as nvarchar(max))
		when c.DATA_TYPE IN ('smallint') then cast('-9999' as nvarchar(max))
		when c.DATA_TYPE IN ('int') then cast('-99999999' as nvarchar(max))
		when c.DATA_TYPE IN ('tinyint') then cast('255' as nvarchar(max))
		when c.DATA_TYPE IN ('bit') then cast('0' as nvarchar(max))
		when c.DATA_TYPE IN ('numeric','decimal') then cast(('-' + isnull(replicate('9', c.numeric_precision - c.NUMERIC_SCALE), '') + '.' + replicate('9', c.NUMERIC_SCALE)) as nvarchar(max))
		when c.DATA_TYPE IN ('money') then cast('-99999999999999.9999' as nvarchar(max))
		when c.DATA_TYPE IN ('smallmoney') then cast('-99999.9999' as nvarchar(max))
		when c.DATA_TYPE IN ('float','real') then cast('-9999999' as nvarchar(max))
		when c.DATA_TYPE IN ('date','datetimeoffset','datetime2','smalldatetime','datetime','time') and c.is_nullable = 'yes' then cast(null as nvarchar(max))
		when c.DATA_TYPE IN ('date') and c.is_nullable = 'no' then cast('9/9/9999' as nvarchar(max))
		when c.DATA_TYPE IN ('datetimeoffset') and c.is_nullable = 'no' then cast('9/9/9999 9:9:9.9999' as nvarchar(max))
		when c.DATA_TYPE IN ('datetime2') and c.is_nullable = 'no' then cast('9/9/9999 9:9:9.9999' as nvarchar(max))
		when c.DATA_TYPE IN ('smalldatetime') and c.is_nullable = 'no' then cast('9/9/9999 9:9:9.9999' as nvarchar(max))
		when c.DATA_TYPE IN ('datetime') and c.is_nullable = 'no' then cast('9/9/9999 9:9:9.9999' as nvarchar(max))
		when c.DATA_TYPE IN ('time') and c.is_nullable = 'no' then cast('9:9:9.9999' as nvarchar(max))
		when c.DATA_TYPE IN ('binary','varbinary') then cast('0' as nvarchar(max))
		when c.DATA_TYPE IN ('image') then cast(null as nvarchar(max))
			when c.DATA_TYPE IN ('timestamp','hierarchyid','uniqueidentifier','nvarchar(max)','xml') then cast(null as nvarchar(max))
	end ValueToInsertAsText
	,v.PriKey
	,case 
		when c.DATA_TYPE IN ('char','varchar','text','nchar','nvarchar','ntext') and c.CHARACTER_MAXIMUM_LENGTH != -1 and c.CHARACTER_MAXIMUM_LENGTH < qSize.MinStringSize then cast(1 as bit)
		else cast(0 as bit)
	end as ErrorSsizeTooSmall
	,c.*
into #DefValue
from
	information_schema.COLUMNS c
	join information_schema.tables t
		on c.TABLE_SCHEMA = t.TABLE_SCHEMA
			and c.TABLE_NAME = t.TABLE_NAME
	cross join #DefText v
	cross join (
		select 
			max(len(TextVal)) MinStringSize
		from 
			#DefText
	) qSize
where
	t.TABLE_TYPE = 'base table'
	and t.TABLE_NAME like 'dim%'
	and t.TABLE_SCHEMA = 'dbo'
	and COLUMNPROPERTY(OBJECT_ID('[' + c.table_schema + '].[' + c.table_name + ']'), c.COLUMN_NAME, 'IsComputed') = 0


-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
SELECT
	 q.TABLE_SCHEMA
	,q.TABLE_NAME
 	,'insert into [default_values].[' + q.table_name + '] with(tablock) ('
		+ dbo.fn_TableColumnList(q.TABLE_SCHEMA, q.TABLE_NAME, NULL, 1, 0, 1, 0) + 
		') values' as InsertDeclare
into #InsertDeclare
FROM
	(
		SELECT DISTINCT
			 t.TABLE_SCHEMA
			,t.TABLE_NAME
		FROM 
			INFORMATION_SCHEMA.tables t
			join #DefValue v
				on t.TABLE_SCHEMA = v.TABLE_SCHEMA
					and t.TABLE_NAME = v.TABLE_NAME
		where
			t.TABLE_TYPE = 'base table'
			and t.TABLE_NAME like 'dim%'
			and t.TABLE_SCHEMA = 'dbo'
	) q


-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
SELECT
	row_number() over(order by t.TABLE_SCHEMA, t.TABLE_NAME, v.PriKey desc, v.ordinal_position) *10 rowid
	,t.TABLE_SCHEMA
	,t.TABLE_NAME
 	,id.InsertDeclare
	,v.PriKey
	,nchar(9) + 
		case
			when v.ORDINAL_POSITION = 1 then ''
			else ','
		end +
		CASE
			WHEN v.Column_Name LIKE (v.table_name + 'Key!_%') ESCAPE '!' THEN 'cast(' + CAST(v.PriKey AS nvarchar(max))
			else
				case
					when v.DATA_TYPE in ('binary','varbinary') then ISNULL('cast(' + v.ValueToInsertAsText, 'cast(null') 
					else ISNULL('cast(''' + v.ValueToInsertAsText + '''', 'cast(null') 
				END			              
		end + 
		' as ' + v.Data_type + 
		case
			when v.Data_type in ('numeric', 'decimal') then '(' + cast(v.numeric_precision as nvarchar(max)) + ',' + cast(v.NUMERIC_SCALE as nvarchar(max)) + ')'
			else ''
		end +
		')       -- ' + v.Column_name as InsertVal
into #final
FROM 
	INFORMATION_SCHEMA.tables t
	join #DefValue v
		on t.TABLE_SCHEMA = v.TABLE_SCHEMA
			and t.TABLE_NAME = v.TABLE_NAME
	JOIN #InsertDeclare id
		on t.TABLE_SCHEMA = id.TABLE_SCHEMA
			and t.TABLE_NAME = id.TABLE_NAME
order by 
	 t.TABLE_SCHEMA
	,t.TABLE_NAME
	,v.PriKey desc
	,v.ordinal_position


	
-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
select
	f.TABLE_SCHEMA
	,f.TABLE_NAME
	,f.PriKey
	,min(rowid) as min_rowid
	,max(rowid) as max_rowid
into #MinMax
from
	#final f
group by
	f.TABLE_SCHEMA
	,f.TABLE_NAME
	,f.PriKey
order by 1,2,3



-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
insert into #final(rowid, table_schema, table_name, InsertDeclare, PriKey, InsertVal)
select 
	f.min_rowid -1
	,f.TABLE_SCHEMA
	,f.TABLE_NAME
	,case f.PriKey
		when -1 then '('
		else '),('
	end as InsertDeclare
	,f.PriKey
	,case f.PriKey
		when -1 then '('
		else '),('
	end as InsertVal	
from
	#MinMax f

union all

select 
	f.max_rowid +1
	,f.TABLE_SCHEMA
	,f.TABLE_NAME
	,')' as InsertDeclare
	,f.PriKey
	,')' as InsertVal	
from
	#MinMax f
where
	f.PriKey = (select min(PriKey) from #final)



-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
/*
-- debug
select
	'set IDENTITY_INSERT [' + f.table_schema + '].[' + f.table_name + '] on'
	,char(10) + char(13) + f.InsertDeclare
	,char(10) + char(13) + 'set IDENTITY_INSERT [' + f.table_schema + '].[' + f.table_name + '] off'
	,f.InsertVal
	,*
from
	#final f
where
	f.table_name = 'dimEarningsMethod'
order by
	rowid
*/



-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
DECLARE @SqlCode table
(
	TABLE_NAME sysname
	,SQLCODE NVARCHAR(max)
)


-- ************************************************************************************************
INSERT INTO @SqlCode(TABLE_NAME, SQLCODE)
SELECT DISTINCT
	f.table_name
	,CASE
		WHEN q.TABLE_NAME IS NULL THEN ''
		ELSE 'set IDENTITY_INSERT [default_values].[' + f.table_name + '] on'
	end
from
	#final f
	LEFT JOIN (
		SELECT DISTINCT
			TABLE_SCHEMA
			,TABLE_NAME
		FROM
			INFORMATION_SCHEMA.COLUMNS c
		WHERE
			c.TABLE_SCHEMA = 'default_values'
			and COLUMNPROPERTY(object_id('[' + table_schema + '].[' + table_name + ']'), COLUMN_NAME, 'IsIdentity') = 1
	) q
		ON f.TABLE_NAME = q.TABLE_NAME
ORDER BY 1


-- ************************************************************************************************
UPDATE s
set
	s.SQLCODE = s.SQLCODE + char(10) + char(13) + q.InsertDeclare
FROM
	@SqlCode s
	JOIN (
		SELECT distinct
			f.TABLE_NAME
			,f.InsertDeclare
		FROM 
			#final f
		WHERE
			f.InsertDeclare LIKE 'insert into%'
	) q
		ON s.TABLE_NAME = q.TABLE_NAME


-- ************************************************************************************************
UPDATE s
set
	s.SQLCODE = s.SQLCODE + char(10) + char(13) 
			+ replace(STUFF(( 
				SELECT 
					[text()]= char(10) + char(13) + ISNULL(f.InsertVal, '') + '' 
				FROM 
					#final f
				where
					s.TABLE_NAME = f.TABLE_NAME
				ORDER BY
					f.rowid              
				FOR XML PATH('')), 
				1,1, ''),
				'&#x0D;',
				CHAR(13)
				)
FROM
	@SqlCode s

	
-- ************************************************************************************************
UPDATE s
set
	s.SQLCODE = s.SQLCODE + char(10) + char(13) + 'set IDENTITY_INSERT [default_values].[' + s.table_name + '] off'
FROM
	@SqlCode s
	JOIN (
		SELECT DISTINCT
			TABLE_NAME
		FROM
			INFORMATION_SCHEMA.COLUMNS			        
		WHERE
			TABLE_SCHEMA = 'default_values'
			AND COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1
	) c
		ON s.TABLE_NAME = c.TABLE_NAME


-- ************************************************************************************************
SELECT * FROM @SqlCode






