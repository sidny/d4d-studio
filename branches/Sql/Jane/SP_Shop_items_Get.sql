-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_items_Get]   
   @id AS INT ,
   @Hits as INT = 0
AS
BEGIN	
   	if @Hits > 0 
		UPDATE shop_items
		SET  [Hits] = [Hits]+1
		WHERE Id = @id
	
    SELECT 
               Id, 
               name,
			   description,
			   price,
			   SImage,
			  LImage,
			   PublishDate,			
			   AddUserId,
			   AddDate,			
			   [Status],
                body,
			  Hits,
         BaseCountEachdeliver,
		 Weight
    FROM shop_items With(nolock)
    WHERE id =  @id
 
END
GO
