-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 06-04-2023
-- Description: Select User by Username
-- Params:  @USERNAME. Required. User Name
-- Modifications:
-- Author       Date        Description
-- John Bojaca  06-04-2023  Initial Version

CREATE PROCEDURE [dbo].[SelectUserByUsername]
    @USERNAME VARCHAR(30)
AS
BEGIN
    SELECT  Username,
            [Password],
            Email
    FROM dbo.[User] WITH(NOLOCK)
    WHERE Username = @USERNAME
END
