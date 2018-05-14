CREATE TABLE [dbo].[dim_how_did_you_hear] (
    [dim_how_did_you_hear_key] INT            IDENTITY (1, 1) NOT NULL,
    [how_did_you_hear]         NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dim_how_did_you_hear] PRIMARY KEY CLUSTERED ([dim_how_did_you_hear_key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_how_did_you_hear]
    ON [dbo].[dim_how_did_you_hear]([how_did_you_hear] ASC) WHERE ([dim_how_did_you_hear_key]>(0));

