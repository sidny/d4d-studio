USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Show_Delete]    Script Date: 10/26/2009 18:26:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
ALTER PROCEDURE [dbo].[Show_Delete]
   @ShowId AS INT 
AS
BEGIN	

   DELETE FROM  shows
   WHERE ShowId = @ShowId  
  
	
END
