
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xinweifeng
-- Create date: 2009-10-11
-- Description:	Add Or Set MusicTitle
-- =============================================
CREATE PROCEDURE dbo.Music_SetMusicTitle
   @MusicId AS INT ,
   @Title AS NVARCHAR(200),   
   @Body AS NVARCHAR(4000),   
   @SImage AS NVARCHAR(1000),
   @LImage AS NVARCHAR(1000),
   @BandId AS INT,
   @PublishDate AS DATETIME,
   @PublishYear AS INT,
   @AddUserId AS INT,   
   @Status AS INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
    IF (@MusicId<=0)
   BEGIN 
	INSERT INTO music_title
			   (Title,
			   Body,
			   SImage,
			   LImage,
			   BandId,
			   PublishDate,
			   PublishYear,
			   AddUserId,
			   AddDate,
			  [Status]
			   )
		 VALUES
			   (@Title
			   ,@Body
			   ,@SImage		
			   ,@LImage
			   ,	@BandId
			   ,@PublishDate
			   ,@PublishYear
			   ,@AddUserId
			   ,GETDATE()
			   ,@Status
			 )
		SET @MusicId = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE music_title
    SET  Title = @Title,Body=@Body,SImage= @SImage,
    LImage=@LImage,BandId=@BandId,PublishDate=@PublishDate,
    PublishYear=@PublishYear,AddUserId=@AddUserId,AddDate=GETDATE(),
    [Status]=@Status
    WHERE MusicId =  @MusicId
   END
	
	RETURN @MusicId
END
