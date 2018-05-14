CREATE TABLE [dbo].[dim_subscriptions] (
    [dim_subscriptions_key] INT            IDENTITY (1, 1) NOT NULL,
    [subscription_id]       INT            NOT NULL,
    [subscription_desc]     NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dim_subscriptions] PRIMARY KEY CLUSTERED ([dim_subscriptions_key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_subscriptions]
    ON [dbo].[dim_subscriptions]([subscription_id] ASC) WHERE ([dim_subscriptions_key]>(0));

