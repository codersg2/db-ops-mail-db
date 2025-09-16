CREATE TABLE [dbo].[EvidenceSearchPlan]
(
[PlanId] [bigint] NOT NULL IDENTITY(1, 1),
[RunRequirementId] [uniqueidentifier] NOT NULL,
[PlannerJson] [nvarchar] (max) COLLATE Latin1_General_CI_AI NOT NULL,
[ExecutedAt] [datetime2] (0) NOT NULL CONSTRAINT [DF__EvidenceS__Execu__7C1A6C5A] DEFAULT (sysutcdatetime()),
[Notes] [nvarchar] (400) COLLATE Latin1_General_CI_AI NULL
)
GO
ALTER TABLE [dbo].[EvidenceSearchPlan] ADD CONSTRAINT [PK__Evidence__755C22B777718C28] PRIMARY KEY CLUSTERED ([PlanId])
GO
ALTER TABLE [dbo].[EvidenceSearchPlan] ADD CONSTRAINT [FK__EvidenceS__RunRe__7B264821] FOREIGN KEY ([RunRequirementId]) REFERENCES [dbo].[EvidenceRunRequirement] ([RunRequirementId]) ON DELETE CASCADE
GO
