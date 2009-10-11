using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LTP.Accounts.Bus;
using System.Data;
using System.Web.Security;
using System.Configuration;
using System.Collections;

namespace D4D.Web.admin
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetUserInfo();
            DataSet ds = AccountsTool.GetAllCategories();
            ArrayList list = new ArrayList();
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                
                    Hashtable ht = new Hashtable();
                    ht.Add("CategoryID", row["CategoryID"]);
                    ht.Add("Description", row["Description"]);
                    list.Add(ht);
            }
            menuList.DataSource = list;
            menuList.DataBind();
        }

        private AccountsPrincipal user;

        private void GetUserInfo()
        {
            string loginPage = ConfigurationManager.AppSettings.Get("LoginPage");
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                     user = new AccountsPrincipal(Context.User.Identity.Name);
                     var permissions = (from p in user.PermissionsID.ToArray()
                                        select p.ToString()).ToArray();
                     PermissionStr = "[" + String.Join(",", permissions) + "]";
                    
                    if (Session["UserInfo"] == null)
                    {
                        User currentUser = new LTP.Accounts.Bus.User(user);
                        Session["UserInfo"] = currentUser;
                        Session["Style"] = currentUser.Style;
                    }

                }
                else
                {
                    FormsAuthentication.SignOut();
                    Session.Clear();
                    Session.Abandon();
                    Response.Clear();
                    Response.Redirect(loginPage);
                }

        }
        public int PermissionID = -1;
        public string PermissionStr = "[]";
    }
}
