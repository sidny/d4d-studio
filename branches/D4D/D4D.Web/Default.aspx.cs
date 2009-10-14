using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace D4D.Web
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
