using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LTP.Accounts.Bus;
using System.Data;
using System.Web.UI;
using System.Collections;

namespace D4D.Web.Helper
{
    public class AdminHelper 
    {
        public static Hashtable AdminCollection{
            get
            {
                Hashtable hs = HttpContext.Current.Session["AdminCollection"] as Hashtable;
                if (hs == null)
                {
                    hs = new Hashtable();
                    DataSet ds = new User().GetUserList(UserType.Type.Admin);
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        User user = new User();
                        user.UserID = (int)dr["UserId"];
                        user.UserName = dr["UserName"].ToString();
                        user.TrueName = dr["TrueName"].ToString();
                        hs.Add(user.UserID, user);
                    }
                    HttpContext.Current.Session["AdminCollection"] = hs;
                }

                return hs;

            }
        }
        public static User CurrentUser
        {
            get
            {
                return HttpContext.Current.Session["UserInfo"] as User;
            }
        }
    }
}
