SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- Description:	Add One Music Title
-- =============================================
CREATE PROCEDURE dbo.Music_GetMusicTitle    
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
GO
