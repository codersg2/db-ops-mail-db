SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Update view to show attachment statistics including the new flags
CREATE   VIEW [dbo].[AttachmentKeywordProcessingStats] AS
WITH AttachmentKeywordCounts AS (
    SELECT 
        a.Id,
        a.KeywordsProcessed,
        CASE WHEN EXISTS (SELECT 1 FROM [dbo].[AttachmentKeyword] ak WHERE ak.AttachmentId = a.Id) THEN 1 ELSE 0 END AS HasKeywords
    FROM [dbo].[Attachment] a
    WHERE a.ExtractionFailed = 0
)
SELECT 
    COUNT(*) AS TotalAttachments,
    SUM(CASE WHEN KeywordsProcessed = 1 THEN 1 ELSE 0 END) AS ProcessedAttachments,
    SUM(CASE WHEN KeywordsProcessed = 0 THEN 1 ELSE 0 END) AS UnprocessedAttachments,
    SUM(CASE WHEN KeywordsProcessed = 1 AND HasKeywords = 0 THEN 1 ELSE 0 END) AS ProcessedWithNoKeywords,
    SUM(CASE WHEN KeywordsProcessed = 1 AND HasKeywords = 1 THEN 1 ELSE 0 END) AS ProcessedWithKeywords
FROM AttachmentKeywordCounts;
GO
