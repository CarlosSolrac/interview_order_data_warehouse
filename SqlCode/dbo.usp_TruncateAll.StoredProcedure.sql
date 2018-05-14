USE [CatchCo]
GO
/****** Object:  StoredProcedure [dbo].[usp_TruncateAll]    Script Date: 5/14/2018 2:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE proc [dbo].[usp_TruncateAll]
AS


EXEC dbo.usp_DropAllForeignKeyConstraints @verbose = 0 -- bit


truncate table dbo.tblExecSqlStatements_Results_TableType_V01
truncate table dbo.dim_coupons
truncate table dbo.dim_customers
truncate table dbo.dim_how_did_you_hear
truncate table dbo.dim_how_did_you_hear_other
truncate table dbo.dim_order_status
truncate table dbo.dim_subscriptions
truncate table dbo.fact_orders


GO
