/****** Object:  Table [dbo].[news]    Script Date: 09/07/2009 20:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[news](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Detail] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_News_AddDate]  DEFAULT (getdate()),
	[Tags] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NewType] [int] NULL,
	[Publish] [bit] NOT NULL CONSTRAINT [DF_News_Publish]  DEFAULT ((0)),
 CONSTRAINT [PK_news] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[news_type]    Script Date: 09/07/2009 20:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news_type](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_news_type] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tag]    Script Date: 09/07/2009 20:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ViewCount] [int] NOT NULL CONSTRAINT [DF_tags_view_count]  DEFAULT ((0)),
	[AddDate] [datetime] NOT NULL CONSTRAINT [DF_tags_add_date]  DEFAULT (getdate()),
 CONSTRAINT [PK_tags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[type_group]    Script Date: 09/07/2009 20:09:58 ******/
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
/****** Object:  Table [dbo].[user_login]    Script Date: 09/07/2009 20:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user_login](
	[Id] [int] NULL,
	[UserName] [varbinary](200) NULL,
	[PassWord] [varbinary](100) NULL,
	[Email] [varbinary](200) NULL,
	[AddDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[news]  WITH CHECK ADD  CONSTRAINT [FK_news_news_type] FOREIGN KEY([NewType])
REFERENCES [dbo].[news_type] ([Id])
GO
ALTER TABLE [dbo].[news] CHECK CONSTRAINT [FK_news_news_type]
GO
ALTER TABLE [dbo].[news_type]  WITH CHECK ADD  CONSTRAINT [FK_news_type_type_group1] FOREIGN KEY([Type])
REFERENCES [dbo].[type_group] ([id])
GO
ALTER TABLE [dbo].[news_type] CHECK CONSTRAINT [FK_news_type_type_group1]