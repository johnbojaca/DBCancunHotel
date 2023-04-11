-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Update booking price
-- Params:  @ID_BOOKING. Required. Id Booking
--          @START_DATE. Required. Start date
--          @FINAL_DATE. Required. Final date
--          @ROOM_NUMBER. Required. Room Number
--          @AULTS. Required. Adults number
--          @CHILDS. Required. Childs number
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[UpdatePrice]
    @ID_BOOKING BIGINT,
    @START_DATE DATE,
    @FINAL_DATE DATE,
    @ROOM_NUMBER INT,
    @ADULTS INT,
    @CHILDS INT
AS
BEGIN
    DECLARE @PRICE DECIMAL(18,2)
    SELECT @PRICE = dbo.CalculateBookingPrice(@START_DATE, @FINAL_DATE, @ROOM_NUMBER, @ADULTS, @CHILDS)

    UPDATE dbo.Booking
    SET Price = @PRICE
    WHERE IdBooking = @ID_BOOKING

    SELECT @PRICE AS Price
END
