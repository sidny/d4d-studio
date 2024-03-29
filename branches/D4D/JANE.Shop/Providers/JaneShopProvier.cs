﻿using System;
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
        /// <summary>
        /// 获取商品信息不自动加点击数
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ShopItem GetShopItem(int id)
        {
            return JaneShopItemsDao.GetShopItem(id);
        }
        /// <summary>
        /// 获取商品信息 如果hits 小于 0 不累计点击数
        /// </summary>
        /// <param name="id"></param>
        /// <param name="hits"></param>
        /// <returns></returns>
        public ShopItem GetShopItem(int id, int hits)
        {
            return JaneShopItemsDao.GetShopItem(id, hits);
        } 

        /// <summary>
        /// 获取商品信息自动+1点击数
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ShopItem GetShopItemAddHit(int id)
        {
            return JaneShopItemsDao.GetShopItem(id,1);
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

        public List<ShopItem> GetTopPublishedShopItemsOrderByHits(int maxCount)
        {
            return JaneShopItemsDao.GetTopPublishedShopItemsOrderByHits(maxCount);
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

        public List<ShopOrder> GetPagedShopOrderbyUser(PagingContext pager, int userid, OrderType ordertype)
        {
            return JaneShopOrdersDao.GetPagedShopOrderbyUser(pager, userid, (int)ordertype);
        }

        public ShopOrder GetUserShopCar(int userId)
        {
            return JaneShopOrdersDao.GetUserShopCar(userId);
        }
        #endregion

        //订单列表      

        //收货地址信息

        #region 送货地域
        public int SetShopRegion(ShopRegion item)
        {
            return JaneShopRegionDao.SetShopRegion(item);
        }

        public void DeleteShopRegion(int id)
        {
            JaneShopRegionDao.DeleteShopRegion(id);
        }

        public ShopRegion GetShopRegion(int id)
        {
            return JaneShopRegionDao.GetShopRegion(id);
        }

        public List<ShopRegion> GetShopRegionsByParentId(int parentId)
        {
            return JaneShopRegionDao.GetShopRegionsByParentId(parentId);
        }
        public Dictionary<int, ShopRegion> GetShopRegions20(List<int> ids)
        {
            return JaneShopRegionDao.GetShopRegions20(ids);
        }
        #endregion


    }
}
