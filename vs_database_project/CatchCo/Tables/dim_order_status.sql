CREATE TABLE [dbo].[dim_order_status] (
    [dim_order_status_key] INT            IDENTITY (1, 1) NOT NULL,
    [status]               NVARCHAR (128) NOT NULL,
    [state]                NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dim_order_status] PRIMARY KEY CLUSTERED ([dim_order_status_key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_order_status]
    ON [dbo].[dim_order_status]([state] ASC, [status] ASC) WHERE ([dim_order_status_key]>(0));

