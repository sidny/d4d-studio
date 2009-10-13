USE [d4d]
GO

/****** Object:  Table [dbo].[newsinfo]    Script Date: 10/13/2009 13:27:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[newsinfo](
	[NewsId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[Body] [nvarchar](4000) NULL,
	[Preview] [nvarchar](2000) NULL,
	[SImage] [nvarchar](1000) NULL,
	[LImage] [nvarchar](1000) NULL,
	[NewsType] [int] NULL,
	[Hits] [int] NULL,
	[PublishDate] [datetime] NULL,
	[AddUserId] [int] NULL,
	[AddDate] [datetime] NULL,
	[Status] [int] NULL,
	[Remark] [nvarchar](1000) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[newsinfo] ADD  CONSTRAINT [DF_newsinfo_Status]  DEFAULT (0) FOR [Status]
GO


