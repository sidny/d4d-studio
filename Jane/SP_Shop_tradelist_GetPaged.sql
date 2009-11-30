
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[Shop_tradelist_GetPaged]
    @orderid INT ,
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


	
			INSERT INTO 
			@Results (Id)
			SELECT	id  
			FROM dbo.shop_tradelist WITH(NOLOCK)
			where orderid=@orderid
			ORDER BY id DESC 	
	
	
		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		       t.Id, 
              orderid,
			   itemid,
			   itemcount
		FROM dbo.shop_tradelist t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.Id = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	   ORDER BY t.id DESC 	
  
END




	

 

