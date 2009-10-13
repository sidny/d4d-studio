SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.News_Delete
   @NewsId AS INT 
AS
BEGIN	

   DELETE FROM  newsinfo
   WHERE NewsId = @NewsId
  
	
END
GO
