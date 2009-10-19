using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace D4D.Web.MasterPage
{
    public partial class Channel : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] path = Request.AppRelativeCurrentExecutionFilePath.Split('/');
            if (path.Length > 3)
            {
                string controlPath = "~/channel/" + path[2] + "/menu.ascx";
                System.Web.UI.Control uc = Page.LoadControl(controlPath);
                uc.ID = "uc" + path[2];
                menuPlace.Controls.Add(uc);
            }
        }
    }
}
