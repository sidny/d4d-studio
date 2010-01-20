
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_region_Delete]
   @Id AS INT 
AS
BEGIN	

   DELETE FROM  shop_region
   WHERE Id = @Id
   
	
END
