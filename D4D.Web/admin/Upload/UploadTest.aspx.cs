using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
namespace D4D.Web.admin.Upload
{
    public partial class UploadTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Write(ddlPublishStatus.SelectedValue);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ddlPublishStatus.SelectedValue = "0";
        }

       
    }
}
