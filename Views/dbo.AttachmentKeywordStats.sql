SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- View to see attachment keyword statistics
CREATE   VIEW [dbo].[AttachmentKeywordStats] AS
SELECT 
    COUNT(DISTINCT ak.AttachmentId) AS TotalAttachmentsWithKeywords,
    COUNT(DISTINCT ak.Keyword) AS UniqueKeywordsUsed,
    COUNT(*) AS TotalKeywordAssignments,
    (SELECT COUNT(*) FROM [dbo].[Attachment] WHERE Id NOT IN (SELECT DISTINCT AttachmentId FROM [dbo].[AttachmentKeyword])) AS AttachmentsWithoutKeywords
FROM [dbo].[AttachmentKeyword] ak;
GO
