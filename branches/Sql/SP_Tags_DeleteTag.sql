SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Delete  One Tag
-- =============================================
CREATE PROCEDURE dbo.Tags_DeleteTag
   @TagID AS INT 
AS
BEGIN	

   DELETE FROM  [tags]
   WHERE TagId = @TagID	
	
END
GO
