CREATE TABLE [dbo].[AttachmentPortName]
(
[AttachmentID] [uniqueidentifier] NOT NULL,
[PortName] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[AttachmentPortName] ADD CONSTRAINT [PK_AttachmentPortName] PRIMARY KEY CLUSTERED ([AttachmentID], [PortName])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentPortName_PortName] ON [dbo].[AttachmentPortName] ([PortName])
GO
ALTER TABLE [dbo].[AttachmentPortName] ADD CONSTRAINT [FK_AttachmentPortName_Attachment] FOREIGN KEY ([AttachmentID]) REFERENCES [dbo].[Attachment] ([Id])
GO
ALTER TABLE [dbo].[AttachmentPortName] ADD CONSTRAINT [FK_AttachmentPortName_Port] FOREIGN KEY ([PortName]) REFERENCES [dbo].[KeyPortName] ([ID])
GO
