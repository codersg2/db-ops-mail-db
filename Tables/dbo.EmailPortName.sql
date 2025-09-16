CREATE TABLE [dbo].[EmailPortName]
(
[EmailID] [uniqueidentifier] NOT NULL,
[PortNameID] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[EmailPortName] ADD CONSTRAINT [PK_EmailPortName] PRIMARY KEY CLUSTERED ([EmailID], [PortNameID])
GO
CREATE NONCLUSTERED INDEX [IX_EmailPortName_PortNameID] ON [dbo].[EmailPortName] ([PortNameID])
GO
ALTER TABLE [dbo].[EmailPortName] ADD CONSTRAINT [FK_EmailPortName_Email] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[Email] ([Id])
GO
ALTER TABLE [dbo].[EmailPortName] ADD CONSTRAINT [FK_EmailPortName_Port] FOREIGN KEY ([PortNameID]) REFERENCES [dbo].[KeyPortName] ([ID])
GO
