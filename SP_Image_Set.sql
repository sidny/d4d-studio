
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xinweifeng
-- Create date: 2009-10-11
-- Description:	Add Or Set image
-- =============================================
CREATE PROCEDURE dbo.Image_Set
  @ImageId AS INT,
   @AlbumId AS INT ,
   @ImageName AS NVARCHAR(1000),    
   @ImageFile AS NVARCHAR(1000),
   @SImageFile AS NVARCHAR(1000),   
   @AddUserId AS INT,   
   @Status AS INT   
AS
BEGIN
	
	SET NOCOUNT ON;
  
    IF (@ImageId<=0)
   BEGIN 
	INSERT INTO images
			   (AlbumId,
			   ImageName,
			   ImageFile,
			   AddUserId,
			   AddDate,			 	
			   [Status],
			   SImageFile
			   )
		 VALUES
			   (@AlbumId,
			   @ImageName,
			   @ImageFile,
			   @AddUserId,
			   GETDATE(),			
			   @Status,
			   @SImageFile
			 )
		SET @ImageId = 	 @@IDENTITY 
		
		DECLARE @NEWCOUNT AS INT
		 SELECT @NEWCOUNT = COUNT(ImageID) FROM images
		   WHERE AlbumId = @AlbumId
		   
		   UPDATE albums
		   SET TotalCount = @NEWCOUNT
			WHERE AlbumId = @AlbumId
   END
   ELSE
   BEGIN
    UPDATE images
    SET  AlbumId = @AlbumId,ImageName=@ImageName,ImageFile= @ImageFile,
   AddUserId=@AddUserId,  AddDate=GETDATE(),[Status]=@Status,
   SImageFile=@SImageFile
    WHERE ImageId =  @ImageId
   END
	
	RETURN @ImageId
END
