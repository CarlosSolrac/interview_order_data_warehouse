CREATE TABLE [dbo].[dim_shipping] (
    [dim_shipping_key]     INT            IDENTITY (1, 1) NOT NULL,
    [shipping_description] NVARCHAR (128) NOT NULL,
    [shipping_method]      NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dim_shipping_key] PRIMARY KEY CLUSTERED ([dim_shipping_key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_shipping]
    ON [dbo].[dim_shipping]([shipping_description] ASC, [shipping_method] ASC) WHERE ([dim_shipping_key]>(0));

