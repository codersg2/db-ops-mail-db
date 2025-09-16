CREATE TABLE [dbo].[AttachmentContents]
(
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__AttachmentCo__Id__6E01572D] DEFAULT (newid()),
[AttachmentId] [uniqueidentifier] NOT NULL,
[RawExtractedText] [nvarchar] (max) COLLATE Latin1_General_CI_AI NOT NULL,
[SummaryText] [nvarchar] (max) COLLATE Latin1_General_CI_AI NOT NULL,
[StructuredJson] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[CreatedAt] [datetime] NULL CONSTRAINT [DF__Attachmen__Creat__6EF57B66] DEFAULT (getutcdate()),
[CleanedTextLength] AS (len(replace(replace(replace([RawExtractedText],' ',''),char((9)),''),char((10)),''))) PERSISTED
)
GO
ALTER TABLE [dbo].[AttachmentContents] ADD CONSTRAINT [PK__Attachme__3214EC071C2D3379] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentContents_AttachmentId] ON [dbo].[AttachmentContents] ([AttachmentId])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentContents_CleanedTextLength] ON [dbo].[AttachmentContents] ([CleanedTextLength])
GO
ALTER TABLE [dbo].[AttachmentContents] ADD CONSTRAINT [FK_AttachmentContents_Attachment] FOREIGN KEY ([AttachmentId]) REFERENCES [dbo].[Attachment] ([Id]) ON DELETE CASCADE
GO
