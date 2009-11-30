SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_tradelist_Set]
   @id AS INT ,
   @orderid AS int, 
   @itemid AS int, 
   @itemcount AS int
  
AS
BEGIN
	
	SET NOCOUNT ON;
  
    IF (@id<=0)
   BEGIN 
	INSERT INTO shop_tradelist
			   (orderid,
			   itemid,
			   itemcount
			   )
		 VALUES
			   (@orderid,
			   @itemid,
			   @itemcount
			 )
		SET @id = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE shop_tradelist
    SET orderid = @orderid,itemid=@itemid,itemcount= @itemcount
    WHERE id =  @id
   END
	
	RETURN @id 
END
