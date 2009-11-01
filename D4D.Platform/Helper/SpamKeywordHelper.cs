using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Helper
{
   public static class SpamKeywordHelper
    {

       public const string DEFAULT_REPLACESTRING = "*";
  

       public static string FilterContent(string content)
       {
           return FilterContent(content,DEFAULT_REPLACESTRING);
       }

       public static string FilterContent(string content, string replaceStr)
       {
           if (string.IsNullOrEmpty(replaceStr)) return content;

           string resultStr = content;

           List<string> spamWordList = D4DGateway.SpamKeywordProvider.GetSpamKeywords();

           if (spamWordList != null && spamWordList.Count > 0)
           {
               foreach (string s in spamWordList)
                   resultStr = resultStr.Replace(s, replaceStr);
           }

           return resultStr;
       }

    }
}
