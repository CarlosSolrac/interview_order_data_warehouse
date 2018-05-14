











/*


declare @tblSqlCode dbo.ExecSqlStatementsTableType;
declare @GuidExecutionBatch uniqueidentifier

insert into @tblSqlCode(SqlCode)
values('print ''task 1'''), ('print ''task 2'''), ('print 1/0')


exec dbo.usp_ExecSqlStatements @TableSqlCode=@tblSqlCode
	,@verbose = 0
	,@ExecSql = 1
	,@UseTransactions = 0
	,@StopOnError = 1
	,@RaiseError = 0
    ,@GuidExecutionBatch = @GuidExecutionBatch output

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


IF EXISTS(SELECT TOP 1 1 FROM dbo.tblExecSqlStatements_Results_TableType_V01 r WHERE r.GuidExecutionBatch = @GuidExecutionBatch and r.ErrorExecuting = 1)
BEGIN
    --RAISERROR('Error executing code', 18, 0)
	print 'Error detected'
end


*/
CREATE PROC [dbo].[usp_ExecSqlStatements](
	@TableSqlCode dbo.ExecSqlStatementsTableType READONLY
	,@verbose BIT = 0
	,@ExecSql BIT = 1
	,@UseTransactions BIT = 1
	,@StopOnError BIT = 1
	,@RaiseError BIT = 0
    ,@GuidExecutionBatch UNIQUEIDENTIFIER OUTPUT
	)
AS


-- ************************************************************************************************
-- ************************************************************************************************
set nocount on
SET XACT_ABORT ON

-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
declare @MaxRows int
declare @row int
declare @sql nvarchar(max)
DECLARE @ErrorMessage NVARCHAR(max);
DECLARE @ErrorSeverity INT;
DECLARE @ErrorState INT;
DECLARE @StartTime datetime;
DECLARE @EndTime datetime;


-- ************************************************************************************************
SET @GuidExecutionBatch = NEWID()


-- ************************************************************************************************
INSERT INTO dbo.tblExecSqlStatements_Results_TableType_V01(RowId, SqlCode, GuidExecutionBatch, SPID, Param01_BigInt, Param02_Variant)
select RowId, SqlCode, @GuidExecutionBatch, @@SPID, Param01_BigInt, Param02_Variant FROM @TableSqlCode


-- ************************************************************************************************
-- ************************************************************************************************
-- ************************************************************************************************
select
	@row = min(RowId)
	,@MaxRows = max(RowId)
from
	@TableSqlCode


-- ************************************************************************************************
WHILE @row <= @MaxRows
BEGIN
	
	select
		@sql = SqlCode
	from
		@TableSqlCode
	where
		RowId = @row

	IF @sql IS NOT NULL
	BEGIN 

		if @verbose=1
		begin
			print @sql
		end

		IF @ExecSql=1
		BEGIN

			SET @StartTime = GETDATE();
			
			BEGIN TRY
				
				IF @UseTransactions = 1
					BEGIN TRAN
				
				exec sp_executesql @sql

				SET @EndTime = GETDATE();

				UPDATE dbo.tblExecSqlStatements_Results_TableType_V01
				SET 
					TotalExecutionTimeSeconds = DATEADD(s, DATEDIFF(s, @StartTime, @EndTime), 0)
					,ExecuteStartTime = @StartTime
				WHERE
					RowId = @row
                    AND GuidExecutionBatch = @GuidExecutionBatch


				IF @UseTransactions = 1
					COMMIT TRAN
			END TRY
			BEGIN CATCH
			    SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

				IF @@TRANCOUNT > 0 AND @UseTransactions = 1
				BEGIN
					ROLLBACK TRAN
				END

				SET @EndTime = GETDATE();
					
				UPDATE dbo.tblExecSqlStatements_Results_TableType_V01
				SET 
					ErrorExecuting = 1
					,ExecuteStartTime = @StartTime
					,TotalExecutionTimeSeconds = DATEADD(s, DATEDIFF(s, @StartTime, @EndTime), 0)
					,ErrorMessage = @ErrorMessage
                    ,ErrorSeverity = @ErrorSeverity
					,ErrorState = @ErrorState
				WHERE
					RowId = @row
                    AND GuidExecutionBatch = @GuidExecutionBatch

				IF @RaiseError = 1
				BEGIN
					RAISERROR(@ErrorMessage, 9, 1)
				END

				IF @StopOnError = 1
				BEGIN
					RETURN
				END
			END CATCH
			          
		END
	END


	SET @row = @row +1
END







