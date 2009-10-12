SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.Show_Delete
   @ShowId AS INT 
AS
BEGIN	

   DELETE FROM  shows
   WHERE ShowId = @ShowId  
  
	
END
GO
