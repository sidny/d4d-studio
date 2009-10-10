SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
CREATE PROCEDURE dbo.Tags_AddTagHits    
   @TagID AS INT 
AS
BEGIN	
	
    UPDATE [tags]
    SET  [Hits] = [Hits]+1
    WHERE TagId =  @TagID
 
END
GO
