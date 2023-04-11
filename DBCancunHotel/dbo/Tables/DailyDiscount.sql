CREATE TABLE [dbo].[DailyDiscount] (
    [DateDiscount] DATE            NOT NULL,
    [Adult]        DECIMAL (18, 2) NOT NULL,
    [Child]        DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [PK_DailyDiscount] PRIMARY KEY CLUSTERED ([DateDiscount] ASC)
);

