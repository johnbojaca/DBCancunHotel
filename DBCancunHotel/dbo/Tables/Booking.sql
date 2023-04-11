CREATE TABLE [dbo].[Booking] (
    [IdBooking]  BIGINT          IDENTITY (1, 1) NOT NULL,
    [IdStatus]   INT             NOT NULL,
    [RoomNumber] INT             NOT NULL,
    [StartDate]  DATE            NOT NULL,
    [FinalDate]  DATE            NOT NULL,
    [Price]      DECIMAL (18, 2) NOT NULL,
    CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED ([IdBooking] ASC),
    CONSTRAINT [FK_Booking_BookingStatus] FOREIGN KEY ([IdStatus]) REFERENCES [dbo].[BookingStatus] ([IdStatus]),
    CONSTRAINT [FK_Booking_Room] FOREIGN KEY ([RoomNumber]) REFERENCES [dbo].[Room] ([RoomNumber])
);

