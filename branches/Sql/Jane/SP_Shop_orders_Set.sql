SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_orders_Set]
   @id AS INT ,
   @userid AS int,
   @addDate as DATETIME,   
   @ordertype AS int,
   @address AS NVARCHAR(4000), 
    @email AS NVARCHAR(500), 
	@mobile AS NVARCHAR(100), 
   @paymoney AS decimal(19, 4), 
 @paytype AS INT   ,
  @payresult AS INT   ,
   @payremark AS NVARCHAR(4000), 
    @paythirdnum AS NVARCHAR(1000)   ,
   @paydate AS DATETIME   
AS
BEGIN
	
	SET NOCOUNT ON;
  
    IF (@id<=0)
   BEGIN 
	INSERT INTO shop_orders
			   (userid,
			   addDate,
			   ordertype,
			   address,
			  email,
			   mobile,			
			   paymoney,
			   paytype,			
			   payresult,
				payremark,
				paythirdnum,
				paydate
			   )
		 VALUES
			   (@userid,
			   @addDate,
			   @ordertype,
			   @address,
			  @email,
			   @mobile,			
			   @paymoney,
			   @paytype,			
			   @payresult,
				@payremark,
				@paythirdnum,
				@paydate
			 )
		SET @id = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE shop_orders
    SET userid = @userid,addDate=@addDate,ordertype= @ordertype,
    address=@address,email=@email,mobile=@mobile,
    paymoney=paymoney,paytype=@paytype,   payresult=@payresult,
	 payremark=payremark,paythirdnum=@paythirdnum,   paydate=@paydate
    WHERE id =  @id
   END
	
	RETURN @id 
END
