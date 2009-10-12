SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- Description:	Delete  Images by albumID
-- =============================================
CREATE PROCEDURE dbo.Image_DeleteByAlbumId
   @AlbumId AS INT 
AS
BEGIN	   
   
   DELETE FROM images
   WHERE  AlbumId = @AlbumId  

   
   UPDATE albums
   SET TotalCount = 0
    WHERE AlbumId =@AlbumId
	
END
GO

