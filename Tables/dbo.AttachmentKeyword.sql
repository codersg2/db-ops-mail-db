CREATE TABLE [dbo].[AttachmentKeyword]
(
[AttachmentID] [uniqueidentifier] NOT NULL,
[Keyword] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[AttachmentKeyword] ADD CONSTRAINT [PK_AttachmentKeyword] PRIMARY KEY CLUSTERED ([AttachmentID], [Keyword])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentKeyword_AttachmentId] ON [dbo].[AttachmentKeyword] ([AttachmentID])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentKeyword_Keyword] ON [dbo].[AttachmentKeyword] ([Keyword])
GO
