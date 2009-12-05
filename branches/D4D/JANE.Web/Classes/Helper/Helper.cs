using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using D4D.Platform.Domain;
using D4D.Platform;
using System.Globalization;
using System.Threading;
using D4D.Platform.Helper.Discuz;

namespace D4D.Web.Helper
{
    public class Helper
    {
        public static List<BandInfo> BandList
        {
            get
            {
                List<BandInfo> list = HttpContext.Current.Session["BandList"] as List<BandInfo>;
                if (list == null)
                {
                    list = D4D.Platform.D4DGateway.BandInfoProvider.GetBandInfoList(false);
                    list = (from a in list
                           orderby a.BandId
                           select a).ToList();
                    HttpContext.Current.Session["BandList"] = list;
                }
                return list;

            }
        }
        public static IDictionary<int,BandInfo> BandColl
        {
            get
            {
                IDictionary<int, BandInfo> coll = new Dictionary<int, BandInfo>();
                foreach (var i in BandList)
                    coll.Add(i.BandId, i);
                return coll;

            }
        }

        public static int BandId
        {
            get
            {
                foreach (BandInfo band in BandList)
                {
                    if (Thread.CurrentThread.CurrentCulture.Name.ToLower() == band.BandName.ToLower())
                        return band.BandId;
                }
                return 0;
            }
        }
       

        public static bool IsDizLogin
        {
            get
            {
                return (GetCookieUserId() > 0);
            }
        }
        public static DiscuzShortUserInfo DizUser
        {
            get
            {
                int uid = GetCookieUserId();
                if (uid > 0)
                {
                    if (dizUser == null || dizUser.Uid != uid)
                    {
                       dizUser = DiscuzGateway.DiscuzAccountProvider.GetShortUserInfo(uid);
                    }
                }
                else
                {
                    dizUser = null;
                }

                return dizUser;
            }
        }


        private static DiscuzShortUserInfo dizUser
        {
            get
            {
                return HttpContext.Current.Session["dnt"] as DiscuzShortUserInfo;
            }
            set
            {
                HttpContext.Current.Session["dnt"] = value;
            }
        }
        public static int GetCookieUserId()
        {
            int uid = 0;
            int.TryParse(DiscuzHelper.GetCookie("userid"), out uid);
            return uid;
        }
        public static string GetCookieUserName()
        {
            if (IsDizLogin)
            {
                string username = DiscuzHelper.GetCookie("username");

                if (string.IsNullOrEmpty(username))
                {
                    username = DizUser.Username;
                    DiscuzHelper.WriteCookie("username", username);
                }
                return username;
            }
            else
            {
                return String.Empty;
            }
        }
    }
}
