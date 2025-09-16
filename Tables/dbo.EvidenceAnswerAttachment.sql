CREATE TABLE [dbo].[EvidenceAnswerAttachment]
(
[AnswerId] [bigint] NOT NULL,
[EvidenceAttachmentItemId] [bigint] NOT NULL,
[IsCited] [bit] NOT NULL CONSTRAINT [DF__EvidenceA__IsCit__32767D0B] DEFAULT ((1))
)
GO
ALTER TABLE [dbo].[EvidenceAnswerAttachment] ADD CONSTRAINT [PK__Evidence__F73500B87FD9EA06] PRIMARY KEY CLUSTERED ([AnswerId], [EvidenceAttachmentItemId])
GO
ALTER TABLE [dbo].[EvidenceAnswerAttachment] ADD CONSTRAINT [FK__EvidenceA__Evide__318258D2] FOREIGN KEY ([EvidenceAttachmentItemId]) REFERENCES [dbo].[EvidenceAttachmentItem] ([EvidenceAttachmentItemId])
GO
ALTER TABLE [dbo].[EvidenceAnswerAttachment] ADD CONSTRAINT [FK__EvidenceA__Answe__308E3499] FOREIGN KEY ([AnswerId]) REFERENCES [dbo].[EvidenceRequirementAnswer] ([AnswerId]) ON DELETE CASCADE
GO
