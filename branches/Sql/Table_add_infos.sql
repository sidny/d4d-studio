if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[add_infos]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[add_infos]
GO

CREATE TABLE [dbo].[add_infos] (
	[objectid] [int] NOT NULL ,
	[objecttype] [int] NULL ,
	[info1] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[info2] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[info3] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[info4] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[info5] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[info6] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[info7] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[info8] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

