USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Comment_Get]    Script Date: 10/26/2009 18:18:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- =============================================
ALTER PROCEDURE [dbo].[Comment_Get]
   @CommentId AS INT  
AS
BEGIN	
	
    SELECT
             CommentId, 
              ObjectId,
			   ObjectType,
			   UserId,
			   UserName,
			   AddDate,
			   Body,			
			    Remark,
			   [Status]		 
    FROM comments With(nolock)
     WHERE CommentId = @CommentId 
	
	
 
END
