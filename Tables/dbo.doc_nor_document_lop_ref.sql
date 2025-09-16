CREATE TABLE [dbo].[doc_nor_document_lop_ref]
(
[AttachmentId] [uniqueidentifier] NOT NULL,
[lop_ref] [nvarchar] (100) COLLATE Latin1_General_CI_AI NOT NULL
)
GO
ALTER TABLE [dbo].[doc_nor_document_lop_ref] ADD CONSTRAINT [PK_doc_nor_document_lop_ref] PRIMARY KEY CLUSTERED ([AttachmentId], [lop_ref])
GO
ALTER TABLE [dbo].[doc_nor_document_lop_ref] ADD CONSTRAINT [FK__doc_nor_d__doc_i__1881A0DE] FOREIGN KEY ([AttachmentId]) REFERENCES [dbo].[doc_nor_document] ([AttachmentID]) ON DELETE CASCADE
GO
