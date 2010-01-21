if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[shop_orders]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[shop_orders]
GO

CREATE TABLE [dbo].[shop_orders] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[userid] [int] NULL ,
	[addDate] [datetime] NULL ,
	[ordertype] [int] NULL ,
	[address] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[email] [nvarchar] (500) COLLATE Chinese_PRC_CI_AS NULL ,
	[mobile] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[paymoney] [float] NULL ,
	[paytype] [int] NULL ,
	[payresult] [int] NULL ,
	[payremark] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[paythirdnum] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[paydate] [datetime] NULL ,
	[zipcode] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[username] [nvarchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[RegionId] [int] NULL ,
	[Freight] [float] NULL ,
	[RegionStr] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

