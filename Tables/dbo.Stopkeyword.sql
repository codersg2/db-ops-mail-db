CREATE TABLE [dbo].[Stopkeyword]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Word] [nvarchar] (250) COLLATE Latin1_General_CI_AI NOT NULL
)
GO
ALTER TABLE [dbo].[Stopkeyword] ADD CONSTRAINT [PK_Stopkeyword] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Stopkeyword_Word] ON [dbo].[Stopkeyword] ([Id])
GO
