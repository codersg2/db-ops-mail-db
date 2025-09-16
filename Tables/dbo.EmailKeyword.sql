CREATE TABLE [dbo].[EmailKeyword]
(
[EmailID] [uniqueidentifier] NOT NULL,
[KeywordID] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[EmailKeyword] ADD CONSTRAINT [PK_EmailKeyword] PRIMARY KEY CLUSTERED ([EmailID], [KeywordID])
GO
CREATE NONCLUSTERED INDEX [IX_EmailKeyword_KeywordId] ON [dbo].[EmailKeyword] ([KeywordID])
GO
