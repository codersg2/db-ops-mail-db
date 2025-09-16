SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Stored procedures for port names and cargo types
-- These complement the existing keyword procedures for standard keywords

-- Procedures for Email Port Names
CREATE PROCEDURE [dbo].[AddEmailPortName]
    @EmailId uniqueidentifier,
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
    IF NOT EXISTS (SELECT 1 FROM [dbo].[EmailPortName] WHERE EmailID = @EmailId AND PortNameID = @PortNameId)
    BEGIN
        INSERT INTO [dbo].[EmailPortName] (EmailID, PortNameID)
        VALUES (@EmailId, @PortNameId);
    END
END
GO
