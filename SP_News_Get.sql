USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[News_Get]    Script Date: 10/26/2009 18:24:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
ALTER PROCEDURE [dbo].[News_Get]
   @NewsId AS INT 
AS
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
    FROM newsinfo With(nolock)
    WHERE NewsId =  @NewsId
 
END
