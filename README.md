# NOTES

The primary sproc that does all the work is call dbo.usp_Main. Inside the sproc is the following code block:
```
/*
exec dbo.usp_DropFK_DropIdx_TruncateAll
exec dbo.usp_ShrinkDatabase
exec dbo.usp_AutomaticallyCreateForeignKeyRelationships
exec dbo.usp_CreateTablesWithDefaultValues
EXEC dbo.usp_MergeDefaultValuesIntoDimensions
*/
```
This code will not delete the contents of the staging tables. But it will delete the contents of the data warehouse, 
so you can run the stored procedure and populate an empty data warehouse.

Several of the sprocs and functions do not actually build or populate the data warehouse. For example, 
dbo.usp_CreateMergeSprocsForCsv generates the "MERGE" statements which were then copy pasted into dbo.usp_Merge_Data.


# FOLDERS
## SqlCode
Is a dump of all the SQL scripts used to build the data warehouse.

## db_backup
Is a database backup. If you attempt to restore it, you will need SQL Server 2017 V14.0.3025.34 or higher.

## answers
Contains the SQL queries used to answer the interview questions. I wasn't sure if the task was meant to exclude 
cancelations, so I took cancelations into account when writing the queries.

**dbo.answers_from_staging.sql** is the query used to answer the interview questions using the staging tables.

**dbo.answers_from_staging.rpt** is the output from the query in a fixed column format generated by SSMS.

**dbo.answers_from_data_warehouse.sql** is the query used to answer the interview questions using the data warehouse.

**dbo.answers_from_data_warehouse.rpt** is the output from the query in a fixed column format generated by SSMS.

## vs_database_project
VS Studio database project which include all the SQL source code.

# Apology
My apologies for the mixed capitalization across the code. Some code is new, some code is part of my personal toolkit.

“We apologize for the inconvenience.” -God's Final Message to His Creation. The Hitchhiker's Guide to the Galaxy.  