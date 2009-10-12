SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[albums](
	[AlbumId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](1000) NOT NULL,
	[BandId] [int] NOT NULL,
	[PublishDate] [datetime] NULL,
	[PublishYear] [int] NULL,
	[PublishMonth] [int] NULL,
	[AddUserId] [int] NULL,
	[AddDate] [datetime] NULL,
	[Status] [int] NULL,
	[TotalCount] [int] NULL,
	[SImage] [nvarchar](1000) NULL,
	[LImage] [nvarchar](1000) NULL,
 CONSTRAINT [PK_album] PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[albums] ADD  CONSTRAINT [DF_album_TotalCount]  DEFAULT (0) FOR [TotalCount]
GO


