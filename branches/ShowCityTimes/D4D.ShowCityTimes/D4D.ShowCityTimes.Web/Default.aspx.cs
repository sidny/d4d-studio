using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using D4D.ShowCityTimes.Service;
using D4D.ShowCityTimes.Domain;

namespace D4D.ShowCityTimes.Web
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            IList<Tag> list = TagService.GetInstance().GetTag(null);
            TagRepeater.DataSource = list;
            TagRepeater.DataBind();
            News news = new News();
            news.Title = "2";
            IList<News> listNews = NewsService.GetInstance().GetNews(news);
            NewsRepeater.DataSource = listNews;
            NewsRepeater.DataBind();
        }
    }
}
