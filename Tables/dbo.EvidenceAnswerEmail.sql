CREATE TABLE [dbo].[EvidenceAnswerEmail]
(
[AnswerId] [bigint] NOT NULL,
[EvidenceEmailItemId] [bigint] NOT NULL,
[IsCited] [bit] NOT NULL CONSTRAINT [DF__EvidenceA__IsCit__2DB1C7EE] DEFAULT ((1))
)
GO
ALTER TABLE [dbo].[EvidenceAnswerEmail] ADD CONSTRAINT [PK__Evidence__A50FAD6C1F35E7F2] PRIMARY KEY CLUSTERED ([AnswerId], [EvidenceEmailItemId])
GO
ALTER TABLE [dbo].[EvidenceAnswerEmail] ADD CONSTRAINT [FK__EvidenceA__Evide__2CBDA3B5] FOREIGN KEY ([EvidenceEmailItemId]) REFERENCES [dbo].[EvidenceEmailItem] ([EvidenceEmailItemId])
GO
ALTER TABLE [dbo].[EvidenceAnswerEmail] ADD CONSTRAINT [FK__EvidenceA__Answe__2BC97F7C] FOREIGN KEY ([AnswerId]) REFERENCES [dbo].[EvidenceRequirementAnswer] ([AnswerId]) ON DELETE CASCADE
GO
