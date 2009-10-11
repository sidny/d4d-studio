
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xinweifeng
-- Create date: 2009-10-11
-- Description:	Add Or Set Music SongList
-- =============================================
CREATE PROCEDURE dbo.Music_SetMusicSongList
   @ListId AS INT,
   @MusicId AS INT ,
   @SongName AS NVARCHAR(500),   
   @SongFile AS NVARCHAR(1000),   
   @SongTime AS NVARCHAR(50),   
   @AddUserId AS INT,   
   @Status AS INT
AS
BEGIN	
	SET NOCOUNT ON;  
    IF (@ListId<=0)
   BEGIN 
	INSERT INTO music_songlist
			   (MusicId,
			   SongName,
			   SongFile,
			   SongTime,
			   AddUserId,			 		
			   AddDate,
			  [Status]
			   )
		 VALUES
			   (@MusicId
			   ,@SongName
			   ,@SongFile		
			   ,@SongTime			
			   ,@AddUserId
			   ,GETDATE()
			   ,@Status
			 )
		SET @ListId = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE music_songlist
    SET  MusicId = @MusicId,SongName=@SongName,SongFile= @SongFile,
    SongTime=@SongTime,AddUserId=@AddUserId,AddDate=GETDATE(),  
    [Status]=@Status
    WHERE ListId =  @ListId
   END
	
	RETURN @ListId
END
