-- =============================================
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[Shop_orders_GetPaged]
    @ordertype INT ,
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

	IF (@ordertype=2) --ALL
	BEGIN
	
			INSERT INTO 
			@Results (Id)
			SELECT	id  
			FROM dbo.shop_orders WITH(NOLOCK)		
			ORDER BY id DESC 	
	END
	ELSE 
	BEGIN
	        INSERT INTO 
			@Results (Id)
			SELECT	id  
			FROM dbo.shop_orders WITH(NOLOCK)	
			WHERE ordertype =@ordertype 	
			ORDER BY id DESC 	
	END 
	
		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		       t.Id, 
               userid,
			   addDate,
			   ordertype,
			   address,
			  email,
			   mobile,			
			   paymoney,
			   paytype,			
			   payresult,
				payremark,
				paythirdnum,
				paydate,
     				zipcode,
				username,
				RegionId,
				Freight
		FROM dbo.shop_orders t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.Id = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	   ORDER BY t.id DESC 	
  
END
GO
