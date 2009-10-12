SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Delete  One TagRelation by Object
-- =============================================
CREATE PROCEDURE dbo.TagRelation_DeleteByObject   
   @ObjectId AS INT,   
   @ObjectType AS INT
AS
BEGIN	

   DELETE FROM  tag_relation
   WHERE 	ObjectId = @ObjectId
	AND ObjectType = @ObjectType
	
END
GO

