-- Project: Hotel Cancun
-- Author: John Bojaca
-- Date: 09-04-2023
-- Description: Select Identification Types
-- Params:
-- Modifications:
-- Author       Date        Description
-- John Bojaca  09-04-2023  Initial Version

CREATE PROCEDURE [dbo].[SelectIdTypes]
AS
BEGIN
    SELECT  Id,
            IdTypeName,
            Acronym
    FROM [dbo].[IdType] WITH(NOLOCK)
END
