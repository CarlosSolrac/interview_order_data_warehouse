

/*


exec dbo.usp_MergeDefaultValues @Schema='dbo', @TABLE_NAME='dim_coupons', @Verbose=1, @ExecSQL=1




*/
CREATE PROC dbo.[usp_MergeDefaultValues](
	 @Schema sysname = null
	,@TABLE_NAME sysname
	,@Verbose BIT = 0
	,@ExecSQL BIT = 1
	)
AS



-- ************************************************************************************************
-- ************************************************************************************************
SET NOCOUNT on


-- ************************************************************************************************
-- ************************************************************************************************
DECLARE @SqlCode nvarchar(MAX)
DECLARE @err nvarchar(MAX)
DECLARE @HasIdentityColumn BIT
DECLARE @PrimaryKeyColName sysname

-- ************************************************************************************************
-- ************************************************************************************************
SET @Schema = isnull(@Schema, 'dbo')
SET @PrimaryKeyColName = @TABLE_NAME + '_key'
SET @SqlCode = 'MERGE [<<schema>>].[<<TableName>>] AS target
USING [default_values].[<<TableName>>] AS source 
	ON (target.<<PrimKeyCol>> = source.<<PrimKeyCol>>)
WHEN MATCHED THEN 
    UPDATE SET <<ColListWithAssignments>>         
WHEN NOT MATCHED THEN	
	INSERT (<<ColList>>)
	VALUES (<<ColListWithParent>>);'
--OUTPUT deleted.*, $action, inserted.*; -- used for debugging the merge statement


-- ************************************************************************************************
-- ************************************************************************************************
IF EXISTS(
	SELECT TOP 1 TABLE_NAME 
	FROM
		INFORMATION_SCHEMA.COLUMNS			        
	WHERE
		TABLE_SCHEMA = @schema
		AND TABLE_NAME = @TABLE_NAME
		AND COLUMNPROPERTY(object_id('[' + @schema + '].[' + TABLE_NAME + ']'), COLUMN_NAME, 'IsIdentity') = 1
	)
begin
	SET @HasIdentityColumn = 1
end
else
begin
	SET @HasIdentityColumn = 0
end

IF @Verbose = 1
BEGIN
	IF @HasIdentityColumn = 1
	begin
		PRINT concat('[util].[usp_MergeDefaultValues] [', @schema, '].[', @TABLE_NAME, '] has an identity column.', NCHAR(10), NCHAR(13))
	END
    ELSE
	BEGIN
		PRINT concat('[util].[usp_MergeDefaultValues] [', @schema, '].[', @TABLE_NAME, '] DOES NOT have an identity column.', NCHAR(10), NCHAR(13))
	end
END


-- ************************************************************************************************
-- ************************************************************************************************
begin try

	SET @SqlCode = REPLACE(@SqlCode, '<<schema>>', @Schema)
	SET @SqlCode = REPLACE(@SqlCode, '<<TableName>>', @TABLE_NAME)
	SET @SqlCode = REPLACE(@SqlCode, '<<PrimKeyCol>>', @PrimaryKeyColName)
	SET @SqlCode = REPLACE(@SqlCode, '<<ColListWithAssignments>>', dbo.fn_TableColumnList_WithAssignment(@Schema, @TABLE_NAME, 'target', 'source', 0, 0, 0))
	SET @SqlCode = REPLACE(@SqlCode, '<<ColList>>', dbo.fn_TableColumnList(@Schema, @TABLE_NAME, NULL, 1, 0, 0, 0))
	SET @SqlCode = REPLACE(@SqlCode, '<<ColListWithParent>>', dbo.fn_TableColumnList(@Schema, @TABLE_NAME, 'source', 1, 0, 0, 0))

	-- ************************************************************************************************
	-- ************************************************************************************************
	SELECT 
		@SqlCode = 'set IDENTITY_INSERT [' + @Schema + '].[' + @TABLE_NAME + '] on' + NCHAR(10) + NCHAR(13)
			+ @SqlCode + NCHAR(10) + NCHAR(13)
			+ 'set IDENTITY_INSERT [' + @Schema + '].[' + @TABLE_NAME + '] off'
	where
		@HasIdentityColumn = 1

	---- ************************************************************************************************
	IF @Verbose = 1
	BEGIN
		PRINT @SqlCode
	END
    
	IF @ExecSQL = 1
	begin
		exec sp_executesql @SqlCode
	end


end try
begin catch
	set @err = 'Error in [util].[usp_MergeDefaultValues]. Probably need to rerun: exec [util].[usp_CreateTablesWithDefaultValues].'
		+ ' ERROR_NUMBER: ' + isnull(cast(ERROR_NUMBER() AS nvarchar), '')
		+ ' ERROR_SEVERITY: ' + isnull(cast(ERROR_SEVERITY() AS nvarchar), '')
		+ ' ERROR_STATE: ' + isnull(cast(ERROR_STATE() AS nvarchar), '')
		+ ' ERROR_PROCEDURE: ' + isnull(ERROR_PROCEDURE(), '')
		+ ' ERROR_LINE: ' + isnull(cast(ERROR_LINE() AS nvarchar), '')
		+ ' ERROR_MESSAGE: ' + isnull(ERROR_MESSAGE(), '')

	raiserror(@err, 18, 1)
end catch






