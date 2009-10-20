USE [d4d]
GO

/****** Object:  Table [dbo].[bandinfo]    Script Date: 10/20/2009 20:58:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bandinfo](
	[BandId] [int] IDENTITY(1,1) NOT NULL,
	[BandName] [nvarchar](50) NULL,
	[Info1] [nvarchar](1000) NULL,
	[Info2] [nvarchar](1000) NULL,
	[Info3] [nvarchar](1000) NULL,
	[Remark] [nvarchar](200) NULL,
	[DeleteFlag] [int] NULL)

GO

ALTER TABLE [dbo].[bandinfo] ADD  CONSTRAINT [DF_bandinfo_DeleteFlag]  DEFAULT (0) FOR [DeleteFlag]
GO


