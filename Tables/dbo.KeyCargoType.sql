CREATE TABLE [dbo].[KeyCargoType]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (200) COLLATE Latin1_General_CI_AI NOT NULL
)
GO
ALTER TABLE [dbo].[KeyCargoType] ADD CONSTRAINT [PK_KeyCargoType] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[KeyCargoType] ADD CONSTRAINT [UQ_KeyCargoType_Name] UNIQUE NONCLUSTERED ([Name])
GO
