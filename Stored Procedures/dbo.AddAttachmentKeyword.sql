SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE   PROCEDURE [dbo].[AddAttachmentKeyword]
    @AttachmentId uniqueidentifier,
    @Word nvarchar(250)
AS
BEGIN
    SET NOCOUNT ON;
    -- Do NOT use XACT_ABORT
    
    DECLARE @KeywordId int;
    
    -- Get or create the keyword
    SELECT @KeywordId = Id FROM [dbo].[Keyword] WHERE Word = @Word;
    
    IF @KeywordId IS NULL
    BEGIN
        -- Use MERGE for thread-safe insert
        MERGE [dbo].[Keyword] AS target
        USING (SELECT @Word AS Word) AS source
        ON target.Word = source.Word
        WHEN NOT MATCHED THEN
            INSERT (Word) VALUES (source.Word);
        
        SELECT @KeywordId = Id FROM [dbo].[Keyword] WHERE Word = @Word;
    END
    
    -- Insert the relationship if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM [dbo].[AttachmentKeyword] WHERE AttachmentId = @AttachmentId AND Keyword = @KeywordId)
    BEGIN
        INSERT INTO [dbo].[AttachmentKeyword] (AttachmentId, Keyword)
        VALUES (@AttachmentId, @KeywordId);
    END
END
GO
