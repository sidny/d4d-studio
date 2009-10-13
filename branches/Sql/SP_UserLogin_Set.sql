
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xinweifeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.UserLogin_Set
   @UserId AS INT ,
   @UserName AS NVARCHAR(50),   
   @Password AS NVARCHAR(100),   
   @Email AS NVARCHAR(100)
AS
BEGIN

	SET NOCOUNT ON;
  
  
	UPDATE	userlogin
	SET		UserName = @UserName,[Password]=@Password,Email = @Email
	WHERE  UserId = @UserId 
	
	
	IF @@ROWCOUNT = 0
	BEGIN
		  INSERT INTO userlogin   
		  (UserId,
			   UserName,
			   [Password],			
			   Email			  
			   )
		  VALUES (@UserId, 
		  @UserName, 
		  @Password, 
		  @Email
		  )
	END  
END