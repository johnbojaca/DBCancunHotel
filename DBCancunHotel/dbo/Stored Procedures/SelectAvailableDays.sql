-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Select Available Dates 
-- Params:  @ROOM_NUMBER. Required. Room Number
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[SelectAvailableDays]
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

    DECLARE @StartDate DATE = DATEADD(DAY, 1, DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())));
    DECLARE @EndDate DATE = DATEADD(DAY, 31, DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())));
    DECLARE @DATES TABLE (AvalaibleDate DATE);
    
    INSERT INTO @DATES
    SELECT  DATEADD(DAY, nbr - 1, @StartDate)
    FROM(
        SELECT ROW_NUMBER() OVER ( ORDER BY c.object_id ) AS nbr
        FROM sys.columns c
    ) nbrs
    WHERE   nbr - 1 <= DATEDIFF(DAY, @StartDate, @EndDate)
    
    DELETE D
    FROM @DATES AS D
    INNER JOIN dbo.Booking AS B WITH(NOLOCK)
        ON D.AvalaibleDate >= B.StartDate AND D.AvalaibleDate <= B.FinalDate
    WHERE  RoomNumber = @ROOM_NUMBER
    
    SELECT AvalaibleDate
    FROM @DATES
END
