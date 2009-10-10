SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
CREATE PROCEDURE dbo.Tags_GetTag    
   @TagID AS INT 
AS
BEGIN	
	
    SELECT [TagId],[Name],[Hits],[AddUserID],[AddDate] 
    FROM tags With(nolock)
    WHERE TagId =  @TagID
 
END
GO
