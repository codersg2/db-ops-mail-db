CREATE TABLE [dbo].[Embedding]
(
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Embedding__Id__656C112C] DEFAULT (newid()),
[EmailId] [uniqueidentifier] NOT NULL,
[ChunkIndex] [int] NOT NULL,
[ChunkText] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[EmbeddingVector] [varbinary] (max) NULL,
[EmbedModel] [varchar] (100) COLLATE Latin1_General_CI_AI NULL,
[SourceType] [tinyint] NOT NULL CONSTRAINT [DF__Embedding__Sourc__66603565] DEFAULT ((0)),
[CreatedAt] [datetime] NULL CONSTRAINT [DF__Embedding__Creat__6754599E] DEFAULT (getutcdate()),
[StoredInVectorDbAtUtc] [datetime] NULL
)
GO
ALTER TABLE [dbo].[Embedding] ADD CONSTRAINT [PK__Embeddin__3214EC07DF98E511] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_Embedding_EmailId] ON [dbo].[Embedding] ([EmailId])
GO
CREATE NONCLUSTERED INDEX [IX_Embedding_ChunkIndex] ON [dbo].[Embedding] ([EmailId], [ChunkIndex])
GO
CREATE NONCLUSTERED INDEX [IX_Embedding_SourceType] ON [dbo].[Embedding] ([EmailId], [SourceType])
GO
CREATE NONCLUSTERED INDEX [IX_Embedding_StoredInVectorDbAtUtc_Covering] ON [dbo].[Embedding] ([StoredInVectorDbAtUtc]) INCLUDE ([Id], [EmailId], [SourceType], [ChunkIndex], [CreatedAt]) WHERE ([StoredInVectorDbAtUtc] IS NULL)
GO
CREATE NONCLUSTERED INDEX [IX_Embedding_UnstoredOrderedRetrieval] ON [dbo].[Embedding] ([StoredInVectorDbAtUtc], [CreatedAt], [EmailId], [ChunkIndex]) INCLUDE ([Id], [SourceType]) WHERE ([StoredInVectorDbAtUtc] IS NULL AND [EmbeddingVector] IS NOT NULL)
GO
CREATE NONCLUSTERED INDEX [IX_Embedding_StoredInVectorDbAtUtc_SourceType] ON [dbo].[Embedding] ([StoredInVectorDbAtUtc], [SourceType]) INCLUDE ([Id], [EmailId], [ChunkIndex], [CreatedAt]) WHERE ([StoredInVectorDbAtUtc] IS NULL)
GO
CREATE NONCLUSTERED INDEX [IX_Embedding_UnstoredOrderedRetrieval_SourceType] ON [dbo].[Embedding] ([StoredInVectorDbAtUtc], [SourceType], [CreatedAt], [EmailId], [ChunkIndex]) INCLUDE ([Id]) WHERE ([StoredInVectorDbAtUtc] IS NULL AND [EmbeddingVector] IS NOT NULL)
GO
ALTER TABLE [dbo].[Embedding] ADD CONSTRAINT [FK_Embedding_Email] FOREIGN KEY ([EmailId]) REFERENCES [dbo].[Email] ([Id]) ON DELETE CASCADE
GO
