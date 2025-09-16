SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Update view to show statistics including the new flags
CREATE   VIEW [dbo].[EmailKeywordProcessingStats] AS
WITH EmailKeywordCounts AS (
    SELECT 
        e.Id,
        e.KeywordsProcessed,
        CASE WHEN EXISTS (SELECT 1 FROM [dbo].[EmailKeyword] ek WHERE ek.EmailId = e.Id) THEN 1 ELSE 0 END AS HasKeywords
    FROM [dbo].[Email] e
    WHERE e.ProcessingFailed = 0
)
SELECT 
    COUNT(*) AS TotalEmails,
    SUM(CASE WHEN KeywordsProcessed = 1 THEN 1 ELSE 0 END) AS ProcessedEmails,
    SUM(CASE WHEN KeywordsProcessed = 0 THEN 1 ELSE 0 END) AS UnprocessedEmails,
    SUM(CASE WHEN KeywordsProcessed = 1 AND HasKeywords = 0 THEN 1 ELSE 0 END) AS ProcessedWithNoKeywords,
    SUM(CASE WHEN KeywordsProcessed = 1 AND HasKeywords = 1 THEN 1 ELSE 0 END) AS ProcessedWithKeywords
FROM EmailKeywordCounts;
GO
