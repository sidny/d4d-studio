using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestWeb
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string h =
            D4D.ResourceManager.ResourceManager.Instance.GetResourceValue(D4D.ResourceManager.CultureType.ZHCN, "hello");
             litInfo.Text = h+"<br/>";
            D4D.ResourceManager.ResourceConfig config = D4D.ResourceManager.ResourceManager.Instance.GetConfig();

            foreach (KeyValuePair<string, string> kvp in config.ResourceDatas)
                litInfo.Text += "name:" + kvp.Key + " value:" + kvp.Value + "<br/>";
           
        }
    }
}
