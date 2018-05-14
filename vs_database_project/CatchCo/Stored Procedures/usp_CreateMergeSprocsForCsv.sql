




CREATE proc [dbo].[usp_CreateMergeSprocsForCsv]
as


DECLARE @template NVARCHAR(max) = '
MERGE dbo.<<TblName>> AS Tgt
USING source.<<TblName>> AS Src
ON (Tgt.<<PrimKey>> = Src.<<PrimKey>>) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT(<<ColList>>) 
	VALUES(<<ColList>>)
WHEN MATCHED AND (
<<TestFieldList>>
    ) THEN UPDATE SET 
<<SetFieldList>> 
--WHEN NOT MATCHED BY SOURCE
--    THEN DELETE
    ;
'




declare @TAB nchar(1) = nchar(9)
declare @CRLF nchar(2) = nchar(13) + nchar(10)
declare @CRLF_TAB nchar(3) = @TAB + @CRLF
declare @OR_CRLF_TAB nvarchar(20) = ' OR' + @CRLF_TAB
declare @COMMA_CRLF_TAB nvarchar(20) = ',' + @CRLF_TAB

;WITH cteBase
AS (
	SELECT
		 src_cols.TABLE_NAME
		,iif(src_cols.ORDINAL_POSITION = 1, 1, 0) AS IsPrimaryKey
		,quotename(src_cols.COLUMN_NAME) as COLUMN_NAME
	FROM
		INFORMATION_SCHEMA.COLUMNS src_cols
		join INFORMATION_SCHEMA.COLUMNS targ_cols
            on src_cols.TABLE_SCHEMA = 'source'
                and targ_cols.TABLE_SCHEMA = 'dbo'
                and src_cols.TABLE_NAME = targ_cols.TABLE_NAME
                and src_cols.COLUMN_NAME = targ_cols.COLUMN_NAME
),
cteAllCols
as (
    select
		c.TABLE_NAME
        ,STRING_AGG(c.COLUMN_NAME, ', ') within group (order by c.COLUMN_NAME) as ColList
    from
        cteBase c
    group by
    	c.TABLE_NAME
),
cte
as (
    select
		c.TABLE_NAME
        ,pk.PrimaryKeyColumnName
        ,ac.ColList
        ,STRING_AGG(concat(@TAB, 'dbo.ufn_IsValuesIdentical(Src.', c.COLUMN_NAME, ', Tgt.', c.COLUMN_NAME, ') = 0'), @OR_CRLF_TAB) 
            within group (order by c.COLUMN_NAME) as TestFieldList
        ,STRING_AGG(concat(@TAB, 'Tgt.', c.COLUMN_NAME, ' = Src.', c.COLUMN_NAME), @COMMA_CRLF_TAB) 
            within group (order by c.COLUMN_NAME) as SetFieldList
    from
        cteBase c
        join cteAllCols ac
            on c.TABLE_NAME = ac.TABLE_NAME
        join (
            select
                TABLE_NAME
                ,COLUMN_NAME as PrimaryKeyColumnName
            from
                cteBase
            where
                IsPrimaryKey = 1
        ) pk
            on c.TABLE_NAME = pk.TABLE_NAME
    where
        c.IsPrimaryKey = 0
    group by
    	c.TABLE_NAME
        ,ac.ColList
        ,pk.PrimaryKeyColumnName
)
SELECT
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@template
		,'<<TblName>>', c.TABLE_NAME)
		,'<<PrimKey>>', c.PrimaryKeyColumnName)
		,'<<ColList>>', c.ColList)
		,'<<TestFieldList>>', c.TestFieldList)
		,'<<SetFieldList>>', c.SetFieldList)
	--,'truncate table dbo.' + TABLE_NAME AS TuncateTable
FROM
	cte c










