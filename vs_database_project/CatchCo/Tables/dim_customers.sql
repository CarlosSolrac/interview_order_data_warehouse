CREATE TABLE [dbo].[dim_customers] (
    [dim_customers_key] INT            IDENTITY (1, 1) NOT NULL,
    [account_id]        INT            NOT NULL,
    [email]             NVARCHAR (320) NOT NULL,
    [fname]             NVARCHAR (128) NOT NULL,
    [lname]             NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dim_customers] PRIMARY KEY CLUSTERED ([dim_customers_key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_customers]
    ON [dbo].[dim_customers]([email] ASC) WHERE ([dim_customers_key]>(0));

