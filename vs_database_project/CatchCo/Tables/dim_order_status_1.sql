CREATE TABLE [default_values].[dim_order_status] (
    [dim_order_status_key] INT            IDENTITY (1, 1) NOT NULL,
    [status]               NVARCHAR (128) NOT NULL,
    [state]                NVARCHAR (128) NOT NULL
);

