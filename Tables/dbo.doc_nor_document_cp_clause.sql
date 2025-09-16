CREATE TABLE [dbo].[doc_nor_document_cp_clause]
(
[AttachmentId] [uniqueidentifier] NOT NULL,
[clause_text] [nvarchar] (200) COLLATE Latin1_General_CI_AI NOT NULL
)
GO
ALTER TABLE [dbo].[doc_nor_document_cp_clause] ADD CONSTRAINT [PK_doc_nor_document_cp_clause] PRIMARY KEY CLUSTERED ([AttachmentId], [clause_text])
GO
ALTER TABLE [dbo].[doc_nor_document_cp_clause] ADD CONSTRAINT [FK__doc_nor_d__doc_i__15A53433] FOREIGN KEY ([AttachmentId]) REFERENCES [dbo].[doc_nor_document] ([AttachmentID]) ON DELETE CASCADE
GO
