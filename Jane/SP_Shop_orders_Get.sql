-- =============================================
-- Create date: 2009-11-29
-- =============================================
CREATE PROCEDURE [dbo].[Shop_orders_Get]   
   @id AS INT 
AS
BEGIN	
	
    SELECT 
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
    WHERE id =  @id
 
END
GO
