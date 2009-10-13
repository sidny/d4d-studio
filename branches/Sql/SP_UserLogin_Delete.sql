SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- =============================================
CREATE PROCEDURE dbo.UserLogin_Delete
    @UserId AS INT
AS
BEGIN	

   DELETE FROM  userlogin
   WHERE UserId = @UserId 
	
END
GO
