CREATE TABLE [default_values].[dim_shipping] (
    [dim_shipping_key]     INT            IDENTITY (1, 1) NOT NULL,
    [shipping_description] NVARCHAR (128) NOT NULL,
    [shipping_method]      NVARCHAR (128) NOT NULL
);

