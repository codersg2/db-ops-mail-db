CREATE TABLE [dbo].[AttachmentCargoType]
(
[AttachmentID] [uniqueidentifier] NOT NULL,
[CargoType] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[AttachmentCargoType] ADD CONSTRAINT [PK_AttachmentCargoType] PRIMARY KEY CLUSTERED ([AttachmentID], [CargoType])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentCargoType_CargoType] ON [dbo].[AttachmentCargoType] ([CargoType])
GO
ALTER TABLE [dbo].[AttachmentCargoType] ADD CONSTRAINT [FK_AttachmentCargoType_Attachment] FOREIGN KEY ([AttachmentID]) REFERENCES [dbo].[Attachment] ([Id])
GO
ALTER TABLE [dbo].[AttachmentCargoType] ADD CONSTRAINT [FK_AttachmentCargoType_Cargo] FOREIGN KEY ([CargoType]) REFERENCES [dbo].[KeyCargoType] ([ID])
GO
