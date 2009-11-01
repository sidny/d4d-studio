USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[News_Set]    Script Date: 11/01/2009 17:51:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[SpamKeywords_Set]
   @Id AS INT ,
   @Keyword AS NVARCHAR(200),   
   @Status AS INT,    
   @AddUserId AS INT
AS
BEGIN	
	SET NOCOUNT ON;
  
    IF (@Id<=0)
   BEGIN 
	INSERT INTO SpamKeywords
			   (Keyword,		
			  [Status],
			  AddUserId,
			  AddDate
			   )
		 VALUES
			   (@Keyword,
				@Status,			 
			   @AddUserId,
			   GETDATE()
			 )
		SET @Id = @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE SpamKeywords
    SET  Keyword = @Keyword,AddUserId=@AddUserId,AddDate=GETDATE(), [Status]=@Status
    WHERE Id =  @Id
   END
	
	RETURN @Id
END
