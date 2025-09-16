SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Procedures for Attachment Port Names
CREATE PROCEDURE [dbo].[AddAttachmentPortName]
    @AttachmentId uniqueidentifier,
    @PortName nvarchar(200)
AS
BEGIN
    SET NOCOUNT ON;
    -- Do NOT use XACT_ABORT
    
    DECLARE @PortNameId int;
    
    -- Get or create the port name
    SELECT @PortNameId = ID FROM [dbo].[KeyPortName] WHERE [Name] = @PortName;
    
    IF @PortNameId IS NULL
    BEGIN
        -- Use MERGE for thread-safe insert
        MERGE [dbo].[KeyPortName] AS target
        USING (SELECT @PortName AS [Name]) AS source
        ON target.[Name] = source.[Name]
        WHEN NOT MATCHED THEN
            INSERT ([Name]) VALUES (source.[Name]);
        
        SELECT @PortNameId = ID FROM [dbo].[KeyPortName] WHERE [Name] = @PortName;
    END
    
    -- Insert the relationship if it doesn't exist
    -- Note: AttachmentPortName table uses 'PortName' column (INT) not 'PortNameID'
    IF NOT EXISTS (SELECT 1 FROM [dbo].[AttachmentPortName] WHERE AttachmentID = @AttachmentId AND PortName = @PortNameId)
    BEGIN
        INSERT INTO [dbo].[AttachmentPortName] (AttachmentID, PortName)
        VALUES (@AttachmentId, @PortNameId);
    END
END
GO
