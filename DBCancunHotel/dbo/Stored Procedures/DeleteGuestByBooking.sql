-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Delete a Booking by Id Bokking
-- Params:  @ID_BOOKING. Required. Id booking
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[DeleteGuestByBooking]
    @ID_BOOKING BIGINT
AS
BEGIN
    DELETE dbo.Guest
    WHERE IdBooking = @ID_BOOKING
END
