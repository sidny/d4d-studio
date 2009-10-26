USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Tags_GetTag]    Script Date: 10/26/2009 18:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
ALTER PROCEDURE [dbo].[Tags_GetTag]    
   @TagID AS INT 
AS
BEGIN	
	
    SELECT [TagId],[Name],[Hits],[AddUserID],[AddDate] 
    FROM tags With(nolock)
    WHERE TagId =  @TagID
 
END
