CREATE TABLE [dbo].[EvidenceRequirementAnswer]
(
[AnswerId] [bigint] NOT NULL IDENTITY(1, 1),
[RunRequirementId] [uniqueidentifier] NOT NULL,
[AnswerKind] [varchar] (20) COLLATE Latin1_General_CI_AI NOT NULL CONSTRAINT [DF__EvidenceR__Answe__10216507] DEFAULT ('summary'),
[AnswerText] [nvarchar] (max) COLLATE Latin1_General_CI_AI NOT NULL,
[AnswerJson] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[Model] [varchar] (100) COLLATE Latin1_General_CI_AI NOT NULL,
[Confidence] [decimal] (5, 2) NULL,
[GroundednessScore] [decimal] (5, 2) NULL,
[CreatedAt] [datetime2] (0) NOT NULL CONSTRAINT [DF__EvidenceR__Creat__11158940] DEFAULT (sysutcdatetime()),
[PromptTemplate] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL
)
GO
ALTER TABLE [dbo].[EvidenceRequirementAnswer] ADD CONSTRAINT [PK__Evidence__D48250047056C6ED] PRIMARY KEY CLUSTERED ([AnswerId])
GO
ALTER TABLE [dbo].[EvidenceRequirementAnswer] ADD CONSTRAINT [FK__EvidenceR__RunRe__0F2D40CE] FOREIGN KEY ([RunRequirementId]) REFERENCES [dbo].[EvidenceRunRequirement] ([RunRequirementId]) ON DELETE CASCADE
GO
