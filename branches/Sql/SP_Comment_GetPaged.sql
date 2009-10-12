SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10

-- =============================================
CREATE PROCEDURE dbo.Comment_GetPaged		
  @PublishStatus INT ,
     @ObjectId AS INT,   
     @ObjectType AS INT,
	@PageIndex INT,
	@PageSize INT,	
	@NumberOfCount INT OUTPUT
AS
BEGIN	
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET LOCK_TIMEOUT 2000
	
	DECLARE @StartRow int
	IF @PageIndex = 0
		SET @PageIndex = 1
	SET @StartRow = (@PageIndex -1) * @PageSize + 1
	
	DECLARE @Results TABLE (Pos INT IDENTITY, Id INT)
	
	DECLARE @RowCount int
	SET @RowCount = @PageSize + @StartRow - 1

	IF (@PublishStatus=2) --ALL
	BEGIN
	
			INSERT INTO 
			@Results (Id)
			SELECT	CommentId  
			FROM dbo.comments WITH(NOLOCK)		
			ORDER BY CommentId DESC 	
	END
	ELSE 
	BEGIN
	       INSERT INTO 
			@Results (Id)
			SELECT	CommentId  
			FROM dbo.comments WITH(NOLOCK)		
			WHERE [Status] =@PublishStatus 	
			ORDER BY CommentId DESC 	
	END 
	
		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		      CommentId, 
              ObjectId,
			   ObjectType,
			   UserId,
			   UserName,
			   AddDate,
			   Body,			
			    Remark,
			   [Status]	
		FROM dbo.comments t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.CommentId = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	   ORDER BY CommentId DESC 	
  
END




	

 



