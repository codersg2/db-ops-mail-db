CREATE TABLE [dbo].[KeyPortName]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (200) COLLATE Latin1_General_CI_AI NOT NULL,
[Code] [nvarchar] (10) COLLATE Latin1_General_CI_AI NULL
)
GO
ALTER TABLE [dbo].[KeyPortName] ADD CONSTRAINT [PK_KeyPortName] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[KeyPortName] ADD CONSTRAINT [UQ_KeyPortName_Name] UNIQUE NONCLUSTERED ([Name])
GO
