using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JANE.Shop.Domain
{
    /// <summary>
    /// 购物列表
    /// </summary>
    public class ShopTradelist
    {
        public ShopTradelist() { }
        public ShopTradelist(int id)
        {
            Id = id;
        }
        public int Id
        {
            get;
            set;
        }

        public int OrderId
        {
            get;
            set;
        }

        public int ItemId
        {
            get;
            set;
        }

        public int ItemCount
        {
            get;
            set;
        }
    }
}
