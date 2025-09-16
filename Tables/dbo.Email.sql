CREATE TABLE [dbo].[Email]
(
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__Email__Id__5AEE82B9] DEFAULT (newid()),
[DmsId] [bigint] NOT NULL,
[MessageId] [varchar] (500) COLLATE Latin1_General_CI_AI NULL,
[ThreadId] [varchar] (500) COLLATE Latin1_General_CI_AI NULL,
[Subject] [nvarchar] (1000) COLLATE Latin1_General_CI_AI NULL,
[FromAddress] [varchar] (500) COLLATE Latin1_General_CI_AI NULL,
[ToAddresses] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[CcAddresses] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[BccAddresses] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[SentDate] [datetime] NULL,
[ReceivedDate] [datetime] NULL,
[Direction] [int] NOT NULL,
[BodyHtml] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[BodyPlain] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[BodyPlainCleaned] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[VesselName] [varchar] (200) COLLATE Latin1_General_CI_AI NULL,
[VesselImo] [varchar] (20) COLLATE Latin1_General_CI_AI NULL,
[VoyageNo] [varchar] (50) COLLATE Latin1_General_CI_AI NULL,
[CpDate] [date] NULL,
[SummaryContext] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[SummaryModel] [varchar] (100) COLLATE Latin1_General_CI_AI NULL,
[SummaryCreatedAt] [datetime] NULL,
[ProcessingFailed] [bit] NULL CONSTRAINT [DF__Email__Processin__5BE2A6F2] DEFAULT ((0)),
[ErrorMessage] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[CreatedAt] [datetime] NULL CONSTRAINT [DF__Email__CreatedAt__5CD6CB2B] DEFAULT (getutcdate()),
[Category] [nvarchar] (80) COLLATE Latin1_General_CI_AI NULL,
[SubCategory] [nvarchar] (80) COLLATE Latin1_General_CI_AI NULL,
[KeywordsProcessed] [bit] NOT NULL CONSTRAINT [DF__Email__KeywordsP__4A4E069C] DEFAULT ((0)),
[CleanedTextLength] AS (len(replace(replace(replace([BodyPlainCleaned],' ',''),char((9)),''),char((10)),''))) PERSISTED
)
GO
ALTER TABLE [dbo].[Email] ADD CONSTRAINT [PK__Email__3214EC07D277999F] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_Email_CleanedTextLength] ON [dbo].[Email] ([CleanedTextLength])
GO
CREATE NONCLUSTERED INDEX [IX_Email_CreatedAt] ON [dbo].[Email] ([CreatedAt])
GO
CREATE NONCLUSTERED INDEX [IX_Email_DmsId] ON [dbo].[Email] ([DmsId])
GO
CREATE NONCLUSTERED INDEX [IX_Email_EmbeddingJoinCovering] ON [dbo].[Email] ([Id]) INCLUDE ([VesselName], [VesselImo], [VoyageNo], [CpDate], [SentDate], [Subject], [Direction], [Category], [SubCategory])
GO
CREATE NONCLUSTERED INDEX [IX_Email_Id_VesselVoyage] ON [dbo].[Email] ([Id], [VesselName], [VoyageNo])
GO
CREATE NONCLUSTERED INDEX [IX_Email_KeywordsProcessed] ON [dbo].[Email] ([KeywordsProcessed]) INCLUDE ([Id]) WHERE ([KeywordsProcessed]=(0) AND [ProcessingFailed]=(0))
GO
CREATE NONCLUSTERED INDEX [IX_Email_KeywordsProcessed_ProcessingFailed_CreatedAt_CleanedTextLength] ON [dbo].[Email] ([KeywordsProcessed], [ProcessingFailed], [CleanedTextLength], [CreatedAt] DESC) WHERE ([ProcessingFailed]=(0))
GO
CREATE NONCLUSTERED INDEX [IX_Email_MessageId] ON [dbo].[Email] ([MessageId])
GO
CREATE NONCLUSTERED INDEX [IX_Email_ProcessingFailed] ON [dbo].[Email] ([ProcessingFailed])
GO
CREATE NONCLUSTERED INDEX [IX_Email_DateRange] ON [dbo].[Email] ([SentDate], [ReceivedDate]) INCLUDE ([Subject], [FromAddress])
GO
CREATE NONCLUSTERED INDEX [IX_Email_ThreadId] ON [dbo].[Email] ([ThreadId])
GO
CREATE NONCLUSTERED INDEX [IX_Email_VesselImo] ON [dbo].[Email] ([VesselImo])
GO
CREATE NONCLUSTERED INDEX [IX_Email_VesselVoyage] ON [dbo].[Email] ([VesselName], [VoyageNo]) WHERE ([VesselName] IS NOT NULL AND [VoyageNo] IS NOT NULL)
GO
CREATE NONCLUSTERED INDEX [IX_Email_VesselVoyage_Category] ON [dbo].[Email] ([VesselName], [VoyageNo], [Category], [SubCategory]) INCLUDE ([Id], [SentDate])
GO
