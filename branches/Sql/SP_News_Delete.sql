USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[News_Delete]    Script Date: 10/26/2009 18:24:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
ALTER PROCEDURE [dbo].[News_Delete]
   @NewsId AS INT 
AS
BEGIN	

   DELETE FROM  newsinfo
   WHERE NewsId = @NewsId
  
	
END
