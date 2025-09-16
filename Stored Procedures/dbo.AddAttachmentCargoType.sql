SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Procedures for Attachment Cargo Types
CREATE PROCEDURE [dbo].[AddAttachmentCargoType]
    @AttachmentId uniqueidentifier,
    @CargoType nvarchar(200)
AS
BEGIN
    SET NOCOUNT ON;
    -- Do NOT use XACT_ABORT
    
    DECLARE @CargoTypeId int;
    
    -- Get or create the cargo type
    SELECT @CargoTypeId = ID FROM [dbo].[KeyCargoType] WHERE [Name] = @CargoType;
    
    IF @CargoTypeId IS NULL
    BEGIN
        -- Use MERGE for thread-safe insert
        MERGE [dbo].[KeyCargoType] AS target
        USING (SELECT @CargoType AS [Name]) AS source
        ON target.[Name] = source.[Name]
        WHEN NOT MATCHED THEN
            INSERT ([Name]) VALUES (source.[Name]);
        
        SELECT @CargoTypeId = ID FROM [dbo].[KeyCargoType] WHERE [Name] = @CargoType;
    END
    
    -- Insert the relationship if it doesn't exist
    -- Note: AttachmentCargoType table uses 'CargoType' column (INT) not 'CargoTypeID'
    IF NOT EXISTS (SELECT 1 FROM [dbo].[AttachmentCargoType] WHERE AttachmentID = @AttachmentId AND CargoType = @CargoTypeId)
    BEGIN
        INSERT INTO [dbo].[AttachmentCargoType] (AttachmentID, CargoType)
        VALUES (@AttachmentId, @CargoTypeId);
    END
END
GO
