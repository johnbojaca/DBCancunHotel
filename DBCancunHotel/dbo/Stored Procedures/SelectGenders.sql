-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Select Gender
-- Params:
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[SelectGenders]
AS
BEGIN
    SELECT  IdGender,
            GenderName
    FROM dbo.Gender WITH(NOLOCK)
END
