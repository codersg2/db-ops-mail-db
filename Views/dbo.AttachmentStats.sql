SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Attachment statistics view
CREATE VIEW [dbo].[AttachmentStats] AS
SELECT 
    DocumentType,
    COUNT(*) AS Count,
    AVG(Confidence) AS AverageConfidence,
    SUM(FileSize) / 1024.0 / 1024.0 AS TotalSizeMB
FROM Attachment
WHERE DocumentType IS NOT NULL
GROUP BY DocumentType;
GO
