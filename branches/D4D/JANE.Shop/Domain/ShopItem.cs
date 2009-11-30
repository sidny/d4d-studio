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

        public decimal Price
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
    }
}
