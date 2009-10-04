USE [d4djane]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[NewsId] [int] NULL,
	[Detail] [nvarchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_comment_AddDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_comment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[image]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[image](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AlbumId] [int] NOT NULL,
	[Url] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_Image_AddDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[media]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[media](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[NewsId] [int] NOT NULL,
	[URL] [varchar](200) COLLATE Chinese_PRC_CI_AS NULL,
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_media_AddDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_media] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[news]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Detail] [nvarchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[Preview] [nvarchar](3000) COLLATE Chinese_PRC_CI_AS NULL,
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_News_AddDate]  DEFAULT (getdate()),
	[NewType] [int] NULL,
	[Publish] [bit] NOT NULL CONSTRAINT [DF_News_Publish]  DEFAULT ((0)),
	[Hits] [int] NOT NULL CONSTRAINT [DF_news_Hits]  DEFAULT ((0)),
 CONSTRAINT [PK_news] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[news_tag]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news_tag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NewsId] [int] NOT NULL,
	[TagId] [int] NOT NULL,
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_news_tag_AddDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_news_tag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[news_type]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news_type](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Type] [int] NOT NULL,
	[Parent] [int] NOT NULL CONSTRAINT [DF_news_type_Parent]  DEFAULT ((0)),
 CONSTRAINT [PK_news_type] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[photo_album]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[photo_album](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PicSmall] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PicBig] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[AddDate] [datetime] NULL,
	[Publish] [bit] NOT NULL CONSTRAINT [DF_photo_album_Publish]  DEFAULT ((0)),
	[TotalCount] [int] NOT NULL CONSTRAINT [DF_photo_album_TotalCount]  DEFAULT ((0)),
 CONSTRAINT [PK_photo_album] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tag]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Hits] [int] NOT NULL CONSTRAINT [DF_tags_view_count]  DEFAULT ((0)),
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_tags_add_date]  DEFAULT (getdate()),
 CONSTRAINT [PK_tags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[type_group]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[type_group](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_type_group] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[user_login]    Script Date: 10/04/2009 15:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user_login](
	[Id] [int] NOT NULL,
	[UserName] [varbinary](200) NULL,
	[PassWord] [varbinary](100) NULL,
	[Email] [varbinary](200) NULL,
	[AddDate] [datetime] NULL,
 CONSTRAINT [PK_user_login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FK_comment_news] FOREIGN KEY([NewsId])
REFERENCES [dbo].[news] ([Id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FK_comment_news]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FK_comment_user_login] FOREIGN KEY([UserId])
REFERENCES [dbo].[user_login] ([Id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FK_comment_user_login]
GO
ALTER TABLE [dbo].[image]  WITH CHECK ADD  CONSTRAINT [FK_Image_photo_album] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[photo_album] ([Id])
GO
ALTER TABLE [dbo].[image] CHECK CONSTRAINT [FK_Image_photo_album]
GO
ALTER TABLE [dbo].[media]  WITH CHECK ADD  CONSTRAINT [FK_media_news] FOREIGN KEY([NewsId])
REFERENCES [dbo].[news] ([Id])
GO
ALTER TABLE [dbo].[media] CHECK CONSTRAINT [FK_media_news]
GO
ALTER TABLE [dbo].[news]  WITH CHECK ADD  CONSTRAINT [FK_news_news_type] FOREIGN KEY([NewType])
REFERENCES [dbo].[news_type] ([Id])
GO
ALTER TABLE [dbo].[news] CHECK CONSTRAINT [FK_news_news_type]
GO
ALTER TABLE [dbo].[news_tag]  WITH CHECK ADD  CONSTRAINT [FK_news_tag_news] FOREIGN KEY([NewsId])
REFERENCES [dbo].[news] ([Id])
GO
ALTER TABLE [dbo].[news_tag] CHECK CONSTRAINT [FK_news_tag_news]
GO
ALTER TABLE [dbo].[news_tag]  WITH CHECK ADD  CONSTRAINT [FK_news_tag_tag] FOREIGN KEY([TagId])
REFERENCES [dbo].[tag] ([Id])
GO
ALTER TABLE [dbo].[news_tag] CHECK CONSTRAINT [FK_news_tag_tag]
GO
ALTER TABLE [dbo].[news_type]  WITH CHECK ADD  CONSTRAINT [FK_news_type_type_group1] FOREIGN KEY([Type])
REFERENCES [dbo].[type_group] ([id])
GO
ALTER TABLE [dbo].[news_type] CHECK CONSTRAINT [FK_news_type_type_group1]