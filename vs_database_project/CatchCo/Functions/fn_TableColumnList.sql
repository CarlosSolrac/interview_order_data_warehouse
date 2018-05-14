

CREATE function [dbo].[fn_TableColumnList](
	@TargetSchema sysname
	,@TargetTableName sysname
	,@Parent sysname
	,@IncludePrimaryKeys BIT = 1
	,@IncludeComputedColumns BIT = 1
	,@IncludeTimestampColumns BIT = 1
	,@CastTimestampToVarbinary BIT = 1
	)
returns nvarchar(max)
as
begin



declare @ColumnList nvarchar(max)

set @ColumnList = (
	SELECT STUFF(( SELECT [text()]= ',' +
		CASE 
			WHEN @CastTimestampToVarbinary = 1 AND c.DATA_TYPE = 'timestamp' THEN 'cast('
			ELSE ''
		END +
		ISNULL(ISNULL('[' + @Parent + '].', '') + '[' + c.COLUMN_NAME + ']', '') + 
		CASE 
			WHEN @CastTimestampToVarbinary = 1 AND c.DATA_TYPE = 'timestamp' THEN ' as varbinary(8)) as' + ISNULL(ISNULL('[' + @Parent + '].', '') + '[' + c.COLUMN_NAME + ']', '')
			ELSE ''
		END +
		'' 
	FROM 
		information_schema.columns c WITH(NOLOCK)
		LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu WITH(NOLOCK)
			ON c.TABLE_NAME = kcu.TABLE_NAME
				AND c.TABLE_SCHEMA = kcu.TABLE_SCHEMA
				AND c.COLUMN_NAME = kcu.COLUMN_NAME
	where
		c.TABLE_SCHEMA = @TargetSchema
		and c.TABLE_NAME = @TargetTableName
		AND (
			@IncludeTimeStampColumns = 1
			OR (
				@IncludeTimeStampColumns = 0
				AND c.DATA_TYPE != 'timestamp'
			)
		)
		AND (
			@IncludePrimaryKeys = 1
			OR (
				@IncludePrimaryKeys = 0
				AND (
					kcu.CONSTRAINT_NAME IS NULL
                    OR (
						kcu.CONSTRAINT_NAME IS NOT null
						AND OBJECTPROPERTY(OBJECT_ID('[' + kcu.CONSTRAINT_SCHEMA + '].[' + kcu.CONSTRAINT_NAME + ']'), 'IsPrimaryKey') = 0
					)
				)
			)
		)
		AND (
			@IncludeComputedColumns = 1
			OR (
				@IncludeComputedColumns = 0
				AND COLUMNPROPERTY(OBJECT_ID('[' + c.table_schema + '].[' + c.table_name + ']'), c.COLUMN_NAME, 'IsComputed') = 0
			)
		)
	ORDER BY c.ORDINAL_POSITION
	FOR XML PATH('')), 1,1, '')
	)

return @ColumnList

end
