
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xinweifeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.News_Set
   @NewsId AS INT ,
   @Title AS NVARCHAR(500),   
   @Body AS NVARCHAR(4000),   
   @Preview AS NVARCHAR(2000),   
   @SImage AS NVARCHAR(1000),
   @LImage AS NVARCHAR(1000),
   @NewsType AS INT,
   @Hits AS INT,
   @PublishDate AS DATETIME,   
   @AddUserId AS INT,   
   @Status AS INT,
   @Remark AS NVARCHAR(1000)
AS
BEGIN	
	SET NOCOUNT ON;
  
    IF (@NewsId<=0)
   BEGIN 
	INSERT INTO newsinfo
			   (Title,
			   Body,
			   Preview,
			   SImage,
			   LImage,
			   NewsType,
			   Hits,
			   PublishDate,
			   AddUserId,
			   AddDate,
			  [Status],
			  Remark
			   )
		 VALUES
			   (@Title,
			   @Body,
			   @Preview,
			   @SImage,
			   @LImage,
			  @NewsType,
			   @Hits,
			   @PublishDate,
			   @AddUserId,
			   GETDATE(),
			  @Status,
			  @Remark
			 )
		SET @NewsId = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE newsinfo
    SET  Title = @Title,Body=@Body,Preview=@Preview,SImage= @SImage,
    LImage=@LImage,NewsType=@NewsType,Hits=@Hits,PublishDate=@PublishDate,
    AddUserId=@AddUserId,AddDate=GETDATE(), [Status]=@Status,Remark=@Remark
    WHERE NewsId =  @NewsId
   END
	
	RETURN @NewsId
END
