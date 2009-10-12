SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.Image_Get   
   @ImageId AS INT 
AS
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
    WHERE ImageId =  @ImageId
 
END
GO
