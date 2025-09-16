CREATE TABLE [dbo].[doc_nor_document_event]
(
[event_id] [bigint] NOT NULL IDENTITY(1, 1),
[doc_id] [uniqueidentifier] NOT NULL,
[event_name] [nvarchar] (50) COLLATE Latin1_General_CI_AI NOT NULL,
[local_time] [datetime2] (0) NULL,
[timezone] [nvarchar] (64) COLLATE Latin1_General_CI_AI NULL,
[utc_time] [datetime2] (0) NULL,
[notes] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL
)
GO
ALTER TABLE [dbo].[doc_nor_document_event] ADD CONSTRAINT [PK__doc_nor___2370F7277B1FA5F5] PRIMARY KEY CLUSTERED ([event_id])
GO
CREATE NONCLUSTERED INDEX [IX_doc_nor_document_event_lookup] ON [dbo].[doc_nor_document_event] ([doc_id], [event_name], [utc_time])
GO
ALTER TABLE [dbo].[doc_nor_document_event] ADD CONSTRAINT [FK__doc_nor_d__doc_i__1B5E0D89] FOREIGN KEY ([doc_id]) REFERENCES [dbo].[doc_nor_document] ([AttachmentID]) ON DELETE CASCADE
GO
