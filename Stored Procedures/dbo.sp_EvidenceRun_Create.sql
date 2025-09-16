SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/* 9. Minimal helper proc: create a run, seed requirements, snapshot inventory */

CREATE   PROCEDURE [dbo].[sp_EvidenceRun_Create]
  @VesselName VARCHAR(200),
  @VesselImo  VARCHAR(20) = NULL,
  @VoyageNo   VARCHAR(50),
  @CaseTypeId INT,
  @RequestedBy NVARCHAR(120) = NULL,
  @RunId UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
  SET NOCOUNT ON;

  SET @RunId = NEWID();
  INSERT dbo.EvidenceRun(RunId, VesselName, VesselImo, VoyageNo, CaseTypeId, RequestedBy, Status)
  VALUES (@RunId, @VesselName, @VesselImo, @VoyageNo, @CaseTypeId, @RequestedBy, 'running');

  INSERT dbo.EvidenceRunRequirement(RunRequirementId, RunId, RequirementId)
  SELECT NEWID(), @RunId, r.RequirementId
  FROM dbo.CaseTypeEvidenceRequirements r
  WHERE r.CaseTypeId = @CaseTypeId;

  -- Only insert inventory if we have categories
  IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Email') AND name = 'Category')
  BEGIN
    INSERT dbo.EvidenceRunInventoryCategory(RunId, Category, SubCategory, ItemCount)
    SELECT @RunId, Category, ISNULL(SubCategory, ''), COUNT(*)
    FROM dbo.Email
    WHERE VesselName = @VesselName AND VoyageNo = @VoyageNo AND Category IS NOT NULL
    GROUP BY Category, ISNULL(SubCategory, '');
  END

  -- Only insert doc types if column exists
  IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Attachment') AND name = 'ValidatedDocumentType')
  BEGIN
    INSERT dbo.EvidenceRunInventoryDocType(RunId, ValidatedDocumentType, ItemCount)
    SELECT @RunId, a.ValidatedDocumentType, COUNT(*)
    FROM dbo.Attachment a
    JOIN dbo.Email e ON e.Id = a.EmailId
    WHERE e.VesselName = @VesselName AND e.VoyageNo = @VoyageNo
      AND a.ValidatedDocumentType IS NOT NULL
    GROUP BY a.ValidatedDocumentType;
  END
END
GO
