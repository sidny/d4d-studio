
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xinweifeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.Comment_Insert 
   @ObjectId AS INT,
   @ObjectType AS INT,
   @UserId AS INT,   
   @UserName AS NVARCHAR(200),
   @AddDate AS DATETIME,
   @Body  AS NVARCHAR(4000),
   @Remark AS NVARCHAR(1000),   
   @Status AS INT   
AS
BEGIN
	
	SET NOCOUNT ON;  
 
	INSERT INTO comments
			   (ObjectId,
			   ObjectType,
			   UserId,
			   UserName,
			   AddDate,
			   Body,			
			    Remark,
			   [Status]		
			   )
		 VALUES
			   (@ObjectId,
			   @ObjectType,
			   @UserId,
			   @UserName,
			   GETDATE(),
			   @Body,			
			   @Remark,
			   @Status
			 )
	RETURN @@IDENTITY 
END
