CREATE TABLE [dbo].[EvidenceRunRequirement]
(
[RunRequirementId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__EvidenceR__RunRe__6BE40491] DEFAULT (newid()),
[RunId] [uniqueidentifier] NOT NULL,
[RequirementId] [int] NOT NULL,
[Status] [varchar] (20) COLLATE Latin1_General_CI_AI NOT NULL CONSTRAINT [DF__EvidenceR__Statu__6EC0713C] DEFAULT ('pending'),
[Notes] [nvarchar] (400) COLLATE Latin1_General_CI_AI NULL,
[AnsweredAt] [datetime2] (0) NULL
)
GO
ALTER TABLE [dbo].[EvidenceRunRequirement] ADD CONSTRAINT [PK__Evidence__55397A51F91D2BF3] PRIMARY KEY CLUSTERED ([RunRequirementId])
GO
CREATE NONCLUSTERED INDEX [IX_RunReq_Run] ON [dbo].[EvidenceRunRequirement] ([RunId])
GO
CREATE NONCLUSTERED INDEX [IX_RunReq_Status] ON [dbo].[EvidenceRunRequirement] ([Status])
GO
ALTER TABLE [dbo].[EvidenceRunRequirement] ADD CONSTRAINT [FK__EvidenceR__Requi__6DCC4D03] FOREIGN KEY ([RequirementId]) REFERENCES [dbo].[CaseTypeEvidenceRequirements] ([RequirementId])
GO
ALTER TABLE [dbo].[EvidenceRunRequirement] ADD CONSTRAINT [FK__EvidenceR__RunId__6CD828CA] FOREIGN KEY ([RunId]) REFERENCES [dbo].[EvidenceRun] ([RunId]) ON DELETE CASCADE
GO
