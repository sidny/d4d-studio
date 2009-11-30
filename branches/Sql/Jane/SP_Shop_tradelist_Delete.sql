
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_tradelist_Delete]   
   @id AS INT 
AS
BEGIN	
	
   DELETE    FROM Shop_tradelist
    WHERE id =  @id
 
END
