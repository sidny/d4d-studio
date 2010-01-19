-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_items_GetTopPublishedShopItemsOrderByHits]   
   @MaxCount AS INT
AS
BEGIN	
   SET ROWCOUNT @MaxCount	
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
BaseCountEachdeliver			  
    FROM shop_items With(nolock)
    WHERE [Status] = 1 
	ORDER BY Hits DESC, PublishDate DESC
 
END
GO
