CREATE TABLE [default_values].[dim_subscriptions] (
    [dim_subscriptions_key] INT            IDENTITY (1, 1) NOT NULL,
    [subscription_id]       INT            NOT NULL,
    [subscription_desc]     NVARCHAR (128) NOT NULL
);

