





CREATE FUNCTION [dbo].[ufn_CreateForeignKeyName](
     @fact_TABLE_SCHEMA  sysname
    ,@fact_TABLE_NAME   sysname
    ,@fact_COLUMN_NAME  sysname
    ,@dim_TABLE_SCHEMA  sysname
    ,@dim_TABLE_NAME    sysname
    ,@dim_COLUMN_NAME   sysname
    )
RETURNS sysname
AS
BEGIN

    DECLARE @fkname sysname = LEFT(CONCAT('FK_', @fact_TABLE_NAME, '_', @dim_TABLE_NAME), 128)
    
    DECLARE @hash sysname = CONCAT('_', master.sys.fn_varbintohexstr(
		    HASHBYTES('md2', 
			    lower(replace(replace(replace(replace(replace(replace(
				    '[<<fschema>>].[<<ftable>>].[<<fcolumn>>]_[<<dschema>>].[<<dtable>>].[<<dcolumn>>]'
				    , '<<fschema>>', @fact_TABLE_SCHEMA), '<<ftable>>', @fact_TABLE_NAME)
				    , '<<dschema>>', @dim_TABLE_SCHEMA), '<<dtable>>', @dim_TABLE_NAME)
				    ,'<<fcolumn>>', @fact_COLUMN_NAME)
				    ,'<<dcolumn>>', @dim_COLUMN_NAME)
				    )
			    )
		    )
        )

    RETURN CONCAT(LEFT(@fkname, 128 - LEN(@hash)), @hash)

END
