USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[News_Delete]    Script Date: 11/01/2009 17:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[SpamKeywords_Delete]
   @Id AS INT 
AS
BEGIN	

   DELETE FROM  SpamKeywords
   WHERE Id = @Id
  
	
END
