SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- View to see top keywords by frequency
CREATE   VIEW [dbo].[TopKeywords] AS
WITH KeywordCounts AS (
    SELECT 
        k.Id,
        k.Word,
        COUNT(DISTINCT ek.EmailId) AS EmailCount,
        COUNT(DISTINCT ak.AttachmentId) AS AttachmentCount
    FROM [dbo].[Keyword] k
    LEFT JOIN [dbo].[EmailKeyword] ek ON k.Id = ek.KeywordId
    LEFT JOIN [dbo].[AttachmentKeyword] ak ON k.Id = ak.Keyword
    GROUP BY k.Id, k.Word
)
SELECT 
    Word,
    EmailCount,
    AttachmentCount,
    EmailCount + AttachmentCount AS TotalUsage
FROM KeywordCounts
WHERE EmailCount > 0 OR AttachmentCount > 0;
GO
