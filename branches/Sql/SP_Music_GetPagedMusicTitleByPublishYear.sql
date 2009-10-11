SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- Description:	GetPagedMusicTitleByPublishYear 
-- =============================================
CREATE PROCEDURE dbo.Music_GetPagedMusicTitleByPublishYear 
   @PublishYear AS INT, 
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
			SELECT	MusicId  
			FROM dbo.music_title WITH(NOLOCK)		
			WHERE PublishYear=@PublishYear
			ORDER BY PublishDate DESC 	
	
		
	SET @NumberOfCount = @@ROWCOUNT


		SELECT   
		       MusicId 
               Title,
			   Body,
			   SImage,
			   LImage,
			   BandId,
			   PublishDate,
			   PublishYear,
			   AddUserId,
			   AddDate,
			  [Status]
		FROM dbo.music_title t WITH(NOLOCK)
		INNER JOIN @Results r ON  (t.MusicId = r.Id)	
		WHERE 
			r.Pos BETWEEN @StartRow AND @RowCount	
	   ORDER BY PublishDate DESC 	
  
END
 

