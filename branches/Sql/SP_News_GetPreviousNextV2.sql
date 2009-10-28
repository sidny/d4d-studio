USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[News_GetPreviousNext]    Script Date: 10/28/2009 14:31:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- only video news
-- =============================================
CREATE PROCEDURE [dbo].[News_GetPreviousNextV2]
   @NewsId AS INT 
AS
BEGIN	

SELECT * FROM
(
	 SELECT TOP 1
               NewsId ,
               Title,
			   Body,
			   Preview,
			   SImage,
			   LImage,
			   NewsType,
			   Hits,
			   PublishDate,
			   AddUserId,
			   AddDate,
			  [Status],
			  Remark
    FROM newsinfo With(nolock)  
	WHERE NewsId>=  @NewsId	
	    AND [Status] = 1
		AND NewsId <> @NewsId 	
		AND Remark='video'	
	ORDER BY NewsId ASC
) [Previous]
UNION
SELECT * FROM
(
	 SELECT TOP 1
               NewsId ,
               Title,
			   Body,
			   Preview,
			   SImage,
			   LImage,
			   NewsType,
			   Hits,
			   PublishDate,
			   AddUserId,
			   AddDate,
			  [Status],
			  Remark
    FROM newsinfo With(nolock)  
	WHERE NewsId<=  @NewsId	
		AND [Status] = 1
		AND NewsId <> @NewsId 	
		AND Remark='video'	
	ORDER BY NewsId DESC	
) [Next]

ORDER BY NewsId DESC
   
 
END
