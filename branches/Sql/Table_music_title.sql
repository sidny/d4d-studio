SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[music_title](
	[MusicId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NULL,
	[Body] [nvarchar](4000) NULL,
	[SImage] [nvarchar](1000) NULL,
	[LImage] [nvarchar](1000) NULL,
	[BandId] [int] NOT NULL,
	[PublishDate] [datetime] NOT NULL,
	[PublishYear] [int] NOT NULL,
	[AddUserId] [int] NOT NULL,
	[AddDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_music_title] PRIMARY KEY CLUSTERED 
(
	[MusicId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[music_title] ADD  CONSTRAINT [DF_music_title_BandId]  DEFAULT (0) FOR [BandId]
GO

ALTER TABLE [dbo].[music_title] ADD  CONSTRAINT [DF_music_title_AddUserId]  DEFAULT (0) FOR [AddUserId]
GO

ALTER TABLE [dbo].[music_title] ADD  CONSTRAINT [DF_music_title_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO

ALTER TABLE [dbo].[music_title] ADD  CONSTRAINT [DF_music_title_Status]  DEFAULT (0) FOR [Status]
GO


