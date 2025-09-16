SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[AddAttachmentPortNamesBatch]
    @AttachmentId uniqueidentifier,
    @PortNames [dbo].[KeywordListType] READONLY
AS
BEGIN
    SET NOCOUNT ON;
    -- Explicitly do NOT use XACT_ABORT or transactions
    
    -- First, insert any new port names into the KeyPortName table
    -- Use MERGE to handle concurrent inserts gracefully
    MERGE [dbo].[KeyPortName] AS target
    USING (SELECT DISTINCT Word AS [Name] FROM @PortNames) AS source
    ON target.[Name] = source.[Name]
    WHEN NOT MATCHED THEN
        INSERT ([Name]) VALUES (source.[Name]);
    
    -- Now insert the attachment-port name relationships
    -- Use LEFT JOIN to only insert missing relationships
    -- Note: AttachmentPortName table uses 'PortName' column (INT) not 'PortNameID'
    -- Use DISTINCT to handle case variations in input that map to same master record
    INSERT INTO [dbo].[AttachmentPortName] (AttachmentID, PortName)
    SELECT DISTINCT @AttachmentId, kpn.ID
    FROM @PortNames pn
    INNER JOIN [dbo].[KeyPortName] kpn ON kpn.[Name] = pn.Word
    LEFT JOIN [dbo].[AttachmentPortName] apn ON apn.AttachmentID = @AttachmentId AND apn.PortName = kpn.ID
    WHERE apn.AttachmentID IS NULL;
    
    -- Return the number of port names processed
    SELECT @@ROWCOUNT AS PortNamesAdded;
END
GO
