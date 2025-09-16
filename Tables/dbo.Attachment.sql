CREATE TABLE [dbo].[Attachment]
(
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Attachment__Id__5FB337D6] DEFAULT (newid()),
[EmailId] [uniqueidentifier] NOT NULL,
[Filename] [nvarchar] (500) COLLATE Latin1_General_CI_AI NOT NULL,
[FileSize] [bigint] NULL,
[ContentType] [varchar] (200) COLLATE Latin1_General_CI_AI NULL,
[DocumentType] [varchar] (100) COLLATE Latin1_General_CI_AI NULL,
[Confidence] [float] NULL,
[ValidatedDocumentType] [varchar] (100) COLLATE Latin1_General_CI_AI NULL,
[DocumentTypeConfidence] [float] NULL,
[ProcessedAt] [datetime] NULL,
[ProcessingModel] [varchar] (100) COLLATE Latin1_General_CI_AI NULL,
[ExtractionFailed] [bit] NULL CONSTRAINT [DF__Attachmen__Extra__60A75C0F] DEFAULT ((0)),
[CreatedAt] [datetime] NULL CONSTRAINT [DF__Attachmen__Creat__619B8048] DEFAULT (getutcdate()),
[KeywordsProcessed] [bit] NOT NULL CONSTRAINT [DF__Attachmen__Keywo__4B422AD5] DEFAULT ((0))
)
GO
ALTER TABLE [dbo].[Attachment] ADD CONSTRAINT [PK__Attachme__3214EC076AA331DB] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_Attachment_DocumentType] ON [dbo].[Attachment] ([DocumentType])
GO
CREATE NONCLUSTERED INDEX [IX_Attachment_EmailId] ON [dbo].[Attachment] ([EmailId])
GO
CREATE NONCLUSTERED INDEX [IX_Attachment_Unprocessed] ON [dbo].[Attachment] ([Id]) WHERE ([ValidatedDocumentType] IS NULL AND [ExtractionFailed]=(0))
GO
CREATE NONCLUSTERED INDEX [IX_Attachment_KeywordsProcessed] ON [dbo].[Attachment] ([KeywordsProcessed]) INCLUDE ([Id]) WHERE ([KeywordsProcessed]=(0) AND [ExtractionFailed]=(0))
GO
CREATE NONCLUSTERED INDEX [IX_Attachment_KeywordsProcessed_ExtractionFailed_CreatedAt] ON [dbo].[Attachment] ([KeywordsProcessed], [ExtractionFailed], [CreatedAt] DESC) INCLUDE ([EmailId], [Filename])
GO
CREATE NONCLUSTERED INDEX [IX_Attachment_DocType_VesselVoyage] ON [dbo].[Attachment] ([ValidatedDocumentType], [EmailId]) WHERE ([ValidatedDocumentType] IS NOT NULL)
GO
ALTER TABLE [dbo].[Attachment] ADD CONSTRAINT [FK_Attachment_Email] FOREIGN KEY ([EmailId]) REFERENCES [dbo].[Email] ([Id]) ON DELETE CASCADE
GO
