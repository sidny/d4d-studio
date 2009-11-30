if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[shop_tradelist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[shop_tradelist]
GO

CREATE TABLE [dbo].[shop_tradelist] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[orderid] [int] NOT NULL ,
	[itemid] [int] NOT NULL ,
	[itemcount] [int] NOT NULL 
) ON [PRIMARY]
GO

