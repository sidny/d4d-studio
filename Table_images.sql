SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[images](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[AlbumId] [int] NOT NULL,
	[ImageName] [nvarchar](1000) NULL,
	[ImageFile] [nvarchar](1000) NULL,
	[AddUserId] [int] NULL,
	[AddDate] [datetime] NULL,
	[Status] [int] NULL,
	[SImageFile] [nvarchar](1000) NULL,
 CONSTRAINT [PK_images] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


