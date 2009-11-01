using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
using System.Configuration;
namespace D4D.Platform.Providers
{
     public class SpamKeywordProvider
    {
        #region instance
         private static readonly SpamKeywordProvider instance = new SpamKeywordProvider();

         internal static SpamKeywordProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion


         public int SetSpamKeyword(SpamKeyword keyword)
         {
             return SpamKeywordDao.SetSpamKeyword(keyword);
         }

         public void DeleteKeyword(int id)
         {
              SpamKeywordDao.DeleteKeyword(id);
         }

         public List<SpamKeyword> GetPagedSpamKeywords(PagingContext pager)
         {
             return SpamKeywordDao.GetPagedSpamKeywords(pager);
         }

         public List<SpamKeyword> GetEntitySpamKeywords()
         {
             return SpamKeywordDao.GetAllSpamKeywords();
         }
         public List<string> GetSpamKeywordsFromDB()
         {
             List<string> listResult = new List<string>();
             List<SpamKeyword> list = GetEntitySpamKeywords();

             foreach (SpamKeyword sk in list)
             {
                 if (!listResult.Contains(sk.Keyword))
                     listResult.Add(sk.Keyword);
             }

             return listResult;
         }

         private const int CacheMinute = 30;
         private const string SpamKeywordCacheKey = "ShowCitySpamKeywordCacheKey";
         public List<string> GetSpamKeywords()
         {       

             bool bSpamCacheEnabled = false;
             string spamKeywordCacheEnabled = ConfigurationManager.AppSettings["SpamKeywordCacheEnabled"];
             if (!string.IsNullOrEmpty(spamKeywordCacheEnabled))
             {
                 bool.TryParse(spamKeywordCacheEnabled, out bSpamCacheEnabled);
             }

             if (!bSpamCacheEnabled)
             {

                 object obj = System.Web.HttpContext.Current.Cache[SpamKeywordCacheKey];

                 if (obj == null)
                 {
                     obj = GetSpamKeywordsFromDB();

                     int cacheMinutes = CacheMinute;
                     string spamKeyWordCacheMinute = ConfigurationManager.AppSettings["SpamKeyWordCacheMinute"];
                     if (!string.IsNullOrEmpty(spamKeyWordCacheMinute))
                     {
                         int.TryParse(spamKeyWordCacheMinute, out cacheMinutes);
                     }

                     System.Web.HttpContext.Current.Cache.Insert(SpamKeywordCacheKey, obj, null,
                         DateTime.Now.AddMinutes(cacheMinutes),
                         System.Web.Caching.Cache.NoSlidingExpiration);
                 }

                 return obj as List<string>;
             }
             else
                 return GetSpamKeywordsFromDB();
         }

         
    }
}
