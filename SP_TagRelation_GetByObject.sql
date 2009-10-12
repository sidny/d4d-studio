SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Get  TagsRealtions ByObject
-- =============================================
CREATE PROCEDURE dbo.TagRelation_GetByObject   
   @ObjectId AS INT,   
   @ObjectType AS INT
AS
BEGIN	
	
    SELECT Id,TagId,ObjectId,ObjectType,AddUserID,[AddDate] 
    FROM tag_relation With(nolock)
     WHERE ObjectId = @ObjectId
	AND ObjectType = @ObjectType
	
 
END
GO
