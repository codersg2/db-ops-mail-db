CREATE TABLE [dbo].[EvidenceRun]
(
[RunId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__EvidenceR__RunId__662B2B3B] DEFAULT (newid()),
[VesselName] [varchar] (200) COLLATE Latin1_General_CI_AI NOT NULL,
[VesselImo] [varchar] (20) COLLATE Latin1_General_CI_AI NULL,
[VoyageNo] [varchar] (50) COLLATE Latin1_General_CI_AI NOT NULL,
[CaseTypeId] [int] NOT NULL,
[RequestedBy] [nvarchar] (120) COLLATE Latin1_General_CI_AI NULL,
[Status] [varchar] (20) COLLATE Latin1_General_CI_AI NOT NULL CONSTRAINT [DF__EvidenceR__Statu__681373AD] DEFAULT ('pending'),
[StartedAt] [datetime2] (0) NOT NULL CONSTRAINT [DF__EvidenceR__Start__690797E6] DEFAULT (sysutcdatetime()),
[CompletedAt] [datetime2] (0) NULL,
[ParamsJson] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL
)
GO
ALTER TABLE [dbo].[EvidenceRun] ADD CONSTRAINT [PK__Evidence__A259D4DD4013EA96] PRIMARY KEY CLUSTERED ([RunId])
GO
CREATE NONCLUSTERED INDEX [IX_EvidenceRun_Status] ON [dbo].[EvidenceRun] ([Status])
GO
CREATE NONCLUSTERED INDEX [IX_EvidenceRun_VesselVoyage] ON [dbo].[EvidenceRun] ([VesselName], [VoyageNo])
GO
ALTER TABLE [dbo].[EvidenceRun] ADD CONSTRAINT [FK__EvidenceR__CaseT__671F4F74] FOREIGN KEY ([CaseTypeId]) REFERENCES [dbo].[CaseTypes] ([CaseTypeId])
GO
