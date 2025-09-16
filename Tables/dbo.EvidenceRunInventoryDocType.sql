CREATE TABLE [dbo].[EvidenceRunInventoryDocType]
(
[RunId] [uniqueidentifier] NOT NULL,
[ValidatedDocumentType] [nvarchar] (200) COLLATE Latin1_General_CI_AI NOT NULL,
[ItemCount] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[EvidenceRunInventoryDocType] ADD CONSTRAINT [PK__Evidence__19EBC7F678B2A33C] PRIMARY KEY CLUSTERED ([RunId], [ValidatedDocumentType])
GO
ALTER TABLE [dbo].[EvidenceRunInventoryDocType] ADD CONSTRAINT [FK__EvidenceR__RunId__756D6ECB] FOREIGN KEY ([RunId]) REFERENCES [dbo].[EvidenceRun] ([RunId]) ON DELETE CASCADE
GO
