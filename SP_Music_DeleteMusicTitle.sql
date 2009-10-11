SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- Description:	Delete   MusicTitle
-- =============================================
CREATE PROCEDURE dbo.Music_DeleteMusicTitle
   @MusicId AS INT 
AS
BEGIN	

   DELETE FROM  music_title
   WHERE MusicId = @MusicId
   
   DELETE FROM music_songlist
   WHERE  MusicId = @MusicId
	
END
GO
