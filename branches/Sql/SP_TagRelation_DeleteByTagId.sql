SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Delete  One TagRelation by TagId
-- =============================================
CREATE PROCEDURE dbo.TagRelation_DeleteByTagId
    @TagId AS INT  
AS
BEGIN	

   DELETE FROM  tag_relation
   WHERE TagId = @TagId 	
	
END
GO
