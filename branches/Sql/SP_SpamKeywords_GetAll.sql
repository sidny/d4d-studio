USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[News_GetTopImageNews]    Script Date: 11/01/2009 17:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
CREATE PROCEDURE [dbo].[SpamKeywords_GetAll]  
AS
BEGIN	
	
      	SELECT   
		       id ,
               Keyword,
			   [Status],
			   AddUserId,
			   AddDate
		FROM dbo.SpamKeywords  WITH(NOLOCK) 
END
