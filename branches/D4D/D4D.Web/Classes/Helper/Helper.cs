using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using D4D.Platform.Domain;

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
    }
}
