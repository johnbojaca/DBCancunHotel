-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Select Guest by Id booking or Identification
-- Params:  @ID_BOOKING. Optional. Id Booking
--          @ID_TYPE. Optional. Guest Id Type
--          @IDENTIFICATION. Optional. Guest Identification
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[SelectGuests]
    @ID_BOOKING BIGINT = NULL,
    @ID_TYPE INT = NULL,
    @IDENTIFICATION VARCHAR(50) = NULL
AS
BEGIN
    SELECT  G.IdBooking AS IdBooking,
            G.Names,
            G.Surnames,
            G.Email,
            G.Phone,
            IDT.Id,
            IDT.IdTypeName,
            IDT.Acronym,
            G.Identification,
            G.Age,
            GE.IdGender,
            GE.GenderName
    FROM dbo.Guest AS G WITH(NOLOCK)
    INNER JOIN dbo.IdType AS IDT WITH(NOLOCK)
        ON G.IdType = IDT.Id
    INNER JOIN dbo.Gender AS GE WITH(NOLOCK)
        ON G.IdGender = GE.IdGender
    WHERE   G.IdBooking = ISNULL(@ID_BOOKING, G.IdBooking) AND
            G.IdType = ISNULL(@ID_TYPE, G.IdType) AND
            G.Identification = ISNULL(@IDENTIFICATION, G.Identification)
END
