-- =============================================
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[Shop_items_GetPaged]
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
			SELECT	id  
			FROM dbo.shop_items WITH(NOLOCK)		
			ORDER BY id DESC 	
	END
	ELSE 
	BEGIN
	        INSERT INTO 
			@Results (Id)
			SELECT	id  
			FROM dbo.shop_items WITH(NOLOCK)	
			WHERE [Status] =@PublishStatus 	
			ORDER BY id DESC 	
	END 
	
		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		       t.Id, 
               name,
			   description,
			   price,
			   SImage,
			  LImage,
			   PublishDate,			
			   AddUserId,
			   AddDate,			
			   [Status],
                                           body,
                                           Hits,
BaseCountEachdeliver										   
		FROM dbo.shop_items t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.Id = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	   ORDER BY t.id DESC 	
  
END
GO
