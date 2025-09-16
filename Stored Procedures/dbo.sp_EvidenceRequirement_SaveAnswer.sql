SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   PROCEDURE [dbo].[sp_EvidenceRequirement_SaveAnswer]
  @RunRequirementId UNIQUEIDENTIFIER,
  @AnswerText NVARCHAR(MAX),
  @AnswerJson NVARCHAR(MAX) = NULL,
  @Model VARCHAR(100),
  @Confidence DECIMAL(5,2) = NULL,
  @GroundednessScore DECIMAL(5,2) = NULL,
  @PromptTemplate NVARCHAR(MAX) = NULL
AS
BEGIN
  SET NOCOUNT ON;

  INSERT dbo.EvidenceRequirementAnswer
    (RunRequirementId, AnswerText, AnswerJson, Model, Confidence, GroundednessScore, PromptTemplate)
  VALUES
    (@RunRequirementId, @AnswerText, @AnswerJson, @Model, @Confidence, @GroundednessScore, @PromptTemplate);

  UPDATE dbo.EvidenceRunRequirement
    SET Status = CASE WHEN Status IN ('missing','failed') THEN Status ELSE 'found' END,
        AnsweredAt = SYSUTCDATETIME()
  WHERE RunRequirementId = @RunRequirementId;
END
GO
