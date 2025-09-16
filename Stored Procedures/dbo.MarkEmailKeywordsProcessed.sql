SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Create or update stored procedure to mark email as keywords processed
CREATE   PROCEDURE [dbo].[MarkEmailKeywordsProcessed]
    @EmailId uniqueidentifier
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE [dbo].[Email]
    SET [KeywordsProcessed] = 1
    WHERE [Id] = @EmailId;
END
GO
