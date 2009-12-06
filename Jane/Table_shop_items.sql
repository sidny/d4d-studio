if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[shop_items]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[shop_items]
GO

CREATE TABLE [dbo].[shop_items] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [nvarchar] (2000) COLLATE Chinese_PRC_CI_AS NULL ,
	[description] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[body] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[price] [decimal](19, 4) NULL ,
	[SImage] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[LImage] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[PublishDate] [datetime] NULL ,
	[AddUserId] [int] NULL ,
	[AddDate] [datetime] NULL ,
	[Status] [int] NULL 
) ON [PRIMARY]
GO

