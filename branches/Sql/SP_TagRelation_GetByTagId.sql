SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Get One TagsRealtionByTagId    
-- =============================================
CREATE PROCEDURE dbo.TagRelation_GetByTagId    
   @TagId AS INT
AS
BEGIN	
	
    SELECT Id,TagId,ObjectId,ObjectType,AddUserID,[AddDate] 
    FROM tag_relation With(nolock)
     WHERE TagId = @TagId 

	
 
END
GO
