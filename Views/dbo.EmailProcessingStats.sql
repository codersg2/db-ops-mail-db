SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Statistics view for monitoring
CREATE VIEW [dbo].[EmailProcessingStats] AS
SELECT 
    COUNT(*) AS TotalEmails,
    SUM(CASE WHEN ProcessingFailed = 0 THEN 1 ELSE 0 END) AS SuccessfulEmails,
    SUM(CASE WHEN ProcessingFailed = 1 THEN 1 ELSE 0 END) AS FailedEmails,
    COUNT(DISTINCT VesselImo) AS UniqueVessels,
    COUNT(DISTINCT VoyageNo) AS UniqueVoyages,
    MIN(CreatedAt) AS FirstProcessed,
    MAX(CreatedAt) AS LastProcessed
FROM Email;
GO
