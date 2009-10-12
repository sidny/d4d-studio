SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.Album_Get   
   @AlbumId AS INT 
AS
BEGIN	
	
    SELECT 
               AlbumId 
               Title,
			   BandId,
			   PublishDate,
			   PublishYear,
			   PublishMonth,
			   AddUserId,
			   AddDate,
			   [Status],
			   TotalCount,
			  SImage,
			  LImage
    FROM albums With(nolock)
    WHERE AlbumId =  @AlbumId
 
END
GO
