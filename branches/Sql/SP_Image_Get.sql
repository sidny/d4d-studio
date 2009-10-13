USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Image_Get]    Script Date: 10/13/2009 21:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
ALTER PROCEDURE [dbo].[Image_Get]   
   @ImageId AS INT 
AS
BEGIN	
	
    SELECT 
              ImageId, 
               AlbumId, 
               ImageName,
			   ImageFile,			 
			   AddUserId,
			   AddDate,
			   [Status],			 
			  SImageFile
    FROM images With(nolock)
    WHERE ImageId =  @ImageId
 
END
