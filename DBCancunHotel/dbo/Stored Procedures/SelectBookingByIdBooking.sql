-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Select Rooms
-- Params:  @ID_BOOKING. Required. Id Booking
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[SelectBookingByIdBooking]
    @ID_BOOKING BIGINT
AS
BEGIN
    SELECT  B.IdBooking,
            BS.IdStatus,
            BS.StatusName,
            BS.Description,
            R.RoomNumber,
            R.BaseValue,
            R.HasWifi,
            R.HasTV,
            R.HasBalcony,
            R.MinGuest,
            R.MaxGuest,
            R.IsActive,
            B.StartDate,
            B.FinalDate,
            B.Price
    FROM dbo.Booking AS B WITH(NOLOCK)
    INNER JOIN dbo.BookingStatus AS BS WITH(NOLOCK)
        ON B.IdStatus = BS.IdStatus
    INNER JOIN dbo.Room AS R WITH(NOLOCK)
        ON B.RoomNumber = R.RoomNumber
    WHERE B.IdBooking = @ID_BOOKING
END
