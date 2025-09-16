SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Create or update stored procedure to mark attachment as keywords processed
CREATE   PROCEDURE [dbo].[MarkAttachmentKeywordsProcessed]
    @AttachmentId uniqueidentifier
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE [dbo].[Attachment]
    SET [KeywordsProcessed] = 1
    WHERE [Id] = @AttachmentId;
END
GO
