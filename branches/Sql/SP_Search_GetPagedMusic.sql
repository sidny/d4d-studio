USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Search_GetPagedMusic]    Script Date: 10/29/2009 11:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Search_GetPagedMusic] 
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
	select musicId  from dbo.music_title with(nolock)
	where [status]=1 AND
	(title like '%'+@SearchTxt+'%'  or body like '%'+@SearchTxt+'%')
	or musicId IN
	(
	select objectid from dbo.tag_relation with(nolock)
	where ObjectType = 2
	AND TagId IN(
	select id from  dbo.tag with(nolock)
	where Name like '%'+@SearchTxt+'%' )
	)
	ORDER BY musicId DESC

		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		       musicId, 
               Title,
               Body,
			   Simage,
			   BandId,
			   PublishDate	  
		FROM dbo.music_title t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.musicId = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	   ORDER BY musicId DESC 	
  
END
 

