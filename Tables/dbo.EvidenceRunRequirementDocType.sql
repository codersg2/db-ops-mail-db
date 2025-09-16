CREATE TABLE [dbo].[EvidenceRunRequirementDocType]
(
[RunRequirementId] [uniqueidentifier] NOT NULL,
[ValidatedDocumentType] [nvarchar] (200) COLLATE Latin1_General_CI_AI NOT NULL,
[SelectionConfidence] [decimal] (5, 2) NULL,
[Rationale] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL
)
GO
ALTER TABLE [dbo].[EvidenceRunRequirementDocType] ADD CONSTRAINT [PK__Evidence__EE8B697A1504FAAD] PRIMARY KEY CLUSTERED ([RunRequirementId], [ValidatedDocumentType])
GO
ALTER TABLE [dbo].[EvidenceRunRequirementDocType] ADD CONSTRAINT [FK__EvidenceR__RunRe__7849DB76] FOREIGN KEY ([RunRequirementId]) REFERENCES [dbo].[EvidenceRunRequirement] ([RunRequirementId]) ON DELETE CASCADE
GO
