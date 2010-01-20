using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JANE.Shop.Helper
{
    public class CarriageHelper
    {
        public static double Ceiling(int itemCount, int baseCountEachdeliver)
        {
            return Math.Ceiling((double)itemCount / (double)baseCountEachdeliver);
        }
    }
}
