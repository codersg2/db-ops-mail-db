CREATE TABLE [dbo].[EmailCargoType]
(
[EmailID] [uniqueidentifier] NOT NULL,
[CargoTypeID] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[EmailCargoType] ADD CONSTRAINT [PK_EmailCargoType] PRIMARY KEY CLUSTERED ([EmailID], [CargoTypeID])
GO
CREATE NONCLUSTERED INDEX [IX_EmailCargoType_CargoTypeID] ON [dbo].[EmailCargoType] ([CargoTypeID])
GO
ALTER TABLE [dbo].[EmailCargoType] ADD CONSTRAINT [FK_EmailCargoType_Cargo] FOREIGN KEY ([CargoTypeID]) REFERENCES [dbo].[KeyCargoType] ([ID])
GO
ALTER TABLE [dbo].[EmailCargoType] ADD CONSTRAINT [FK_EmailCargoType_Email] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[Email] ([Id])
GO
