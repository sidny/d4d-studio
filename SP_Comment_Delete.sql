USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Comment_Delete]    Script Date: 10/26/2009 18:17:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- =============================================
ALTER PROCEDURE [dbo].[Comment_Delete]
    @CommentId AS INT
AS
BEGIN	

   DELETE FROM  comments
   WHERE CommentId = @CommentId 	
	
END
