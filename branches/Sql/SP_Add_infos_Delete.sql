
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Add_infos_Delete]
     @objecttype as int,
   @objectid as  int 
AS
BEGIN	

   DELETE FROM  add_infos
    WHERE objectid =  @objectid AND objecttype=@objecttype
   
	
END
