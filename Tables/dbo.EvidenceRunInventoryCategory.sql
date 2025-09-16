CREATE TABLE [dbo].[EvidenceRunInventoryCategory]
(
[RunId] [uniqueidentifier] NOT NULL,
[Category] [nvarchar] (100) COLLATE Latin1_General_CI_AI NOT NULL,
[SubCategory] [nvarchar] (200) COLLATE Latin1_General_CI_AI NOT NULL CONSTRAINT [DF__EvidenceR__SubCa__72910220] DEFAULT (''),
[ItemCount] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[EvidenceRunInventoryCategory] ADD CONSTRAINT [PK__Evidence__A7B0D8CBFBEBC491] PRIMARY KEY CLUSTERED ([RunId], [Category], [SubCategory])
GO
ALTER TABLE [dbo].[EvidenceRunInventoryCategory] ADD CONSTRAINT [FK__EvidenceR__RunId__719CDDE7] FOREIGN KEY ([RunId]) REFERENCES [dbo].[EvidenceRun] ([RunId]) ON DELETE CASCADE
GO
