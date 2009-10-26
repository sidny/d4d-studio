USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[TagRelation_GetByObject]    Script Date: 10/26/2009 18:28:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Get  TagsRealtions ByObject
-- =============================================
ALTER PROCEDURE [dbo].[TagRelation_GetByObject]   
   @ObjectId AS INT,   
   @ObjectType AS INT
AS
BEGIN	
	
    SELECT Id,TagId,ObjectId,ObjectType,AddUserID,[AddDate] 
    FROM tag_relation With(nolock)
     WHERE ObjectId = @ObjectId
	AND ObjectType = @ObjectType
	
 
END
