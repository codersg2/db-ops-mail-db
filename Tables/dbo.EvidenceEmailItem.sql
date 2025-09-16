CREATE TABLE [dbo].[EvidenceEmailItem]
(
[EvidenceEmailItemId] [bigint] NOT NULL IDENTITY(1, 1),
[RunId] [uniqueidentifier] NOT NULL,
[RunRequirementId] [uniqueidentifier] NULL,
[RequirementId] [int] NULL,
[EmailId] [uniqueidentifier] NOT NULL,
[Title] [nvarchar] (300) COLLATE Latin1_General_CI_AI NULL,
[Score] [decimal] (6, 3) NULL,
[IsPrimary] [bit] NOT NULL CONSTRAINT [DF__EvidenceE__IsPri__02C769E9] DEFAULT ((0)),
[PreviewText] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[MetadataJson] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[CollectedAt] [datetime2] (0) NOT NULL CONSTRAINT [DF__EvidenceE__Colle__03BB8E22] DEFAULT (sysutcdatetime())
)
GO
ALTER TABLE [dbo].[EvidenceEmailItem] ADD CONSTRAINT [PK__Evidence__18DFD6868D07CEE3] PRIMARY KEY CLUSTERED ([EvidenceEmailItemId])
GO
CREATE NONCLUSTERED INDEX [IX_EvEmail_Email] ON [dbo].[EvidenceEmailItem] ([EmailId])
GO
CREATE NONCLUSTERED INDEX [IX_EvEmail_Run] ON [dbo].[EvidenceEmailItem] ([RunId])
GO
CREATE NONCLUSTERED INDEX [IX_EvEmail_RunReq] ON [dbo].[EvidenceEmailItem] ([RunRequirementId])
GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_EvEmail_PrimaryOne] ON [dbo].[EvidenceEmailItem] ([RunRequirementId], [IsPrimary]) WHERE ([IsPrimary]=(1) AND [RunRequirementId] IS NOT NULL)
GO
ALTER TABLE [dbo].[EvidenceEmailItem] ADD CONSTRAINT [FK__EvidenceE__Requi__00DF2177] FOREIGN KEY ([RequirementId]) REFERENCES [dbo].[CaseTypeEvidenceRequirements] ([RequirementId])
GO
ALTER TABLE [dbo].[EvidenceEmailItem] ADD CONSTRAINT [FK__EvidenceE__Email__01D345B0] FOREIGN KEY ([EmailId]) REFERENCES [dbo].[Email] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EvidenceEmailItem] ADD CONSTRAINT [FK__EvidenceE__RunId__7EF6D905] FOREIGN KEY ([RunId]) REFERENCES [dbo].[EvidenceRun] ([RunId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EvidenceEmailItem] ADD CONSTRAINT [FK__EvidenceE__RunRe__7FEAFD3E] FOREIGN KEY ([RunRequirementId]) REFERENCES [dbo].[EvidenceRunRequirement] ([RunRequirementId])
GO
