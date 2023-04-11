-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 06-04-2023
-- Description: Select Rooms
-- Params:  @ROOM_NUMBER. Optional. Room Number
--          @IS_ACTIVE. Optional. If Rooms is Active or not
-- Modifications:
-- Author       Date        Description
-- John Bojaca  06-04-2023  Initial Version

CREATE PROCEDURE dbo.SelectRooms
    @ROOM_NUMBER INT = NULL,
    @IS_ACTIVE BIT = NULL
AS
BEGIN
    SELECT  RoomNumber,
            BaseValue,
            HasWifi,
            HasTV,
            HasBalcony,
            MinGuest,
            MaxGuest,
            IsActive
    FROM dbo.Room WITH(NOLOCK)
    WHERE   RoomNumber = ISNULL(@ROOM_NUMBER, RoomNumber) AND
            IsActive = ISNULL(@IS_ACTIVE, IsActive)
END
