SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Create an improved stored procedure that handles multiple keywords at once
CREATE   PROCEDURE [dbo].[AddEmailKeywordsBatch]
    @EmailId uniqueidentifier,
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
    
    -- Now insert the email-keyword relationships
    -- Use LEFT JOIN to only insert missing relationships
    INSERT INTO [dbo].[EmailKeyword] (EmailId, KeywordId)
    SELECT @EmailId, k.Id
    FROM @Keywords kw
    INNER JOIN [dbo].[Keyword] k ON k.Word = kw.Word
    LEFT JOIN [dbo].[EmailKeyword] ek ON ek.EmailId = @EmailId AND ek.KeywordId = k.Id
    WHERE ek.EmailId IS NULL;
    
    -- Return the number of keywords processed
    SELECT @@ROWCOUNT AS KeywordsAdded;
END
GO
