CREATE TABLE [dbo].[BookingStatus] (
    [IdStatus]    INT           NOT NULL,
    [StatusName]  VARCHAR (20)  NOT NULL,
    [Description] VARCHAR (200) NOT NULL,
    [Login]       VARCHAR (30)  CONSTRAINT [DEFAULT_BookingStatus_Login] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_BookingStatus] PRIMARY KEY CLUSTERED ([IdStatus] ASC)
);

