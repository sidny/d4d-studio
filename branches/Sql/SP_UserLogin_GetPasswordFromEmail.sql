USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[UserLogin_GetPasswordFromEmail]    Script Date: 10/26/2009 18:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
ALTER PROCEDURE [dbo].[UserLogin_GetPasswordFromEmail]   
   @Email AS INT 
AS
BEGIN	
	
    SELECT 
              UserId, 
               UserName, 
               [Password],
			   Email
    FROM userlogin With(nolock)
    WHERE Email =  @Email
 
END
