USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Music_DeleteMusicTitle]    Script Date: 10/26/2009 18:21:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- Description:	Delete   MusicTitle
-- =============================================
ALTER PROCEDURE [dbo].[Music_DeleteMusicTitle]
   @MusicId AS INT 
AS
BEGIN	

   DELETE FROM  music_title
   WHERE MusicId = @MusicId
   
   DELETE FROM music_songlist
   WHERE  MusicId = @MusicId
	
END
