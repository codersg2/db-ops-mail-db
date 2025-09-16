SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- View to see email keyword statistics
CREATE   VIEW [dbo].[EmailKeywordStats] AS
SELECT 
    COUNT(DISTINCT ek.EmailId) AS TotalEmailsWithKeywords,
    COUNT(DISTINCT ek.KeywordId) AS UniqueKeywordsUsed,
    COUNT(*) AS TotalKeywordAssignments,
    (SELECT COUNT(*) FROM [dbo].[Email] WHERE Id NOT IN (SELECT DISTINCT EmailId FROM [dbo].[EmailKeyword])) AS EmailsWithoutKeywords
FROM [dbo].[EmailKeyword] ek;
GO
