SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- Description:	Add One Music SongList
-- =============================================
CREATE PROCEDURE dbo.Music_GetMusicSongListByMusicId    
   @MusicId AS INT 
AS
BEGIN	
	
    SELECT 
              ListId, 
              MusicId,
			   SongName,
			   SongFile,
			   SongTime,
			   AddUserId,			 		
			   AddDate,
			  [Status]
    FROM music_songlist With(nolock)
    WHERE MusicId =  @MusicId
 
END
GO
