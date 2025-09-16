SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/* 10. Helper procs to save plan and answer */

CREATE   PROCEDURE [dbo].[sp_EvidenceRequirement_SavePlan]
  @RunRequirementId UNIQUEIDENTIFIER,
  @PlannerJson NVARCHAR(MAX),
  @Notes NVARCHAR(400) = NULL
AS
BEGIN
  SET NOCOUNT ON;
  INSERT dbo.EvidenceSearchPlan(RunRequirementId, PlannerJson, Notes)
  VALUES (@RunRequirementId, @PlannerJson, @Notes);

  UPDATE dbo.EvidenceRunRequirement
    SET Status = 'searching'
  WHERE RunRequirementId = @RunRequirementId;
END
GO
