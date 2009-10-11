USE [d4d]
GO

/****** Object:  Table [dbo].[music_songlist]    Script Date: 10/11/2009 15:57:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[music_songlist](
	[ListId] [int] IDENTITY(1,1) NOT NULL,
	[MusicId] [int] NOT NULL,
	[SongName] [nvarchar](500) NULL,
	[SongFile] [nvarchar](1000) NULL,
	[SongTime] [nvarchar](50) NULL,
	[AddUserId] [int] NOT NULL,
	[AddDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[music_songlist] ADD  CONSTRAINT [DF_music_songlist_AddUserId]  DEFAULT (0) FOR [AddUserId]
GO

ALTER TABLE [dbo].[music_songlist] ADD  CONSTRAINT [DF_music_songlist_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO

ALTER TABLE [dbo].[music_songlist] ADD  CONSTRAINT [DF_music_songlist_Status]  DEFAULT (0) FOR [Status]
GO


