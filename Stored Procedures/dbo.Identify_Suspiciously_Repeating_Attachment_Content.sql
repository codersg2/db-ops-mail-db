SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Identify_Suspiciously_Repeating_Attachment_Content]
AS
BEGIN

	-- Tunables
	DECLARE @MinLen int = 4000;         -- skip very short bodies
	DECLARE @MaxRatio decimal(6,4) = 0.10;  -- compressed/original; lower = more repetition
	
	;WITH cte_comp AS 
	(
	SELECT
		ac.Id,
		ac.AttachmentId,
		DATALENGTH(ac.RawExtractedText)/2        AS chars,
		DATALENGTH(COMPRESS(ac.RawExtractedText)) AS compressed_bytes,
		CONVERT(decimal(10,4),
			1.0 * DATALENGTH(COMPRESS(ac.RawExtractedText))
			/ NULLIF(DATALENGTH(ac.RawExtractedText),0)) AS compress_ratio
	FROM dbo.AttachmentContents ac WITH (NOLOCK)
	WHERE ac.CleanedTextLength >= @MinLen
	  AND 1.0 * DATALENGTH(COMPRESS(ac.RawExtractedText))
		  / NULLIF(DATALENGTH(ac.RawExtractedText),0) <= @MaxRatio
	  AND ac.SuspiciousRepetition = 0 -- No need to mark something already marked as suspicious
	)
	UPDATE ac
	SET SuspiciousRepetition = 1
	FROM cte_comp AS c
	INNER JOIN dbo.AttachmentContents ac ON ac.id = c.Id

END
GO
