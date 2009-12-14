using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.Collections.Specialized;

namespace JANE.Shop.Helper
{
    public class PaymentHelper
    {
        /// <summary>
        /// md5加密
        /// </summary>
        /// <param name="s"></param>
        /// <param name="_input_charset"></param>
        /// <returns></returns>
        public static string GetMD5(string s, string _input_charset)
        {

            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] t = md5.ComputeHash(
                Encoding.GetEncoding(_input_charset).GetBytes(s));
            StringBuilder sb = new StringBuilder(32);
            for (int i = 0; i < t.Length; i++)
            {
                sb.Append(t[i].ToString("x").PadLeft(2, '0'));
            }
            return sb.ToString();
        }

        /// <summary>
        /// 冒泡排序法
        /// </summary>
        public static string[] BubbleSort(string[] r)
        {

            int i, j; //交换标志 
            string temp;

            bool exchange;

            for (i = 0; i < r.Length; i++) //最多做R.Length-1趟排序 
            {
                exchange = false; //本趟排序开始前，交换标志应为假

                for (j = r.Length - 2; j >= i; j--)
                {
                    if (System.String.CompareOrdinal(r[j + 1], r[j]) < 0)　//交换条件
                    {
                        temp = r[j + 1];
                        r[j + 1] = r[j];
                        r[j] = temp;

                        exchange = true; //发生了交换，故将交换标志置为真 
                    }
                }

                if (!exchange) //本趟排序未发生交换，提前终止算法 
                {
                    break;
                }

            }
            return r;
        }

        public static string GetDataString(NameValueCollection nvc)
        {
            StringBuilder remark = new StringBuilder(512);

            if (nvc != null && nvc.Count > 0)
            {
                for (int i = 0; i < nvc.Count; i++)
                {
                    if (i > 0)
                        remark.Append("&");
                    remark.Append(nvc.Keys[i]);
                    remark.Append("=");
                    remark.Append(nvc[i]);
                }
            }

            return remark.ToString();
        }

    }
}
