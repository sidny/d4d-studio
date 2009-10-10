USE [d4d]
GO

/****** Object:  Table [dbo].[tags]    Script Date: 10/10/2009 20:45:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tags](
	[TagId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Hits] [int] NOT NULL,
	[AddUserID] [int] NOT NULL,
	[AddDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tags_1] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tags] ADD  CONSTRAINT [DF_tags_Hits]  DEFAULT (0) FOR [Hits]
GO

ALTER TABLE [dbo].[tags] ADD  CONSTRAINT [DF_tags_AddUserID]  DEFAULT (0) FOR [AddUserID]
GO

ALTER TABLE [dbo].[tags] ADD  CONSTRAINT [DF_tags_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO


