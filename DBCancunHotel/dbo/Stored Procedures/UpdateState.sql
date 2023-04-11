-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Update the State of booking
-- Params:  @ID_BOOKING. Required. Id Booking
--          @NEW_STATE. Required. New State of Booking
--          @MESSAGE. Required. Message
--          @LOGIN. Required. Message
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[UpdateState]
    @ID_BOOKING BIGINT,
    @NEW_STATE INT,
    @MESSAGE VARCHAR(MAX),
    @LOGIN VARCHAR(30)
AS
BEGIN
    DECLARE @STATE INT;
    DECLARE @ERROR VARCHAR(100);

    SELECT @STATE = IdStatus
    FROM dbo.Booking WITH(NOLOCK)
    WHERE IdBooking = @ID_BOOKING

    IF(@STATE = NULL)
    BEGIN
        SET @ERROR = CONCAT('Booking with Id: ', @ID_BOOKING, ' not exist')
        ;THROW 50007, @ERROR, 1
    END

    IF @NEW_STATE = 1
    BEGIN
        UPDATE dbo.Booking
        SET IdStatus = @NEW_STATE
        WHERE IdBooking = @ID_BOOKING
        
        INSERT INTO dbo.BookingLog
        VALUES(@ID_BOOKING, @NEW_STATE, @MESSAGE, GETDATE(), @LOGIN)
    END

    IF @NEW_STATE = 2
    BEGIN
        IF @STATE = 1
        BEGIN
            UPDATE dbo.Booking
            SET IdStatus = @NEW_STATE
            WHERE IdBooking = @ID_BOOKING

            INSERT INTO dbo.BookingLog
            VALUES(@ID_BOOKING, @NEW_STATE, 'The reservation has been paid', GETDATE(), @LOGIN)
        END
        ELSE
        BEGIN
            SET @ERROR = 'To change the status to 2, the reservation must be in status 1'
            ;THROW 50007, @ERROR, 1
        END
    END

    IF @NEW_STATE = 3
    BEGIN
        IF @STATE = 3 OR @STATE = 1
        BEGIN
            UPDATE dbo.Booking
            SET IdStatus = @NEW_STATE
            WHERE IdBooking = @ID_BOOKING

            INSERT INTO dbo.BookingLog
            VALUES(@ID_BOOKING, @NEW_STATE, @MESSAGE, GETDATE(), @LOGIN)
        END
        ELSE
        BEGIN
            SET @ERROR = 'To change the status to 3, the reservation must be in status 1 or 3'
            ;THROW 50007, @ERROR, 1
        END
    END

    IF @NEW_STATE = 4
    BEGIN
        IF @STATE = 4 OR @STATE = 2
        BEGIN
            UPDATE dbo.Booking
            SET IdStatus = @NEW_STATE
            WHERE IdBooking = @ID_BOOKING

            INSERT INTO dbo.BookingLog
            VALUES(@ID_BOOKING, @NEW_STATE, @MESSAGE, GETDATE(), @LOGIN)
        END
        ELSE
        BEGIN
            SET @ERROR = 'To change the status to 4, the reservation must be in status 2 or 4'
            ;THROW 50007, @ERROR, 1
        END
    END

    IF @NEW_STATE = 5
    BEGIN
        IF @STATE = 3 OR @STATE = 1
        BEGIN
            UPDATE dbo.Booking
            SET IdStatus = @NEW_STATE
            WHERE IdBooking = @ID_BOOKING

            INSERT INTO dbo.BookingLog
            VALUES(@ID_BOOKING, @NEW_STATE, @MESSAGE, GETDATE(), @LOGIN)
        END
        ELSE
        BEGIN
            SET @ERROR = 'To change the status to 5, the reservation must be in status 1 or 3'
            ;THROW 50007, @ERROR, 1
        END
    END

    IF @NEW_STATE = 6
    BEGIN
        IF @STATE = 4 OR @STATE = 2
        BEGIN
            UPDATE dbo.Booking
            SET IdStatus = @NEW_STATE
            WHERE IdBooking = @ID_BOOKING

            INSERT INTO dbo.BookingLog
            VALUES(@ID_BOOKING, @NEW_STATE, @MESSAGE, GETDATE(), @LOGIN)
        END
        ELSE
        BEGIN
            SET @ERROR = 'To change the status to 6, the reservation must be in status 2 or 4'
            ;THROW 50007, @ERROR, 1
        END
    END

    SELECT  BS.IdStatus,
            BS.StatusName,
            BS.[Description]
    FROM dbo.Booking AS B WITH(NOLOCK)
    INNER JOIN dbo.BookingStatus AS BS WITH(NOLOCK)
        ON B.IdStatus = BS.IdStatus
    WHERE IdBooking = @ID_BOOKING

END
