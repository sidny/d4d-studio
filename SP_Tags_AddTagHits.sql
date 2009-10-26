USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Tags_AddTagHits]    Script Date: 10/26/2009 18:29:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
ALTER PROCEDURE [dbo].[Tags_AddTagHits]    
   @TagID AS INT 
AS
BEGIN	
	
    UPDATE [tags]
    SET  [Hits] = [Hits]+1
    WHERE TagId =  @TagID
 
END
