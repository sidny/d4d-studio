-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_orders_ShopCarGet]   
   @userid AS INT 
AS
BEGIN	
	
    SELECT  TOP 1 
               Id, 
               userid,
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
				username,
				RegionId,
				Freight,
				RegionStr
    FROM shop_orders With(nolock)
    WHERE userid =  @userid and ordertype=0
	ORDER BY id DESC
 
END
GO
