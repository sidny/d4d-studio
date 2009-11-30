USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Tags_AddTagHits]    Script Date: 11/02/2009 15:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
CREATE PROCEDURE [dbo].[Tags_AddTagHitsV2]    
   @TagIDStr AS Varchar(100)
AS
BEGIN	
	
    UPDATE [tags]
    SET  [Hits] = [Hits]+1
    WHERE TagId in (@TagIDStr)
 
END
