-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_items_Get]   
   @id AS INT 
AS
BEGIN	
	
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
              body		
    FROM shop_items With(nolock)
    WHERE id =  @id
 
END

GO
