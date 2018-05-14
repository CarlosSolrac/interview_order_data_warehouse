CREATE TYPE [dbo].[ExecSqlStatementsTableType] AS TABLE (
    [RowId]           INT            IDENTITY (1, 1) NOT NULL,
    [SqlCode]         NVARCHAR (MAX) NOT NULL,
    [Param01_BigInt]  BIGINT         NULL,
    [Param02_Variant] SQL_VARIANT    NULL);

