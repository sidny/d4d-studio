using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LTP.Accounts.Bus;

namespace D4D.Web.admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = null;
            if (Session["UserInfo"] != null)
            {
                currentUser = Session["UserInfo"] as User;
                
            }
            if (currentUser == null)
            {
                ContentBody.Visible = false;
                failPanel.Visible = true;
            }
              
        }
    }
}
