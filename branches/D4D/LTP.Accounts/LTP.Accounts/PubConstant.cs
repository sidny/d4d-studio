namespace LTP.Accounts
{
    using System;
    using System.Configuration;
    using System.Web;

    public class PubConstant
    {
        public static object GetCache(string CacheKey)
        {
            return HttpRuntime.Cache[CacheKey];
        }

        public static string GetConfigString(string key)
        {
            string cacheKey = "AppSettings-" + key;
            object cache = GetCache(cacheKey);
            if (cache == null)
            {
                try
                {
                    cache = ConfigurationManager.AppSettings[key];
                    if (cache != null)
                    {
                        SetCache(cacheKey, cache, DateTime.Now.AddMinutes(180.0), TimeSpan.Zero);
                    }
                }
                catch
                {
                }
            }
            if (cache != null)
                return cache.ToString();
            else return string.Empty;
        }

        public static void SetCache(string CacheKey, object objObject, DateTime absoluteExpiration, TimeSpan slidingExpiration)
        {
            HttpRuntime.Cache.Insert(CacheKey, objObject, null, absoluteExpiration, slidingExpiration);
        }

        public static string ConnectionString
        {
            get
            {
                string configString = GetConfigString("ConnectionStringAccounts");
                if (GetConfigString("ConStringEncrypt") == "true")
                {
                    configString = DESEncrypt.Decrypt(configString);
                }
                return configString;
            }
        }
    }
}

