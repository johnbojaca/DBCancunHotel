CREATE TABLE [dbo].[Guest] (
    [IdBooking]      BIGINT        NOT NULL,
    [Names]          VARCHAR (100) NOT NULL,
    [Surnames]       VARCHAR (100) NOT NULL,
    [Email]          VARCHAR (100) NULL,
    [Phone]          VARCHAR (20)  NULL,
    [IdType]         INT           NOT NULL,
    [Identification] VARCHAR (50)  NOT NULL,
    [Age]            INT           NOT NULL,
    [IdGender]       INT           NOT NULL,
    CONSTRAINT [FK_Guest_Booking] FOREIGN KEY ([IdBooking]) REFERENCES [dbo].[Booking] ([IdBooking]),
    CONSTRAINT [FK_Guest_Gender] FOREIGN KEY ([IdGender]) REFERENCES [dbo].[Gender] ([IdGender]),
    CONSTRAINT [FK_Guest_IdType] FOREIGN KEY ([IdType]) REFERENCES [dbo].[IdType] ([Id])
);

