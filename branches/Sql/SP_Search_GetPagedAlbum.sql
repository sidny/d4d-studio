USE [d4d]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Search_GetPagedAlbum] 
   @SearchTxt AS NVARCHAR(100) ,  
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
	select AlbumId  from dbo.albums with(nolock)
	where [status]=1 AND
	title like '%'+@SearchTxt+'%' 
	or AlbumId IN
	(
	select objectid from dbo.tag_relation with(nolock)
	where ObjectType = 4 
	AND TagId IN(
	select id from  dbo.tag with(nolock)
	where Name like '%'+@SearchTxt+'%' )
	)
	ORDER BY AlbumId DESC

		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		       AlbumId, 
               Title,
               '' AS BODY,
			   Simage	  
		FROM dbo.albums t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.AlbumId = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	   ORDER BY AlbumId DESC 	
  
END
 

