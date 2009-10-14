SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[Album_GetPagedByTagANDBand]
  @BandId INT,
   @TagId INT,
    @PublishStatus INT ,
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
			SELECT	AlbumId  
			FROM dbo.albums WITH(NOLOCK)	
			WHERE BandId = @BandId AND
			 AlbumID IN
			(SELECT ObjectId    FROM tag_relation WITH(NOLOCK) WHERE TagId = @TagId AND ObjectType=4)--4 is album	
			ORDER BY PublishDate DESC 	
	END
	ELSE 
	BEGIN
	        INSERT INTO 
			@Results (Id)
			SELECT	AlbumId  
			FROM dbo.albums WITH(NOLOCK)	
			WHERE [Status] =@PublishStatus 	AND BandId=@BandId 
			AND AlbumID IN
			(SELECT ObjectId    FROM tag_relation WITH(NOLOCK) WHERE TagId = @TagId AND ObjectType=4)--4 is album	
			ORDER BY PublishDate DESC 	
	END 
	
		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		         AlbumId, 
               Title,
			   BandId,
			   PublishDate,
			   PublishYear,
			   PublishMonth,
			   AddUserId,
			   AddDate,
			   [Status],
			   TotalCount,
			  SImage,
			  LImage
		FROM dbo.albums t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.AlbumId = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	   ORDER BY PublishDate DESC 	
  
END




	

 

