SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- Description:	Delete  One MusicSonglist
-- =============================================
CREATE PROCEDURE dbo.Music_DeleteSongList
   @ListId AS INT 
AS
BEGIN	

   DELETE FROM  music_songlist
   WHERE ListId = @ListId	
	
END
GO
