-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 07-04-2023
-- Description: Insert a Booking
-- Params:  @START_DATE. Required. Start date
--          @FINAL_DATE. Required. Final date
--          @ROOM_NUMBER. Required. Room Number
-- Modifications:
-- Author       Date        Description
-- John Bojaca  07-04-2023  Initial Version

CREATE PROCEDURE dbo.InsertBooking
    @START_DATE DATE,
    @FINAL_DATE DATE,
    @ROOM_NUMBER INT
AS
BEGIN
    DECLARE @ERROR VARCHAR(100);
    
    -- Validate if room number exist and is active
    IF NOT EXISTS(
        SELECT RoomNumber
        FROM dbo.Room WITH(NOLOCK)
        WHERE   RoomNumber = @ROOM_NUMBER AND
                IsActive = 1)
    BEGIN
        SET @ERROR = CONCAT('Room ', @ROOM_NUMBER,  ' not exist or is inactive')
        ;THROW 50001, @ERROR, 1
    END

    -- Validate if the StartDate is less than tomorrow
    IF (@START_DATE <= GETDATE())
    BEGIN
        SET @ERROR = CONCAT('StartDate must be from ', DATEADD(DAY, 1, DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))))
        ;THROW 50002, @ERROR, 1
    END

    -- Validate if the StartDate is greater than 30 days from tomorrow
    IF (@START_DATE > DATEADD(DAY, 31, DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))))
    BEGIN
        SET @ERROR = 'You can only make reservations less than 30 days in advance'
        ;THROW 50003, @ERROR, 1
    END

    -- Validate if StartDate is greater than FinalDate
    IF (@START_DATE > @FINAL_DATE)
    BEGIN
        SET @ERROR = 'FinalDate should be great or equal to StartDate'
        ;THROW 50004, @ERROR, 1
    END

    -- Validate if date range is not greater than 3 days
    DECLARE @DIFF INT = DATEDIFF(DAY, @START_DATE, @FINAL_DATE)
    IF (@DIFF < 0 OR @DIFF > 2)
    BEGIN
        SET @ERROR = 'The reservation is for a minimum of 1 day and a maximum of 3 days'
        ;THROW 50005, @ERROR, 1
    END

    -- Validate if the room is available in the date range
    IF EXISTS (
        SELECT *
        FROM dbo.Booking WITH(NOLOCK)
        WHERE   RoomNumber = @ROOM_NUMBER AND
                (
                    (@START_DATE >= StartDate AND @START_DATE <= FinalDate) OR
                    (@FINAL_DATE >= StartDate AND @FINAL_DATE <= FinalDate)
                ))
    BEGIN
         SET @ERROR = CONCAT('Room ', @ROOM_NUMBER,  ' not available for the date range ', @START_DATE, ' and ', @FINAL_DATE)
        ;THROW 50006, @ERROR, 1
    END

    INSERT INTO dbo.Booking (IdStatus, RoomNumber, StartDate, FinalDate, Price)
    VALUES(1, @ROOM_NUMBER, @START_DATE, @FINAL_DATE, 0)
    DECLARE @ID BIGINT = SCOPE_IDENTITY()

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
    WHERE B.IdBooking = @ID

END
