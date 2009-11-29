
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- Description:	Delete   shop items
-- =============================================
CREATE PROCEDURE [dbo].[Shop_items__Delete]
   @Id AS INT 
AS
BEGIN	

   DELETE FROM  shop_items
   WHERE Id = @Id
   
	
END
