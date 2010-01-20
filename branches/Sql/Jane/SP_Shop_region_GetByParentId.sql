-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_region_GetByParentId]   
   @ParentId AS INT 
AS
BEGIN	
	
    SELECT 
               Id, 
               Name,
			   ParentId,
			   TransferPrice,
			   TransferPrice1,
			  TransferPrice2
    FROM shop_region With(nolock)
    WHERE ParentId =  @ParentId
 
END

GO
