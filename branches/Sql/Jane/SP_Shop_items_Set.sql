﻿-- =============================================
-- Create date: 2009-11-29
-- Description:	Add Or Set shop_items
-- =============================================
CREATE PROCEDURE [dbo].[Shop_items_Set]
   @id AS INT ,
   @name AS NVARCHAR(2000),    
   @description AS NVARCHAR(4000), 
   @body AS NVARCHAR(4000), 
   @price AS float, 
   @SImage AS NVARCHAR(1000),
   @LImage AS NVARCHAR(1000),  
   @PublishDate AS DATETIME,
   @AddUserId AS INT,   
   @Status AS INT ,
   @Hits   AS INT = 0,
   @BaseCountEachdeliver AS INT= 5,
   @Weight AS float= 1000
AS
BEGIN
	
	SET NOCOUNT ON;
  
    IF (@id<=0)
   BEGIN 
	INSERT INTO shop_items
			   (name,
			   description,
			   body,
			   price,
			   SImage,
			  LImage,
			   PublishDate,			
			   AddUserId,
			   AddDate,			
			   [Status]	,
              Hits,
			  BaseCountEachdeliver,
			  Weight
			   )
		 VALUES
			   (@name,
			   @description,
                                           @body,
			   @price,
			   @SImage,
			   @LImage,
			   @PublishDate,
			   @AddUserId,
			   GETDATE(),			
			   @Status,
				@Hits,
				@BaseCountEachdeliver,
				@Weight
			 )
		SET @id = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE shop_items
    SET name = @name,description=@description,body=@body,price= @price,
    SImage=@SImage,LImage=@LImage,PublishDate=@PublishDate,
    AddDate=GETDATE(),[Status]=@Status,   AddUserId=@AddUserId,
	Hits=@Hits	,BaseCountEachdeliver=@BaseCountEachdeliver,Weight=@Weight
    WHERE id =  @id
   END
	
	RETURN @id 
END
GO
