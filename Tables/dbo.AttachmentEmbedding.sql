CREATE TABLE [dbo].[AttachmentEmbedding]
(
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__AttachmentEm__Id__72C60C4A] DEFAULT (newid()),
[AttachmentId] [uniqueidentifier] NOT NULL,
[ChunkIndex] [int] NOT NULL,
[ChunkText] [nvarchar] (max) COLLATE Latin1_General_CI_AI NOT NULL,
[EmbeddingVector] [varbinary] (max) NULL,
[EmbedModel] [varchar] (100) COLLATE Latin1_General_CI_AI NULL,
[SourceType] [tinyint] NOT NULL CONSTRAINT [DF__Attachmen__Sourc__73BA3083] DEFAULT ((0)),
[CreatedAt] [datetime] NULL CONSTRAINT [DF__Attachmen__Creat__74AE54BC] DEFAULT (getutcdate()),
[StoredInVectorDbAtUtc] [datetime] NULL
)
GO
ALTER TABLE [dbo].[AttachmentEmbedding] ADD CONSTRAINT [PK__Attachme__3214EC0785A35011] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentEmbedding_AttachmentId] ON [dbo].[AttachmentEmbedding] ([AttachmentId])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentEmbedding_ChunkIndex] ON [dbo].[AttachmentEmbedding] ([AttachmentId], [ChunkIndex])
GO
CREATE NONCLUSTERED INDEX [IX_AttachmentEmbedding_SourceType] ON [dbo].[AttachmentEmbedding] ([AttachmentId], [SourceType])
GO
ALTER TABLE [dbo].[AttachmentEmbedding] ADD CONSTRAINT [FK_AttachmentEmbedding_Attachment] FOREIGN KEY ([AttachmentId]) REFERENCES [dbo].[Attachment] ([Id]) ON DELETE CASCADE
GO
