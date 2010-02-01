-- =============================================
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[News_GetPreviousNextV3WithBandType]
   @NewsId AS INT ,
   @NewsType AS INT
AS
BEGIN	
SELECT * FROM
(
	 SELECT TOP 1
               NewsId ,
               Title,
			   Body,
			   Preview,
			   SImage,
			   LImage,
			   NewsType,
			   Hits,
			   PublishDate,
			   AddUserId,
			   AddDate,
			  [Status],
			  Remark
    FROM newsinfo With(nolock)  
	WHERE NewsId>=  @NewsId	
	AND NewsType=@NewsType	
	    AND [Status] = 1
		AND NewsId != @NewsId 		
	ORDER BY NewsId ASC
) [Previous]
UNION
SELECT * FROM
(
	 SELECT TOP 1
               NewsId ,
               Title,
			   Body,
			   Preview,
			   SImage,
			   LImage,
			   NewsType,
			   Hits,
			   PublishDate,
			   AddUserId,
			   AddDate,
			  [Status],
			  Remark
    FROM newsinfo With(nolock)  
	WHERE NewsId<=  @NewsId	
	AND NewsType=@NewsType	
	  AND [Status] = 1
		AND NewsId != @NewsId 		
	ORDER BY NewsId DESC	
) [Next]
ORDER BY NewsId DESC
   
 
END

GO
