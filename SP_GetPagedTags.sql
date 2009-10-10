SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Get Tags by Paging
-- =============================================
CREATE PROCEDURE dbo.GetPagedTags		
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
			SELECT	TagId  
			FROM dbo.tags WITH(NOLOCK)		
			ORDER BY TagId DESC 	
	
		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   [TagId],[Name],[Hits],[AddUserID],[AddDate] 
		FROM dbo.Tags t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.TagId = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	    ORDER BY TagId DESC 
  
END

