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
CREATE PROCEDURE [dbo].[Show_GetTagRelation]
   @ShowId AS INT ,
   @MaxCount AS INT
AS
BEGIN
    SET ROWCOUNT @MaxCount
    
     SELECT   ShowId, 
              Title,
			   Body,
			   SImage,
			   LImage,
			   BandId,
			   ShowDate,			  
			   ShowPlace,
			   AddUserId,
			   AddDate,
			  [Status],
			  EndDate
    FROM shows With(nolock)  
	WHERE  [Status] = 1
		AND ShowId != @ShowId 		
		AND ShowId IN
		(
		    SELECT OBJECTID FROM dbo.tag_relation WITH(NOLOCK)
		    WHERE  ObjectType = 6 AND TagID IN(
			   SELECT TagId FROM 	dbo.tag_relation WITH(NOLOCK)
				 WHERE ObjectId = @ShowId AND ObjectType = 6)
		)
	ORDER BY ShowId DESC 
END
