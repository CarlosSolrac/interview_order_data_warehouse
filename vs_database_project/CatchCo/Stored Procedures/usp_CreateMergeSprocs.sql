




CREATE proc [dbo].[usp_CreateMergeSprocs]
as


DECLARE @template NVARCHAR(max) = '
MERGE dbo.<<TblName>> AS Tgt
USING source.<<TblName>> AS Src
ON (Tgt.<<PrimKey>> = Src.<<PrimKey>>) 
WHEN NOT MATCHED BY TARGET THEN 
	INSERT(<<ColList>>) 
	VALUES(<<ColList>>)
WHEN MATCHED AND Tgt.<<stamp>> != Src.<<stamp>>
    THEN UPDATE SET 
<<SetFieldList>>WHEN NOT MATCHED BY SOURCE
    THEN DELETE;
'

;WITH cte
AS (
	SELECT distinct
		 t.TABLE_NAME
		,ISNULL(ccu.COLUMN_NAME, '') AS PrimKey
		,stamp.COLUMN_NAME AS stamp
		,STUFF((SELECT [text()]= ',' + ISNULL(c.column_name, '') + '' 
			from
				INFORMATION_SCHEMA.COLUMNS c
			WHERE	
				t.TABLE_SCHEMA = c.TABLE_SCHEMA
				AND t.TABLE_NAME = c.TABLE_NAME
			FOR XML PATH('')), 1,1, '') AS ColList
		,CHAR(9) + CHAR(9) + REPLACE(
			STUFF((
				SELECT 
					[text()]= ',Tgt.' + ISNULL(c.column_name, '') + ' = Src.' + ISNULL(c.column_name, '') + CHAR(10)
				from
					INFORMATION_SCHEMA.COLUMNS c
				WHERE	
					t.TABLE_SCHEMA = c.TABLE_SCHEMA
					AND t.TABLE_NAME = c.TABLE_NAME
				FOR XML PATH(''))
			,1,1, ' '), ',', CHAR(9) + CHAR(9) + ',') AS SetFieldList
	FROM
		INFORMATION_SCHEMA.tables t
		LEFT JOIN [INFORMATION_SCHEMA].[TABLE_CONSTRAINTS] tc
			ON t.TABLE_SCHEMA = tc.TABLE_SCHEMA
				AND t.TABLE_NAME = tc.TABLE_NAME
				AND tc.CONSTRAINT_TYPE = 'primary key'
		LEFT JOIN [INFORMATION_SCHEMA].[CONSTRAINT_COLUMN_USAGE] ccu
			ON ccu.TABLE_SCHEMA = tc.TABLE_SCHEMA
				AND ccu.TABLE_NAME = tc.TABLE_NAME
				AND ccu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
		CROSS APPLY (
			SELECT
				c.column_name
			from
				INFORMATION_SCHEMA.COLUMNS c
			WHERE	
				t.TABLE_SCHEMA = c.TABLE_SCHEMA
				AND t.TABLE_NAME = c.TABLE_NAME
				AND c.DATA_TYPE = 'timestamp'
		) stamp
	WHERE
		t.TABLE_SCHEMA = 'dbo'
		AND t.TABLE_NAME NOT IN ('dimDate', 'TallyLarge', 'TallySmallZeroBased')
		AND t.TABLE_TYPE = 'base table'
)
SELECT
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@template
		,'<<TblName>>', TABLE_NAME)
		,'<<PrimKey>>', PrimKey)
		,'<<ColList>>', ColList)
		,'<<stamp>>', stamp)
		,'<<SetFieldList>>', SetFieldList)
	,'truncate table dbo.' + TABLE_NAME AS TuncateTable
FROM
	cte







