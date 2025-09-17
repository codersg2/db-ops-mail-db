CREATE TABLE [dbo].[ExtractionQualityMetrics]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[AttachmentId] [uniqueidentifier] NOT NULL,
[ExtractionMethod] [nvarchar] (50) COLLATE Latin1_General_CI_AI NOT NULL,
[ModelName] [nvarchar] (100) COLLATE Latin1_General_CI_AI NULL,
[QualityScore] [decimal] (5, 2) NOT NULL,
[TextLength] [int] NOT NULL,
[ProcessingTimeMs] [int] NOT NULL,
[MemoryUsageMB] [decimal] (8, 2) NULL,
[SuccessfulExtraction] [bit] NOT NULL CONSTRAINT [DF__Extractio__Succe__2D7CBDC4] DEFAULT ((1)),
[ErrorMessage] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[ReadabilityScore] [decimal] (5, 2) NULL,
[Completeness] [decimal] (5, 2) NULL,
[AccuracyEstimate] [decimal] (5, 2) NULL,
[StructurePreservation] [decimal] (5, 2) NULL,
[WordCount] [int] NULL,
[SentenceCount] [int] NULL,
[ParagraphCount] [int] NULL,
[TableCount] [int] NULL,
[HasNumbers] [bit] NULL,
[HasStructuredData] [bit] NULL,
[ContainsSignatures] [bit] NULL,
[ContainsLogos] [bit] NULL,
[CharacterConfidence] [decimal] (5, 2) NULL,
[OcrArtifacts] [int] NULL,
[MixedCaseIssues] [int] NULL,
[CharacterSubstitutions] [int] NULL,
[BrokenWords] [int] NULL,
[MaritimeTermCount] [int] NULL,
[VesselMentions] [int] NULL,
[PortMentions] [int] NULL,
[DateMentions] [int] NULL,
[NumericDataPoints] [int] NULL,
[PrimaryMethod] [bit] NULL,
[FallbackReason] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL,
[ComparedToMethod] [nvarchar] (50) COLLATE Latin1_General_CI_AI NULL,
[BetterThanAlternative] [bit] NULL,
[CreatedAt] [datetime2] NOT NULL CONSTRAINT [DF__Extractio__Creat__2E70E1FD] DEFAULT (getutcdate()),
[FileSize] [bigint] NULL,
[FileExtension] [nvarchar] (10) COLLATE Latin1_General_CI_AI NULL,
[PageCount] [int] NULL,
[DocumentType] [nvarchar] (100) COLLATE Latin1_General_CI_AI NULL,
[ServerName] [nvarchar] (100) COLLATE Latin1_General_CI_AI NULL,
[ConcurrentExtractions] [int] NULL,
[RetryAttempt] [int] NULL,
[TotalAttempts] [int] NULL,
[QualityDetails] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[ExtractionDetails] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL
)
GO
ALTER TABLE [dbo].[ExtractionQualityMetrics] ADD CONSTRAINT [CK_AccuracyEstimate] CHECK (([AccuracyEstimate] IS NULL OR [AccuracyEstimate]>=(0) AND [AccuracyEstimate]<=(100)))
GO
ALTER TABLE [dbo].[ExtractionQualityMetrics] ADD CONSTRAINT [CK_CharacterConfidence] CHECK (([CharacterConfidence] IS NULL OR [CharacterConfidence]>=(0) AND [CharacterConfidence]<=(100)))
GO
ALTER TABLE [dbo].[ExtractionQualityMetrics] ADD CONSTRAINT [CK_Completeness] CHECK (([Completeness] IS NULL OR [Completeness]>=(0) AND [Completeness]<=(100)))
GO
ALTER TABLE [dbo].[ExtractionQualityMetrics] ADD CONSTRAINT [CK_QualityScore] CHECK (([QualityScore]>=(0) AND [QualityScore]<=(100)))
GO
ALTER TABLE [dbo].[ExtractionQualityMetrics] ADD CONSTRAINT [CK_ReadabilityScore] CHECK (([ReadabilityScore] IS NULL OR [ReadabilityScore]>=(0) AND [ReadabilityScore]<=(100)))
GO
ALTER TABLE [dbo].[ExtractionQualityMetrics] ADD CONSTRAINT [CK_StructurePreservation] CHECK (([StructurePreservation] IS NULL OR [StructurePreservation]>=(0) AND [StructurePreservation]<=(100)))
GO
ALTER TABLE [dbo].[ExtractionQualityMetrics] ADD CONSTRAINT [PK__Extracti__3214EC0702EE63A7] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_ExtractionQualityMetrics_AttachmentId] ON [dbo].[ExtractionQualityMetrics] ([AttachmentId])
GO
CREATE NONCLUSTERED INDEX [IX_ExtractionQualityMetrics_CreatedAt] ON [dbo].[ExtractionQualityMetrics] ([CreatedAt])
GO
CREATE NONCLUSTERED INDEX [IX_ExtractionQualityMetrics_ExtractionMethod] ON [dbo].[ExtractionQualityMetrics] ([ExtractionMethod])
GO
CREATE NONCLUSTERED INDEX [IX_ExtractionQualityMetrics_Method_Quality] ON [dbo].[ExtractionQualityMetrics] ([ExtractionMethod], [QualityScore])
GO
CREATE NONCLUSTERED INDEX [IX_ExtractionQualityMetrics_QualityScore] ON [dbo].[ExtractionQualityMetrics] ([QualityScore])
GO
ALTER TABLE [dbo].[ExtractionQualityMetrics] ADD CONSTRAINT [FK_ExtractionQualityMetrics_AttachmentId] FOREIGN KEY ([AttachmentId]) REFERENCES [dbo].[Attachment] ([Id]) ON DELETE CASCADE
GO
