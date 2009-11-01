USE [d4d]
GO

/****** Object:  Table [dbo].[SpamKeywords]    Script Date: 11/01/2009 17:50:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SpamKeywords](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Keyword] [nvarchar](200) NOT NULL,
	[Status] [int] NULL,
	[AddUserId] [int] NULL,
	[AddDate] [datetime] NULL,
 CONSTRAINT [PK_SpamKeywords] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


