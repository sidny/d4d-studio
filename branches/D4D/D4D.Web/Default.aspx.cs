using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using D4D.DAL;
using D4D.Model;

namespace D4D.Web
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NewsDAL newsDAL = new NewsDAL();

            News news = new News();
            news.Title = "test1";
            news.Detail = "1";
            //newsDAL.Add(news);
            _pageSize = 2;
            IList<News> list = newsDAL.GetList(null, 0, _pageSize);
            ListNews.DataSource = list;
            ListNews.DataBind();
            _totalCount = newsDAL.Count();

        }

        private int _totalCount;
        private int _pageSize;
        public int TotalCount {
            get { return _totalCount; }
        }
        public int PageSize
        {
            get { return _pageSize; }
        }
    }
}
