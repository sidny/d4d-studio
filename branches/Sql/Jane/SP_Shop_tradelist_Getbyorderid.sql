
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_tradelist_Getbyorderid]   
   @orderid AS INT 
AS
BEGIN	
	
    SELECT 
               Id, 
              orderid,
			   itemid,
			   itemcount
    FROM Shop_tradelist With(nolock)
    WHERE orderid =  @orderid
 
END
