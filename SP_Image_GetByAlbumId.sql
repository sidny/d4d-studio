SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[Image_GetByAlbumId]    
 @PublishStatus INT ,
   @AlbumId AS INT    
AS
BEGIN	
	IF ( @PublishStatus =2)
	BEGIN
    SELECT 
             ImageId, 
               AlbumId 
               ImageName,
			   ImageFile,			 
			   AddUserId,
			   AddDate,
			   [Status],			 
			  SImageFile
    FROM images With(nolock)
    WHERE AlbumId =  @AlbumId
 END
 ELSE
 BEGIN
      SELECT 
             ImageId, 
               AlbumId 
               ImageName,
			   ImageFile,			 
			   AddUserId,
			   AddDate,
			   [Status],			 
			  SImageFile
    FROM images With(nolock)
    WHERE AlbumId =  @AlbumId AND [Status]= @PublishStatus
 END 
END
