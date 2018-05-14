







CREATE proc [dbo].[usp_ShrinkDatabase]
as

DECLARE @LogFileName sysname
DECLARE @DataFileName sysname
DECLARE @CatalogName sysname

set @CatalogName = db_name()

SELECT 
	@LogFileName = rtrim([name])
from
	sys.database_files
where 
	type_desc = 'LOG'

SELECT 
	@DataFileName = rtrim([name])
from
	sys.database_files
where 
	type_desc = 'rows'

select 
	@LogFileName as LogFileName,
	@DataFileName as DataFileName

Checkpoint;

DBCC SHRINKFILE(@LogFileName, 1);

DBCC SHRINKDATABASE(@CatalogName);







