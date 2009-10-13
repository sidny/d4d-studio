SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE dbo.Show_Get
   @ShowId AS INT 
AS
BEGIN	
	
    SELECT 
               ShowId, 
              Title,
			   Body,
			   SImage,
			   LImage,
			   BandId,
			   ShowDate,			  
			   ShowPlace,
			   AddUserId,
			   AddDate,
			  [Status]
    FROM shows With(nolock)
    WHERE ShowId =  @ShowId
 
END
GO
