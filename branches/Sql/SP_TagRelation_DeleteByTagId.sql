USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[TagRelation_DeleteByTagId]    Script Date: 10/26/2009 18:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Delete  One TagRelation by TagId
-- =============================================
ALTER PROCEDURE [dbo].[TagRelation_DeleteByTagId]
    @TagId AS INT  
AS
BEGIN	

   DELETE FROM  tag_relation
   WHERE TagId = @TagId 	
	
END
