using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JANE.Shop.Providers;
namespace JANE.Shop
{
    public static class JaneShopGateway
    {
        public static JaneShopProvier JaneShopProvier
        {
            get
            {
                return JaneShopProvier.Instance;
            }
        }
    }
}
