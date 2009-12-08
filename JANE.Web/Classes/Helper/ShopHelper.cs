using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using JANE.Shop.Domain;
using JANE.Shop;
using D4D.Platform.Domain;
namespace JANE.Web.Classes.Helper
{
    public class ShopHelper
    {
        /// <summary>
        /// 获取用户当前的购物车
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public static ShopOrder GetUserShopCar(int userId)
        {
            //查询购物车是否有
            ShopOrder sOrder =
              JaneShopGateway.JaneShopProvier.GetUserShopCar(userId);

            if (sOrder != null&&sOrder.Id>0)
                return sOrder;
            else
            {
                //new shopcar
                sOrder = new ShopOrder();
                sOrder.Ordertype = OrderType.ShopCar;
                sOrder.UserId = userId;
                sOrder.AddDate = DateTime.Now;
                sOrder.Id =
                JaneShopGateway.JaneShopProvier.SetShopOrder(sOrder);
                return sOrder;
            }
        }
        /// <summary>
        /// 添加购物车
        /// </summary>
        /// <param name="orderId"></param>
        /// <param name="itemId"></param>
        /// <param name="count"></param>
        /// <returns></returns>
        public static void SetTradeList(int orderId, int itemId, int count)
        {
            if (count > 0 && itemId > 0 && orderId > 0)
            {
                ShopTradelist tradeListItem = new ShopTradelist();
                tradeListItem.OrderId = orderId;
                tradeListItem.ItemId = itemId;
                tradeListItem.ItemCount = count;

                List<ShopTradelist> list =
                    JaneShopGateway.JaneShopProvier.GetShopTradelistByOrderId(orderId);

                if (list != null && list.Count > 0)
                {
                    foreach (ShopTradelist st in list)
                    {
                        if (st.ItemId == itemId)
                        {
                            tradeListItem.ItemCount = tradeListItem.ItemCount + count;
                            break;
                        }
                    }
                }            
                   
             //    tradeListItem.Id = 
                        JaneShopGateway.JaneShopProvier.SetShopTradelist(tradeListItem);
                
            }
       
        }
    }
}
