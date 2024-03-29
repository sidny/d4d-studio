USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Music_GetMusicTitle]    Script Date: 10/26/2009 18:22:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- Description:	Add One Music Title
-- =============================================
ALTER PROCEDURE [dbo].[Music_GetMusicTitle]    
   @MusicId AS INT 
AS
BEGIN	
	
    SELECT 
               MusicId, 
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
    FROM music_title With(nolock)
    WHERE MusicId =  @MusicId
 
END
