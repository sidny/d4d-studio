
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
			   [Status]		
    FROM shop_items With(nolock)
    WHERE id =  @id
 
END
