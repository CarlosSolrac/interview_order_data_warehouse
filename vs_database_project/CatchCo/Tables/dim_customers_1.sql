CREATE TABLE [default_values].[dim_customers] (
    [dim_customers_key] INT            IDENTITY (1, 1) NOT NULL,
    [account_id]        INT            NOT NULL,
    [email]             NVARCHAR (320) NOT NULL,
    [fname]             NVARCHAR (128) NOT NULL,
    [lname]             NVARCHAR (128) NOT NULL
);

