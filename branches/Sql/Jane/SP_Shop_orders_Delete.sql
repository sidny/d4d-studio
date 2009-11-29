
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_orders_Delete]
   @Id AS INT 
AS
BEGIN	

   DELETE FROM  shop_orders
   WHERE Id = @Id
   
	
END
