CREATE TABLE [dbo].[BookingLog] (
    [IdBooking]  BIGINT        NOT NULL,
    [IdState]    INT           NOT NULL,
    [LogMessage] VARCHAR (MAX) NOT NULL,
    [EventDate]  DATETIME      NOT NULL,
    [Login]      VARCHAR (30)  NOT NULL,
    CONSTRAINT [FK_BookingLog_Booking] FOREIGN KEY ([IdBooking]) REFERENCES [dbo].[Booking] ([IdBooking]),
    CONSTRAINT [FK_BookingLog_BookingStatus] FOREIGN KEY ([IdState]) REFERENCES [dbo].[BookingStatus] ([IdStatus])
);


GO
CREATE CLUSTERED INDEX [Index_BookingLog]
    ON [dbo].[BookingLog]([IdBooking] ASC);

