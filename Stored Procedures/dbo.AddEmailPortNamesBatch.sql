SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[AddEmailPortNamesBatch]
    @EmailId uniqueidentifier,
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
    
    -- Now insert the email-port name relationships
    -- Use LEFT JOIN to only insert missing relationships
    -- Use DISTINCT to handle case variations in input that map to same master record
    INSERT INTO [dbo].[EmailPortName] (EmailID, PortNameID)
    SELECT DISTINCT @EmailId, kpn.ID
    FROM @PortNames pn
    INNER JOIN [dbo].[KeyPortName] kpn ON kpn.[Name] = pn.Word
    LEFT JOIN [dbo].[EmailPortName] epn ON epn.EmailID = @EmailId AND epn.PortNameID = kpn.ID
    WHERE epn.EmailID IS NULL;
    
    -- Return the number of port names processed
    SELECT @@ROWCOUNT AS PortNamesAdded;
END
GO
