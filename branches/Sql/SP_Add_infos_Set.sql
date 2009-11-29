SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Add_infos_Set]
   @objectid AS INT ,
   @objecttype AS int,  
   @info1 AS NVARCHAR(4000), 
    @info2 AS NVARCHAR(4000), 
	 @info3 AS NVARCHAR(4000), 
	  @info4 AS NVARCHAR(4000)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE add_infos
    SET objectid = @objectid,objecttype=@objecttype,info1= @info1,
    info2=@info2,info3=@info3,info4=@info4
    WHERE objectid =  @objectid AND objecttype=@objecttype
	
	IF @@ROWCOUNT = 0
	BEGIN
	INSERT INTO add_infos
			   (objectid,
			   objecttype,
			   info1,
			   info2,
			  info3,
			   info4				  
			   )
		 VALUES
			   (@objectid,
			   @objecttype,
			   @info1,
			   @info2,
			  @info3,
			   @info4	
			 )
		
	END
  
 
    
  
	

END
