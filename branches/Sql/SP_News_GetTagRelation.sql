USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[News_Get]    Script Date: 10/27/2009 17:02:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[News_GetTagRelation]
   @NewsId AS INT ,
   @MaxCount AS INT
AS
BEGIN
    SET ROWCOUNT @MaxCount
    
     SELECT   NewsId ,
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
	WHERE  [Status] = 1
		AND NewsId != @NewsId 
		AND Remark!='video'
		AND NewsID IN
		(
		    SELECT OBJECTID FROM dbo.tag_relation WITH(NOLOCK)
		    WHERE  ObjectType = 1 AND TagID IN(
			   SELECT TagId FROM 	dbo.tag_relation WITH(NOLOCK)
				 WHERE ObjectId = @NewsId AND ObjectType = 1)
		)
	ORDER BY NewsId DESC 
END
