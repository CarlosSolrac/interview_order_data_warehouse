USE [CatchCo]
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_IsTextIdentical]    Script Date: 5/14/2018 2:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create FUNCTION [dbo].[ufn_IsTextIdentical](
     @p1 nvarchar(max)
    ,@p2 nvarchar(max)
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
