CREATE TABLE [dbo].[User] (
    [Username] VARCHAR (30)  NOT NULL,
    [Password] VARCHAR (50)  NOT NULL,
    [Email]    VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([Username] ASC)
);

