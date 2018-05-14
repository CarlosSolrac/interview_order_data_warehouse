CREATE TABLE [dbo].[dim_how_did_you_hear_other] (
    [dim_how_did_you_hear_other_key] INT            IDENTITY (1, 1) NOT NULL,
    [how_did_you_hear_other]         NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dim_how_did_you_hear_other] PRIMARY KEY CLUSTERED ([dim_how_did_you_hear_other_key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_how_did_you_hear_other]
    ON [dbo].[dim_how_did_you_hear_other]([how_did_you_hear_other] ASC) WHERE ([dim_how_did_you_hear_other_key]>(0));

