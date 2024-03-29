USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Image_GetByAlbumId]    Script Date: 10/26/2009 17:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
ALTER PROCEDURE [dbo].[Image_GetByAlbumId]    
 @PublishStatus INT ,
   @AlbumId AS INT    
AS
BEGIN	
	IF ( @PublishStatus =2)
	BEGIN
    SELECT 
             ImageId, 
               AlbumId, 
               ImageName,
			   ImageFile,			 
			   AddUserId,
			   AddDate,
			   [Status],			 
			  SImageFile,
			  PublishDate
    FROM images With(nolock)
    WHERE AlbumId =  @AlbumId
 END
 ELSE
 BEGIN
      SELECT 
             ImageId, 
               AlbumId,
               ImageName,
			   ImageFile,			 
			   AddUserId,
			   AddDate,
			   [Status],			 
			  SImageFile,
			  PublishDate
    FROM images With(nolock)
    WHERE AlbumId =  @AlbumId AND [Status]= @PublishStatus
 END 
END
