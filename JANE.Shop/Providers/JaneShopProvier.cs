using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JANE.Shop.Domain;
using JANE.Shop.Persistence;
using D4D.Platform.Domain;
namespace JANE.Shop.Providers
{
    public class JaneShopProvier
    {
        #region instance
        private static readonly JaneShopProvier instance = new JaneShopProvier();

        internal static JaneShopProvier Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        //商品信息
        #region 商品信息
        public int SetShopItem(ShopItem item)
        {
            return JaneShopItemsDao.SetShopItem(item);
        }
        public void DeleteShopItem(int id)
        {
            JaneShopItemsDao.DeleteShopItem(id);
        }

        public ShopItem GetShopItem(int id)
        {
            return JaneShopItemsDao.GetShopItem(id);
        }

        public List<ShopItem> GetPagedShopItem(PagingContext pager, PublishStatus publishStatus)
        {
            return JaneShopItemsDao.GetPagedShopItem(pager, (int)publishStatus);
        }
        public List<ShopItem> GetPagedShopItemByPublishDate(PagingContext pager, PublishStatus publishStatus,
            DateTime sTime, DateTime eTime)
        {
            return JaneShopItemsDao.GetPagedShopItemByPublishDate(pager, (int)publishStatus,sTime,eTime);
        }
        #endregion

        //购物清单
        #region JaneShopTradelistDao
        public int SetShopTradelist(ShopTradelist item)
        {
            return JaneShopTradelistDao.SetShopTradelist(item);
        }

        public void DeleteShopTradelist(int id)
        {
            JaneShopTradelistDao.DeleteShopTradelist(id);
        }

        public void DeleteShopTradelistByOrderId(int orderid)
        {
            JaneShopTradelistDao.DeleteShopTradelistByOrderId(orderid);
        }

        public ShopTradelist GetShopTradelist(int id)
        {
            return JaneShopTradelistDao.GetShopTradelist(id);
        }

        public List<ShopTradelist> GetShopTradelistByOrderId(int orderid)
        {
            return JaneShopTradelistDao.GetShopTradelistByOrderId(orderid);
        }

        public List<ShopTradelist> GetPagedShopOrder(PagingContext pager, int orderid)
        {
            return JaneShopTradelistDao.GetPagedTradelist(pager, orderid);
        }
        #endregion
        //订单
        #region JaneShopOrders
        public int SetShopOrder(ShopOrder item)
        {
            return JaneShopOrdersDao.SetShopOrder(item);
        }

        public void DeleteShopOrder(int id)
        {
            JaneShopOrdersDao.DeleteShopOrder(id);
        }

        public ShopOrder GetShopOrder(int id)
        {
            return JaneShopOrdersDao.GetShopOrder(id);
        }

        public List<ShopOrder> GetPagedShopOrder(PagingContext pager, OrderType ordertype)
        {
            return JaneShopOrdersDao.GetPagedShopOrder(pager, (int)ordertype);
        }
        #endregion

        //订单列表      

        //收货地址信息
        

    }
}
