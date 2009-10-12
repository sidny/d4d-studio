SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- Description:	Delete   Album
-- =============================================
CREATE PROCEDURE dbo.Album_Delete
   @AlbumId AS INT 
AS
BEGIN	

   DELETE FROM  albums
   WHERE AlbumId = @AlbumId
   
   DELETE FROM images
   WHERE  AlbumId = @AlbumId
	
END
GO
