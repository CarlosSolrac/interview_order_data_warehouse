USE [CatchCo]
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_IsValuesIdentical]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[ufn_IsValuesIdentical](
     @p1 SQL_VARIANT
    ,@p2 SQL_VARIANT
)
RETURNS BIT WITH SCHEMABINDING 
AS
BEGIN
    DECLARE @res BIT

    IF NULLIF(@p1, @p2) IS NULL AND NULLIF(@p2, @p1) IS NULL
    BEGIN
        SET @res = 1;
    END
    ELSE
    BEGIN
        SET @res = 0
    END

    RETURN @res
END




GO
