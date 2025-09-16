SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Statistics view for attachment contents
CREATE VIEW [dbo].[AttachmentContentsStats] AS
SELECT 
    COUNT(*) AS TotalAttachmentContents,
    COUNT(CASE WHEN StructuredJson IS NOT NULL THEN 1 END) AS WithStructuredData,
    AVG(LEN(RawExtractedText)) AS AvgRawTextLength,
    AVG(LEN(SummaryText)) AS AvgSummaryLength,
    MIN(CreatedAt) AS FirstExtracted,
    MAX(CreatedAt) AS LastExtracted
FROM AttachmentContents;

GO
