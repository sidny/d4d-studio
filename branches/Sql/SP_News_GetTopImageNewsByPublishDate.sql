USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[News_GetTopImageNewsByPublishDate]    Script Date: 11/02/2009 22:05:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Add One TagsHits
-- =============================================
ALTER PROCEDURE [dbo].[News_GetTopImageNewsByPublishDate]  
 @RemarkType AS INT,
 @MaxCount AS INT,
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
		WHERE  Remark='video' 
		AND  [Status] =1
		AND PublishDate>=@STime 
		AND PublishDate<=@ETime
		AND (SImage <> '' AND SIMAGE IS NOT NULL)
		ORDER BY PublishDate DESC, NewsId DESC
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
		WHERE  Remark<>'video'
		 AND  [Status] =1
		  AND PublishDate>=@STime 
		AND PublishDate<=@ETime
		AND (SImage <> '' AND SIMAGE IS NOT NULL)
		ORDER BY PublishDate DESC, NewsId DESC
      END
     
     

 
END
