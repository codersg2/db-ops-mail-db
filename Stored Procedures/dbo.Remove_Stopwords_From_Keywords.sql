SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[Remove_Stopwords_From_Keywords]
AS
BEGIN
	CREATE TABLE #InvalidKeywords (KeywordID INT PRIMARY KEY)

	-- Find the keyword IDs to remove
	INSERT INTO #InvalidKeywords (KeywordID)
	SELECT DISTINCT k.ID
	FROM dbo.Keyword k
	INNER JOIN dbo.Stopkeyword sk ON sk.Word = k.Word

	-- Remove the links
	DELETE FROM dbo.EmailKeyword
	WHERE KeywordID IN 
	(
		SELECT KeywordID
		FROM #InvalidKeywords
	)

	-- Remove the keywords
	DELETE FROM dbo.Keyword
	WHERE ID IN 
	(
		SELECT KeywordID
		FROM #InvalidKeywords
	)

	DROP TABLE #InvalidKeywords

END
GO
