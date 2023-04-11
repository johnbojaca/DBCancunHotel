CREATE TABLE [dbo].[Room] (
    [RoomNumber] INT             NOT NULL,
    [BaseValue]  DECIMAL (18, 2) NOT NULL,
    [HasWifi]    BIT             NOT NULL,
    [HasTV]      BIT             NOT NULL,
    [HasBalcony] BIT             NOT NULL,
    [MinGuest]   INT             NOT NULL,
    [MaxGuest]   INT             NOT NULL,
    [IsActive]   BIT             NOT NULL,
    CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED ([RoomNumber] ASC)
);

