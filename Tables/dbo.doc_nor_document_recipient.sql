CREATE TABLE [dbo].[doc_nor_document_recipient]
(
[doc_id] [uniqueidentifier] NOT NULL,
[email] [nvarchar] (254) COLLATE Latin1_General_CI_AI NOT NULL
)
GO
ALTER TABLE [dbo].[doc_nor_document_recipient] ADD CONSTRAINT [PK_doc_nor_document_recipient] PRIMARY KEY CLUSTERED ([doc_id], [email])
GO
ALTER TABLE [dbo].[doc_nor_document_recipient] ADD CONSTRAINT [FK__doc_nor_d__doc_i__12C8C788] FOREIGN KEY ([doc_id]) REFERENCES [dbo].[doc_nor_document] ([AttachmentID]) ON DELETE CASCADE
GO
