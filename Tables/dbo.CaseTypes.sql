CREATE TABLE [dbo].[CaseTypes]
(
[CaseTypeId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (100) COLLATE Latin1_General_CI_AI NOT NULL,
[Description] [nvarchar] (400) COLLATE Latin1_General_CI_AI NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF__CaseTypes__IsAct__5D95E53A] DEFAULT ((1))
)
GO
ALTER TABLE [dbo].[CaseTypes] ADD CONSTRAINT [PK__CaseType__E727083648ED0330] PRIMARY KEY CLUSTERED ([CaseTypeId])
GO
