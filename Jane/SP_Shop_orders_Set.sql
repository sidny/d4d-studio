﻿-- =============================================
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
   @paymoney AS float, 
 @paytype AS INT   ,
  @payresult AS INT   ,
   @payremark AS NVARCHAR(4000), 
    @paythirdnum AS NVARCHAR(1000)   ,
   @paydate AS DATETIME,
@zipcode AS NVARCHAR(50), 
    @username AS NVARCHAR(200)     
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
				paydate,
				zipcode,
				username
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
				@paydate,
				@zipcode,
				@username
			 )
		SET @id = 	 @@IDENTITY 
   END
   ELSE
   BEGIN
    UPDATE shop_orders
    SET userid = @userid,addDate=@addDate,ordertype= @ordertype,
    address=@address,email=@email,mobile=@mobile,
    paymoney=paymoney,paytype=@paytype,   payresult=@payresult,
	 payremark=payremark,paythirdnum=@paythirdnum,   paydate=@paydate,
   zipcode=@zipcode,username=@username
    WHERE id =  @id
   END
	
	RETURN @id 
END
GO