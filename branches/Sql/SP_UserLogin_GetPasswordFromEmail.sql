SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.UserLogin_GetPasswordFromEmail   
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
GO
