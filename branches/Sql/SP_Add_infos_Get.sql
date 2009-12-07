-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Add_infos_Get]   
      @objectid AS INT ,
   @objecttype AS int
AS
BEGIN	
	
    SELECT 
              objectid,
			   objecttype,
			   info1,
			   info2,
			  info3,
			   info4,
 			   info5,
			   info6,
			  info7,
			   info8		
    FROM add_infos With(nolock)
   WHERE objectid =  @objectid AND objecttype=@objecttype
 
END

GO
