
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xinweifeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.Show_Set
   @ShowId AS INT ,
   @Title AS NVARCHAR(500),   
   @Body AS NVARCHAR(4000),   
   @SImage AS NVARCHAR(1000),
   @LImage AS NVARCHAR(1000),
   @BandId AS INT,
   @ShowDate AS DATETIME,
   @EndDate AS DATETIME,
   @ShowPlace AS NVARCHAR(500),   
   @AddUserId AS INT,   
   @Status AS INT
AS
BEGIN	
	SET NOCOUNT ON;
  
    IF (@ShowId<=0)
   BEGIN 
	INSERT INTO shows
			   (Title,
			   Body,
			   SImage,
			   LImage,
			   BandId,
			   ShowDate,			  
			   ShowPlace,
			   AddUserId,
			   AddDate,
			  [Status],
			  EndDate
			   )
		 VALUES
			   (@Title
			   ,@Body
			   ,@SImage		
			   ,@LImage
			   ,	@BandId
			   ,@ShowDate
			   ,@ShowPlace
			   ,@AddUserId
			   ,GETDATE()
			   ,@Status,
			   @EndDate
			 )
		SET @ShowId = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE shows
    SET  Title = @Title,Body=@Body,SImage= @SImage,
    LImage=@LImage,BandId=@BandId,ShowDate=@ShowDate,
    ShowPlace=@ShowPlace,AddUserId=@AddUserId,AddDate=GETDATE(),
    [Status]=@Status,EndDate=@EndDate
    WHERE ShowId =  @ShowId
   END
	
	RETURN @ShowId
END
