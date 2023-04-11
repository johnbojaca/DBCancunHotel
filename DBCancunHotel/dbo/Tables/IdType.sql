CREATE TABLE [dbo].[IdType] (
    [Id]         INT          NOT NULL,
    [IdTypeName] VARCHAR (30) NOT NULL,
    [Acronym]    VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_IdType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

