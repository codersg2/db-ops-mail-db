SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Create a similar procedure for attachments
CREATE   PROCEDURE [dbo].[AddAttachmentKeywordsBatch]
    @AttachmentId uniqueidentifier,
    @Keywords [dbo].[KeywordListType] READONLY
AS
BEGIN
    SET NOCOUNT ON;
    -- Explicitly do NOT use XACT_ABORT or transactions
    
    -- First, insert any new keywords into the Keyword table
    -- Use MERGE to handle concurrent inserts gracefully
    MERGE [dbo].[Keyword] AS target
    USING (SELECT DISTINCT Word FROM @Keywords) AS source
    ON target.Word = source.Word
    WHEN NOT MATCHED THEN
        INSERT (Word) VALUES (source.Word);
    
    -- Now insert the attachment-keyword relationships
    -- Use LEFT JOIN to only insert missing relationships
    INSERT INTO [dbo].[AttachmentKeyword] (AttachmentId, Keyword)
    SELECT @AttachmentId, k.Id
    FROM @Keywords kw
    INNER JOIN [dbo].[Keyword] k ON k.Word = kw.Word
    LEFT JOIN [dbo].[AttachmentKeyword] ak ON ak.AttachmentId = @AttachmentId AND ak.Keyword = k.Id
    WHERE ak.AttachmentId IS NULL;
    
    -- Return the number of keywords processed
    SELECT @@ROWCOUNT AS KeywordsAdded;
END
GO
