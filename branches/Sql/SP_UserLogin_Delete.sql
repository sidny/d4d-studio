USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[UserLogin_Delete]    Script Date: 10/26/2009 18:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- =============================================
ALTER PROCEDURE [dbo].[UserLogin_Delete]
    @UserId AS INT
AS
BEGIN	

   DELETE FROM  userlogin
   WHERE UserId = @UserId 
	
END
