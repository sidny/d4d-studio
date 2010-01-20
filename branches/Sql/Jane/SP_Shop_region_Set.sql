-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_region_Set]
   @id AS INT ,  
   @Name AS NVARCHAR(50), 
      @ParentId AS INT ,  
   @TransferPrice AS float, 
@TransferPrice1 AS float, 
@TransferPrice2 AS float
AS
BEGIN
	
	SET NOCOUNT ON;
  
    IF (@id<=0)
   BEGIN 
	INSERT INTO shop_region
			   (Name,
			   ParentId,
			   TransferPrice,
			   TransferPrice1,
			  TransferPrice2
			   )
		 VALUES
			   (@Name,
			   @ParentId,
			   @TransferPrice,
			   @TransferPrice1,
			   @TransferPrice2
			 )
		SET @id = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE shop_region
    SET Name = @Name,ParentId=@ParentId,TransferPrice= @TransferPrice,
    TransferPrice1=@TransferPrice1,TransferPrice2=@TransferPrice2
    WHERE id =  @id
   END
	
	RETURN @id 
END
GO
