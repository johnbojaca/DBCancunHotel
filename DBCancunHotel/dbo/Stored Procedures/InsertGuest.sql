-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 07-04-2023
-- Description: Insert a Booking
-- Params:  @ID_BOOKING. Required. Id booking
--          @NAMES. Required. Names
--          @SURNAMES. Required. Surnames
--          @EMAIL. Optional. Email
--          @PHONE. Optiona. Phone number
--          @ID_TYPE. Required. Identification Type
--          @IDENTIFICATION. Required. Identification
--          @AGE. Required. Age
--          @ID_GENDER. Required. Id Gender
-- Modifications:
-- Author       Date        Description
-- John Bojaca  07-04-2023  Initial Version

CREATE PROCEDURE [dbo].[InsertGuest]
    @ID_BOOKING BIGINT,
    @NAMES VARCHAR(100),
    @SURNAMES VARCHAR(100),
    @EMAIL VARCHAR(100) = NULL,
    @PHONE VARCHAR(20) = NULL,
    @ID_TYPE INT,
    @IDENTIFICATION VARCHAR(50),
    @AGE INT,
    @ID_GENDER INT
AS
BEGIN
    DECLARE @ERROR VARCHAR(100);
    
    -- Validate if id booking exist
    IF NOT EXISTS(
        SELECT IdBooking
        FROM dbo.Booking WITH(NOLOCK)
        WHERE   IdBooking = @ID_BOOKING)
    BEGIN
        SET @ERROR = CONCAT('Booking ', @ID_BOOKING,  ' not exist')
        ;THROW 50001, @ERROR, 1
    END

    -- Validate if the Identification Type exist
    IF NOT EXISTS(
        SELECT Id
        FROM dbo.IdType WITH(NOLOCK)
        WHERE Id = @ID_TYPE)
    BEGIN
        SET @ERROR = CONCAT('IdType ', @ID_TYPE,  ' not exist')
        ;THROW 50001, @ERROR, 1
    END

    -- Validate if the Id Gender exist
    IF NOT EXISTS(
        SELECT IdGender
        FROM dbo.Gender WITH(NOLOCK)
        WHERE   IdGender = @ID_GENDER)
    BEGIN
        SET @ERROR = CONCAT('IdType ', @ID_TYPE,  ' not exist')
        ;THROW 50001, @ERROR, 1
    END

    INSERT INTO dbo.Guest (IdBooking, Names, Surnames, Email, Phone, IdType, Identification, Age, IdGender)
    VALUES(@ID_BOOKING, @NAMES, @SURNAMES, @EMAIL, @PHONE, @ID_TYPE, @IDENTIFICATION, @AGE, @ID_GENDER)

    SELECT  @ID_BOOKING AS IdBooking,
            @NAMES AS Names,
            @SURNAMES AS Surnames,
            @EMAIL AS Email,
            @PHONE AS Phone,
            B.Id,
            B.IdTypeName,
            B.Acronym,
            @IDENTIFICATION AS Identification,
            @AGE AS Age,
            GE.IdGender,
            GE.GenderName
    FROM dbo.IdType AS B, dbo.Gender AS GE WITH(NOLOCK)
    WHERE B.Id = @ID_TYPE AND GE.IdGender = @ID_GENDER

END
