if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[shop_region]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[shop_region]
GO

CREATE TABLE [dbo].[shop_region] (
	[Id] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[ParentId] [int] NULL ,
	[TransferPrice] [float] NULL ,
	[TransferPrice1] [float] NULL ,
	[TransferPrice2] [float] NULL 
) ON [PRIMARY]
GO

