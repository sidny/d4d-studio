USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Tags_GetTopTag]    Script Date: 10/28/2009 14:56:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
CREATE PROCEDURE [dbo].[News_GetTopImageNewsByNewsTypeANDPublishDate]  
 @RemarkType AS INT,
 @MaxCount AS INT,
 @NewsType AS INT,
 @STime DATETIME,
  @ETime DATETIME
AS
BEGIN	
	SET ROWCOUNT @MaxCount	
	
      IF (@RemarkType=1)--Video
      BEGIN
      	SELECT   
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
		FROM dbo.newsinfo  WITH(NOLOCK)
		WHERE NewsType=@NewsType 
		AND Remark='video' 
		AND  [Status] =1
		AND PublishDate>=@STime 
		AND PublishDate<=@ETime
		AND (SImage <> '' AND SIMAGE IS NOT NULL)
		ORDER BY PublishDate DESC
      END
      ELSE
      BEGIN
		  SELECT   
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
		FROM dbo.newsinfo  WITH(NOLOCK)
		WHERE NewsType=@NewsType
		 AND Remark<>'video'
		 AND  [Status] =1
		  AND PublishDate>=@STime 
		AND PublishDate<=@ETime
		AND (SImage <> '' AND SIMAGE IS NOT NULL)
		ORDER BY PublishDate DESC
      END
     
     

 
END
