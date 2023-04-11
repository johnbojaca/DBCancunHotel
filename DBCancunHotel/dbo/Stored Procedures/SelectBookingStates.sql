-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Select Booking States
-- Params:
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[SelectBookingStates]
AS
BEGIN
    SELECT  IdStatus,
            StatusName,
            [Description]
    FROM dbo.BookingStatus WITH(NOLOCK)
END
