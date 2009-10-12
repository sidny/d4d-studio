SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[comments](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[ObjectId] [int] NOT NULL,
	[ObjectType] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[UserName] [nvarchar](200) NULL,
	[AddDate] [datetime] NULL,
	[Body] [nvarchar](4000) NULL,
	[Remark] [nvarchar](1000) NULL,
	[Status] [int] NULL
) ON [PRIMARY]

GO


