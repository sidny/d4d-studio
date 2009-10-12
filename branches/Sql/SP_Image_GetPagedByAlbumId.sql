SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[Image_GetPagedByAlbumId]
    @PublishStatus INT ,
    @AlbumId AS INT,    
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
			SELECT	ImageId  
			FROM dbo.images WITH(NOLOCK)		
			WHERE AlbumId=@AlbumId 			
	END
	ELSE 
	BEGIN
	        INSERT INTO 
			@Results (Id)
			SELECT	ImageId  
			FROM dbo.images WITH(NOLOCK)	
			WHERE [Status] =@PublishStatus AND	 AlbumId=@AlbumId 	
	END 
	
		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		         ImageId, 
               AlbumId 
               ImageName,
			   ImageFile,			 
			   AddUserId,
			   AddDate,
			   [Status],			 
			  SImageFile
		FROM dbo.images t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.ImageId = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount		
  
END




	

 

