SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[EvidenceAnswersUnified] AS
SELECT a.AnswerId, r.RunId, a.RunRequirementId, a.AnswerKind,
       a.AnswerText, a.Model, a.Confidence, a.GroundednessScore, a.CreatedAt
FROM dbo.EvidenceRequirementAnswer a
JOIN dbo.EvidenceRunRequirement rr ON rr.RunRequirementId = a.RunRequirementId
JOIN dbo.EvidenceRun r ON r.RunId = rr.RunId;
GO
