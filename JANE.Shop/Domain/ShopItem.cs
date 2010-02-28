using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;

namespace JANE.Shop.Domain
{
    /// <summary>
    /// 商品信息
    /// </summary>
    public class ShopItem : BaseD4DDomain
    {
          public ShopItem() { }
          public ShopItem(int id)
        {
            Id = id;
        }
         public int Id
        {
            get;
            set;
        }

        public string Name
        {
            get;
            set;
        }

        public string Description
        {
            get;
            set;
        }
        public string Body
        {
            get;
            set;
        }

        public double Price
        {
            get;
            set;
        }


        public DateTime PublishDate
        {
            get;
            set;
        }      
     
      
        public string SImage
        {
            get;
            set;
        }

        public string LImage
        {
            get;
            set;
        }


        public PublishStatus Status
        {
            get;
            set;
        }

        public int Hits
        {
            get;
            set;
        }

        private int _BaseCountEachdeliver = 5;
        /// <summary>
        /// 每件商品送货时候的计价单位数量
        /// 比如CD 计价单位数量 = 5 ，那么快递费用为10
        /// 当买小于等于5件商品时候 费用就是10元
        /// 当买大于5小于等于10件商品 费用就是10x2 依次类推
        /// </summary>
        public int BaseCountEachdeliver
        {
            get
            {
                return _BaseCountEachdeliver;
            }
            set
            {
                _BaseCountEachdeliver = value;
            }
        }

        private double _weight =1000;
        /// <summary>
        ///商品录入时增加一个重量的输入框，单位是克
        ///购物车商品进行累加的时候，计算方法：
        ///多件商品总价 +（多件商品总重量/1000克=商品千克重量）x 运费单价 = 用户支付的总价
        ///商品总重量，向上取整（例：2.1千克 2.9千克 都取整为3千克推
        /// </summary>
        public double Weight
        {
            get
            {
                return _weight;
            }
            set
            {
                _weight = value;
            }
        }


    }
}
