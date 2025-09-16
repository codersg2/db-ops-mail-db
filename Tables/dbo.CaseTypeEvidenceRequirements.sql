CREATE TABLE [dbo].[CaseTypeEvidenceRequirements]
(
[RequirementId] [int] NOT NULL IDENTITY(1, 1),
[CaseTypeId] [int] NOT NULL,
[EvidenceLabel] [nvarchar] (150) COLLATE Latin1_General_CI_AI NOT NULL,
[Description] [nvarchar] (400) COLLATE Latin1_General_CI_AI NULL,
[OrderIndex] [int] NOT NULL CONSTRAINT [DF__CaseTypeE__Order__6166761E] DEFAULT ((0)),
[QueryHint] [nvarchar] (400) COLLATE Latin1_General_CI_AI NULL,
[NegativeHint] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL,
[SourceFilter] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL,
[PromptTemplate] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[EvidenceKind] [varchar] (20) COLLATE Latin1_General_CI_AI NOT NULL,
[IsOptional] [bit] NOT NULL CONSTRAINT [DF__CaseTypeE__IsOpt__634EBE90] DEFAULT ((0)),
[OutputSchema] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL
)
GO
ALTER TABLE [dbo].[CaseTypeEvidenceRequirements] ADD CONSTRAINT [CK_EvidenceKind] CHECK (([EvidenceKind]='information' OR [EvidenceKind]='document'))
GO
ALTER TABLE [dbo].[CaseTypeEvidenceRequirements] ADD CONSTRAINT [PK__CaseType__7DF11E5DA23C5D63] PRIMARY KEY CLUSTERED ([RequirementId])
GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_CaseType_Label] ON [dbo].[CaseTypeEvidenceRequirements] ([CaseTypeId], [EvidenceLabel])
GO
ALTER TABLE [dbo].[CaseTypeEvidenceRequirements] ADD CONSTRAINT [FK__CaseTypeE__CaseT__607251E5] FOREIGN KEY ([CaseTypeId]) REFERENCES [dbo].[CaseTypes] ([CaseTypeId])
GO
