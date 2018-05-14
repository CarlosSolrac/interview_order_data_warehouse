CREATE TABLE [default_values].[dim_coupons] (
    [dim_coupons_key]  INT            IDENTITY (1, 1) NOT NULL,
    [coupon_code]      NVARCHAR (128) NOT NULL,
    [coupon_rule_name] NVARCHAR (128) NOT NULL
);

