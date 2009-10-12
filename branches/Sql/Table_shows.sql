USE [d4d]
GO

/****** Object:  Table [dbo].[shows]    Script Date: 10/12/2009 23:58:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[shows](
	[ShowId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[Body] [nvarchar](4000) NULL,
	[SImage] [nvarchar](1000) NULL,
	[LImage] [nvarchar](1000) NULL,
	[BandId] [int] NOT NULL,
	[ShowDate] [datetime] NULL,
	[ShowPlace] [nvarchar](500) NULL,
	[AddUserId] [int] NULL,
	[AddDate] [datetime] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_shows] PRIMARY KEY CLUSTERED 
(
	[ShowId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


