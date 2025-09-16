SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Statistics view for attachment embeddings
CREATE VIEW [dbo].[AttachmentEmbeddingStats] AS
SELECT 
    SourceType,
    CASE 
        WHEN SourceType = 0 THEN 'RawExtractedText'
        WHEN SourceType = 1 THEN 'SummaryText'
        ELSE 'Unknown'
    END AS SourceTypeName,
    COUNT(*) AS TotalChunks,
    COUNT(CASE WHEN EmbeddingVector IS NOT NULL THEN 1 END) AS WithEmbeddings,
    COUNT(DISTINCT AttachmentId) AS UniqueAttachments,
    AVG(LEN(ChunkText)) AS AvgChunkLength,
    MIN(CreatedAt) AS FirstCreated,
    MAX(CreatedAt) AS LastCreated
FROM AttachmentEmbedding
GROUP BY SourceType;
GO
