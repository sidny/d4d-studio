SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- =============================================
CREATE PROCEDURE dbo.Comment_Get
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
GO
