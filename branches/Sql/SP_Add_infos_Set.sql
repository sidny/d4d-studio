-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Add_infos_Set]
   @objectid AS INT ,
   @objecttype AS int,  
   @info1 AS NVARCHAR(4000), 
    @info2 AS NVARCHAR(4000), 
	 @info3 AS NVARCHAR(4000), 
	  @info4 AS NVARCHAR(4000),
   @info5 AS NVARCHAR(4000), 
    @info6 AS NVARCHAR(4000), 
	 @info7 AS NVARCHAR(4000), 
	  @info8 AS NVARCHAR(4000)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	UPDATE add_infos
    SET objectid = @objectid,objecttype=@objecttype,info1= @info1,
    info2=@info2,info3=@info3,info4=@info4,info5= @info5,
    info6=@info6,info7=@info7,info8=@info8
    WHERE objectid =  @objectid AND objecttype=@objecttype
	
	IF @@ROWCOUNT = 0
	BEGIN
	INSERT INTO add_infos
			   (objectid,
			   objecttype,
			   info1,
			   info2,
			  info3,
			   info4,
 			   info5,
			   info6,
			  info7,
			   info8					  
			   )
		 VALUES
			   (@objectid,
			   @objecttype,
			   @info1,
			   @info2,
			  @info3,
			   @info4,
   			  @info5,
			   @info6,
			  @info7,
			   @info8			
			 )
		
	END
  
 
    
  
	

END

GO
