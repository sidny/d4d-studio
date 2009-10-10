SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
CREATE PROCEDURE dbo.Tags_GetTopTag  
 @MaxCount AS INT
AS
BEGIN	
	SET ROWCOUNT @MaxCount
    SELECT    [TagId],[Name],[Hits],[AddUserID],[AddDate] 
    FROM tags With(nolock)
    ORDER BY Hits DESC
 
END
GO
