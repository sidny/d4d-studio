USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Tags_GetTopTag]    Script Date: 10/26/2009 18:30:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
ALTER PROCEDURE [dbo].[Tags_GetTopTag]  
 @MaxCount AS INT
AS
BEGIN	
	SET ROWCOUNT @MaxCount
    SELECT    [TagId],[Name],[Hits],[AddUserID],[AddDate] 
    FROM tags With(nolock)
    ORDER BY Hits DESC
 
END
