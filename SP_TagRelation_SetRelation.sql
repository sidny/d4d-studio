
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xinweifeng
-- Create date: 2009-10-11
-- Description:	Add Or Set tagrelation
-- =============================================
CREATE PROCEDURE dbo.TagRelation_SetRelation  
   @TagId AS INT,
   @ObjectId AS INT,   
   @ObjectType AS INT,
   @AddUserId AS INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
  
	UPDATE	tag_relation
	SET		AddUserId = @AddUserId,AddDate=GETDATE()
	WHERE TagId = @TagId 
	AND	ObjectId = @ObjectId
	AND ObjectType = @ObjectType
	
	IF @@ROWCOUNT = 0
	BEGIN
		  INSERT INTO tag_relation   
		  (TagId,
			   ObjectId,
			   ObjectType,			
			   AddUserId,
			   AddDate		  
			   )
		  VALUES (@TagId, 
		  @ObjectId, 
		  @ObjectType, 
		  @AddUserId,
		  GETDATE())
	END  
END
