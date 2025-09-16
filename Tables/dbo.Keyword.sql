CREATE TABLE [dbo].[Keyword]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Word] [nvarchar] (250) COLLATE Latin1_General_CI_AI NOT NULL
)
GO
ALTER TABLE [dbo].[Keyword] ADD CONSTRAINT [PK_Keyword] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Keyword_Word] ON [dbo].[Keyword] ([Word])
GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Keyword_Word] ON [dbo].[Keyword] ([Word])
GO
