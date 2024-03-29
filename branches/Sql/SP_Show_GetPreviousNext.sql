USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Show_Get]    Script Date: 10/27/2009 17:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[Show_GetPreviousNext]
   @ShowId AS INT 
AS
BEGIN	
SELECT * FROM
(
	 SELECT TOP 1              
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
			  [Status],
			  EndDate
    FROM shows With(nolock)  
	WHERE ShowId>=  @ShowId	
	    AND [Status] = 1
		AND ShowId != @ShowId 		
	ORDER BY ShowId ASC
) [Previous]
UNION
SELECT * FROM
(
	 SELECT TOP 1             
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
			  [Status],
			  EndDate
    FROM shows With(nolock)  
	WHERE ShowId<=  @ShowId
	  AND [Status] = 1
		AND ShowId != @ShowId		
	ORDER BY ShowId DESC	
) [Next]

ORDER BY ShowId DESC
  
 
END
