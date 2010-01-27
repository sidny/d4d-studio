using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Helper
{
     
    public static class StringHelper
    {
        static System.Text.RegularExpressions.Regex regNaturalNumber = new System.Text.RegularExpressions.Regex(@"^[A-Za-z0-9]+$");

        /// <summary>
        /// 是否纯英文或者数字
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static bool IsNatural_Number(string str)
        {
            if (string.IsNullOrEmpty(str)) return false;
            return regNaturalNumber.IsMatch(str);
        }
    }
}
