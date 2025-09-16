CREATE TABLE [dbo].[EvidenceAttachmentItem]
(
[EvidenceAttachmentItemId] [bigint] NOT NULL IDENTITY(1, 1),
[RunId] [uniqueidentifier] NOT NULL,
[RunRequirementId] [uniqueidentifier] NULL,
[RequirementId] [int] NULL,
[AttachmentId] [uniqueidentifier] NOT NULL,
[Title] [nvarchar] (300) COLLATE Latin1_General_CI_AI NULL,
[Score] [decimal] (6, 3) NULL,
[IsPrimary] [bit] NOT NULL CONSTRAINT [DF__EvidenceA__IsPri__0A688BB1] DEFAULT ((0)),
[PreviewText] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[MetadataJson] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[CollectedAt] [datetime2] (0) NOT NULL CONSTRAINT [DF__EvidenceA__Colle__0B5CAFEA] DEFAULT (sysutcdatetime())
)
GO
ALTER TABLE [dbo].[EvidenceAttachmentItem] ADD CONSTRAINT [PK__Evidence__3B750BC3C2869A06] PRIMARY KEY CLUSTERED ([EvidenceAttachmentItemId])
GO
CREATE NONCLUSTERED INDEX [IX_EvAtt_Att] ON [dbo].[EvidenceAttachmentItem] ([AttachmentId])
GO
CREATE NONCLUSTERED INDEX [IX_EvAtt_Run] ON [dbo].[EvidenceAttachmentItem] ([RunId])
GO
CREATE NONCLUSTERED INDEX [IX_EvAtt_RunReq] ON [dbo].[EvidenceAttachmentItem] ([RunRequirementId])
GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_EvAtt_PrimaryOne] ON [dbo].[EvidenceAttachmentItem] ([RunRequirementId], [IsPrimary]) WHERE ([IsPrimary]=(1) AND [RunRequirementId] IS NOT NULL)
GO
ALTER TABLE [dbo].[EvidenceAttachmentItem] ADD CONSTRAINT [FK__EvidenceA__Attac__09746778] FOREIGN KEY ([AttachmentId]) REFERENCES [dbo].[Attachment] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EvidenceAttachmentItem] ADD CONSTRAINT [FK__EvidenceA__Requi__0880433F] FOREIGN KEY ([RequirementId]) REFERENCES [dbo].[CaseTypeEvidenceRequirements] ([RequirementId])
GO
ALTER TABLE [dbo].[EvidenceAttachmentItem] ADD CONSTRAINT [FK__EvidenceA__RunId__0697FACD] FOREIGN KEY ([RunId]) REFERENCES [dbo].[EvidenceRun] ([RunId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EvidenceAttachmentItem] ADD CONSTRAINT [FK__EvidenceA__RunRe__078C1F06] FOREIGN KEY ([RunRequirementId]) REFERENCES [dbo].[EvidenceRunRequirement] ([RunRequirementId])
GO
