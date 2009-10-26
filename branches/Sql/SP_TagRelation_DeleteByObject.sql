USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[TagRelation_DeleteByObject]    Script Date: 10/26/2009 18:28:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Delete  One TagRelation by Object
-- =============================================
ALTER PROCEDURE [dbo].[TagRelation_DeleteByObject]   
   @ObjectId AS INT,   
   @ObjectType AS INT
AS
BEGIN	

   DELETE FROM  tag_relation
   WHERE 	ObjectId = @ObjectId
	AND ObjectType = @ObjectType
	
END
