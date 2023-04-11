-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 10-04-2023
-- Description: Select the booking Log
-- Params:  @ID_BOOKING. Required. Id Booking
-- Modifications:
-- Author       Date        Description
-- John Bojaca  10-04-2023  Initial Version

CREATE PROCEDURE [dbo].[SelectBookingLogs]
    @ID_BOOKING BIGINT
AS
BEGIN
    SELECT  BL.IdBooking,
            BS.IdStatus,
            BS.StatusName,
            BS.[Description],
            BL.LogMessage,
            BL.EventDate
    FROM dbo.BookingLog AS BL WITH(NOLOCK)
    INNER JOIN dbo.BookingStatus AS BS WITH(NOLOCK)
        ON BL.IdState = BS.IdStatus
    WHERE BL.IdBooking = @ID_BOOKING
END
