SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- =============================================
CREATE PROCEDURE dbo.Comment_DeleteByObject   
   @ObjectId AS INT,   
   @ObjectType AS INT
AS
BEGIN	

   DELETE FROM  comments
   WHERE ObjectId = @ObjectId
	AND ObjectType = @ObjectType
	
END
GO
