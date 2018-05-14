CREATE TABLE [dbo].[tblExecSqlStatements_Results_TableType_V01] (
    [pkey]                      INT              IDENTITY (1, 1) NOT NULL,
    [ErrorExecuting]            BIT              CONSTRAINT [DF_tblExecSqlStatements_Results_TableType_V01_ErrorExecuting] DEFAULT ((0)) NOT NULL,
    [ExecuteStartTime]          DATETIME         NULL,
    [TotalExecutionTimeSeconds] TIME (0)         NULL,
    [ErrorMessage]              NVARCHAR (MAX)   NULL,
    [ErrorSeverity]             INT              NULL,
    [ErrorState]                INT              NULL,
    [SqlCode]                   NVARCHAR (MAX)   NULL,
    [RowId]                     INT              NOT NULL,
    [GuidExecutionBatch]        UNIQUEIDENTIFIER NOT NULL,
    [SPID]                      INT              NULL,
    [RowCreatedDate]            DATETIME         CONSTRAINT [DF_tblExecSqlStatements_Results_TableType_V01_RowCreatedDate] DEFAULT (getdate()) NOT NULL,
    [Param01_BigInt]            BIGINT           NULL,
    [Param02_Variant]           SQL_VARIANT      NULL,
    CONSTRAINT [PK_tblExecSqlStatements_Results_TableType_V01] PRIMARY KEY CLUSTERED ([pkey] ASC)
);

