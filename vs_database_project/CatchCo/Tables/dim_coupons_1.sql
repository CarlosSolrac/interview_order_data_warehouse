CREATE TABLE [dbo].[dim_coupons] (
    [dim_coupons_key]  INT            IDENTITY (1, 1) NOT NULL,
    [coupon_code]      NVARCHAR (128) NOT NULL,
    [coupon_rule_name] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dim_coupons] PRIMARY KEY CLUSTERED ([dim_coupons_key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_dim_coupons_1]
    ON [dbo].[dim_coupons]([coupon_code] ASC, [coupon_rule_name] ASC) WHERE ([dim_coupons_key]>(0));

