SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[EvidenceItemsUnified] AS
SELECT
  'email' AS SourceKind,
  e.RunId, e.RunRequirementId, e.RequirementId,
  e.EmailId AS SourceId,
  e.Title, e.Score, e.IsPrimary, e.PreviewText, e.MetadataJson, e.CollectedAt
FROM dbo.EvidenceEmailItem e
UNION ALL
SELECT
  'attachment' AS SourceKind,
  a.RunId, a.RunRequirementId, a.RequirementId,
  a.AttachmentId AS SourceId,
  a.Title, a.Score, a.IsPrimary, a.PreviewText, a.MetadataJson, a.CollectedAt
FROM dbo.EvidenceAttachmentItem a;
GO
