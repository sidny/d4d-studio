using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JANE.Shop.Domain
{
    /// <summary>
    /// 快递地域信息
    /// </summary>
    public class ShopRegion
    {

         public ShopRegion() { }
         public ShopRegion(int id)
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

         public int ParentId
         {
             get;
             set;
         }


         public double TransferPrice
        {
            get;
            set;
        }
         public double TransferPrice1
         {
             get;
             set;
         }
         public double TransferPrice2
         {
             get;
             set;
         }
    }
}
