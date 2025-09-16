SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[AddEmailCargoTypesBatch]
    @EmailId uniqueidentifier,
    @CargoTypes [dbo].[KeywordListType] READONLY
AS
BEGIN
    SET NOCOUNT ON;
    -- Explicitly do NOT use XACT_ABORT or transactions
    
    -- First, insert any new cargo types into the KeyCargoType table
    -- Use MERGE to handle concurrent inserts gracefully
    MERGE [dbo].[KeyCargoType] AS target
    USING (SELECT DISTINCT Word AS [Name] FROM @CargoTypes) AS source
    ON target.[Name] = source.[Name]
    WHEN NOT MATCHED THEN
        INSERT ([Name]) VALUES (source.[Name]);
    
    -- Now insert the email-cargo type relationships
    -- Use LEFT JOIN to only insert missing relationships
    -- Use DISTINCT to handle case variations in input that map to same master record
    INSERT INTO [dbo].[EmailCargoType] (EmailID, CargoTypeID)
    SELECT DISTINCT @EmailId, kct.ID
    FROM @CargoTypes ct
    INNER JOIN [dbo].[KeyCargoType] kct ON kct.[Name] = ct.Word
    LEFT JOIN [dbo].[EmailCargoType] ect ON ect.EmailID = @EmailId AND ect.CargoTypeID = kct.ID
    WHERE ect.EmailID IS NULL;
    
    -- Return the number of cargo types processed
    SELECT @@ROWCOUNT AS CargoTypesAdded;
END
GO
