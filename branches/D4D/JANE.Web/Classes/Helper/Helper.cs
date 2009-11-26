using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using D4D.Platform.Domain;
using D4D.Platform;
using System.Globalization;
using System.Threading;

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
    }
}
