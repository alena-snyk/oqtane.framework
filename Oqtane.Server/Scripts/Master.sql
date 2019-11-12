/*  

Create tables

*/
CREATE TABLE [dbo].[Alias](
	[AliasId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[TenantId] [int] NOT NULL,
	[SiteId] [int] NOT NULL,
	[CreatedBy] [nvarchar](256) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](256) NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
  CONSTRAINT [PK_Alias] PRIMARY KEY CLUSTERED 
  (
	[AliasId] ASC
  )
)
GO

CREATE TABLE [dbo].[Tenant](
	[TenantId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DBConnectionString] [nvarchar](1024) NOT NULL,
	[DBSchema] [nvarchar](50) NOT NULL,
	[IsInitialized] [bit] NOT NULL,
	[CreatedBy] [nvarchar](256) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](256) NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
  CONSTRAINT [PK_Tenant] PRIMARY KEY CLUSTERED 
  (
	[TenantId] ASC
  )
)
GO

CREATE TABLE [dbo].[ModuleDefinition](
	[ModuleDefinitionId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleDefinitionName] [nvarchar](200) NOT NULL,
	[CreatedBy] [nvarchar](256) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](256) NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
  CONSTRAINT [PK_ModuleDefinition] PRIMARY KEY CLUSTERED 
  (
	[ModuleDefinitionId] ASC
  )
)
GO

CREATE TABLE [dbo].[Schedule] (
	[ScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[JobType] [nvarchar](200) NOT NULL,
	[Period] [int] NOT NULL,
	[Frequency] [char](1) NOT NULL,
	[StartDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[RetentionHistory] [int] NOT NULL,
	[CreatedBy] [nvarchar](256) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](256) NULL,
	[ModifiedOn] [datetime] NULL,
    CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
    (
	  [ScheduleId] ASC
    )
)
GO

CREATE TABLE [dbo].[ScheduleLog] (
	[ScheduleLogId] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishDate] [datetime] NULL,
	[Succeeded] [bit] NULL,
	[Notes] [nvarchar](max) NULL,
	[NextExecution] [datetime] NULL,
    CONSTRAINT [PK_ScheduleLog] PRIMARY KEY CLUSTERED 
    (
	  [ScheduleLogId] ASC
    ) 
)
GO

CREATE TABLE [dbo].[ApplicationVersion](
	[ApplicationVersionId] [int] IDENTITY(1,1) NOT NULL,
	[Version] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL
  CONSTRAINT [PK_ApplicationVersion] PRIMARY KEY CLUSTERED 
  (
	[ApplicationVersionId] ASC
  )
)
GO

/*  

Create foreign key relationships

*/
ALTER TABLE [dbo].[Alias]  WITH CHECK ADD  CONSTRAINT [FK_Alias_Tenant] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([TenantId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[ScheduleLog]  WITH NOCHECK ADD CONSTRAINT [FK_ScheduleLog_Schedule] FOREIGN KEY([ScheduleId])
REFERENCES [dbo].[Schedule] ([ScheduleId])
ON DELETE CASCADE
GO

/*  

Create seed data

*/
SET IDENTITY_INSERT [dbo].[Tenant] ON 
GO
INSERT [dbo].[Tenant] ([TenantId], [Name], [DBConnectionString], [DBSchema], [IsInitialized], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) 
VALUES (1, N'Master', N'{ConnectionString}', N'', 1, '', getdate(), '', getdate())
GO
SET IDENTITY_INSERT [dbo].[Tenant] OFF
GO

SET IDENTITY_INSERT [dbo].[Alias] ON 
GO
INSERT [dbo].[Alias] ([AliasId], [Name], [TenantId], [SiteId], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) 
VALUES (1, N'{Alias}', 1, 1, '', getdate(), '', getdate())
GO
SET IDENTITY_INSERT [dbo].[Alias] OFF
GO
