USE [CatchCo]
GO
/****** Object:  StoredProcedure [dbo].[usp_ShrinkLogOnly]    Script Date: 5/14/2018 2:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE proc [dbo].[usp_ShrinkLogOnly]
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

--DBCC SHRINKDATABASE(@CatalogName);







GO
