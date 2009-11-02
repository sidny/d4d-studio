using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace D4D.Web.MasterPage
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] path = Request.AppRelativeCurrentExecutionFilePath.Split('/');
            string title = "";
            if (path.Length > 3)
            {
                switch (path[2])
                {
                    case "news":
                        title += "星闻 - ";
                        break;
                    case "video":
                        title += "视频 - ";
                        break;
                    case "singer":
                        title += "艺人 - ";
                        break;
                    case "search":
                        title += "搜索 - ";
                        break;
                    case "photo":
                        title += "图片 - ";
                        break;
                    case "music":
                        title += "音乐 - ";
                        break;
                    case "calender":
                        title += "星程 - ";
                        break;
                    default:
                        break;
                }
            }
            title += "少城时代官方网站";
            Page.Header.Title = title;
        }
    }
}
