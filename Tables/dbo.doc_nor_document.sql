CREATE TABLE [dbo].[doc_nor_document]
(
[AttachmentID] [uniqueidentifier] NOT NULL,
[vessel_name] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL,
[vessel_imo] [varchar] (7) COLLATE Latin1_General_CI_AI NULL,
[voyage_no] [nvarchar] (50) COLLATE Latin1_General_CI_AI NULL,
[cp_ref] [nvarchar] (100) COLLATE Latin1_General_CI_AI NULL,
[cp_date] [date] NULL,
[document_type] [varchar] (32) COLLATE Latin1_General_CI_AI NOT NULL,
[area_variant] [varchar] (64) COLLATE Latin1_General_CI_AI NULL,
[tender_local_time] [datetime2] (0) NULL,
[tender_timezone] [nvarchar] (64) COLLATE Latin1_General_CI_AI NULL,
[tender_utc_time] [datetime2] (0) NULL,
[place] [varchar] (32) COLLATE Latin1_General_CI_AI NULL,
[place_detail] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL,
[delivery_method] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[accepted_status] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[accepted_by] [nvarchar] (100) COLLATE Latin1_General_CI_AI NULL,
[accepted_by_role] [nvarchar] (80) COLLATE Latin1_General_CI_AI NULL,
[accepted_time_utc] [datetime2] (0) NULL,
[without_prejudice] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__witho__7FB5F314] DEFAULT ((0)),
[within_port_limits] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[free_pratique_granted] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[free_pratique_time_utc] [datetime2] (0) NULL,
[all_fast_value] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[all_fast_time_utc] [datetime2] (0) NULL,
[customs_clear] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[immigration_clear] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[cargo_ready_per_cp] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[ordered_to_wait] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[port] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL,
[country] [nvarchar] (150) COLLATE Latin1_General_CI_AI NULL,
[terminal] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL,
[berth] [nvarchar] (200) COLLATE Latin1_General_CI_AI NULL,
[lat] [nvarchar] (50) COLLATE Latin1_General_CI_AI NULL,
[lon] [nvarchar] (50) COLLATE Latin1_General_CI_AI NULL,
[operation] [varchar] (16) COLLATE Latin1_General_CI_AI NULL,
[is_river_port] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_ri__00AA174D] DEFAULT ((0)),
[is_shared_anchorage_case] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_sh__019E3B86] DEFAULT ((0)),
[is_daily_0900] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_da__02925FBF] DEFAULT ((0)),
[is_uscg_boarding_completed] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_us__038683F8] DEFAULT ((0)),
[is_west_africa_200nm] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_we__047AA831] DEFAULT ((0)),
[is_multi_berth_hoses_off] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_mu__056ECC6A] DEFAULT ((0)),
[is_pilot_on_board] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_pi__0662F0A3] DEFAULT ((0)),
[is_all_fast_trigger] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_al__075714DC] DEFAULT ((0)),
[cargo_product] [nvarchar] (100) COLLATE Latin1_General_CI_AI NULL,
[filename] [nvarchar] (260) COLLATE Latin1_General_CI_AI NULL,
[sha256] [varbinary] (32) NULL,
[pages] [int] NULL,
[extracted_text_len] [int] NULL,
[is_signature_present] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_si__084B3915] DEFAULT ((0)),
[is_terminal_stamp_present] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_te__093F5D4E] DEFAULT ((0)),
[is_terminal_signature_present] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_te__0A338187] DEFAULT ((0)),
[is_agent_stamp_present] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_ag__0B27A5C0] DEFAULT ((0)),
[is_agent_signature_present] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_ag__0C1BC9F9] DEFAULT ((0)),
[is_counterparty_named] [bit] NOT NULL CONSTRAINT [DF__doc_nor_d__is_co__0D0FEE32] DEFAULT ((0)),
[ops_notes] [nvarchar] (max) COLLATE Latin1_General_CI_AI NULL,
[created_utc] [datetime2] (0) NOT NULL CONSTRAINT [DF__doc_nor_d__creat__0E04126B] DEFAULT (sysutcdatetime()),
[updated_utc] [datetime2] (0) NOT NULL CONSTRAINT [DF__doc_nor_d__updat__0EF836A4] DEFAULT (sysutcdatetime())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  CREATE TRIGGER [dbo].[trg_doc_nor_document_set_updated]
  ON [dbo].[doc_nor_document]
  AFTER UPDATE
  AS
  BEGIN
    SET NOCOUNT ON;
    UPDATE d
      SET updated_utc = SYSUTCDATETIME()
    FROM dbo.doc_nor_document d
    JOIN inserted i ON d.AttachmentID = i.AttachmentID;
  END;
GO
ALTER TABLE [dbo].[doc_nor_document] ADD CONSTRAINT [PK__doc_nor___8AD029243F668A97] PRIMARY KEY CLUSTERED ([AttachmentID])
GO
CREATE NONCLUSTERED INDEX [IX_doc_nor_document_acceptance] ON [dbo].[doc_nor_document] ([accepted_status], [accepted_time_utc])
GO
CREATE NONCLUSTERED INDEX [IX_doc_nor_document_classification] ON [dbo].[doc_nor_document] ([document_type], [area_variant], [is_daily_0900], [is_all_fast_trigger])
GO
CREATE NONCLUSTERED INDEX [IX_doc_nor_document_imo_time] ON [dbo].[doc_nor_document] ([vessel_imo], [tender_utc_time])
GO
CREATE NONCLUSTERED INDEX [IX_doc_nor_document_vessel_port_time] ON [dbo].[doc_nor_document] ([vessel_name], [port], [tender_utc_time]) INCLUDE ([document_type], [area_variant], [is_daily_0900])
GO
