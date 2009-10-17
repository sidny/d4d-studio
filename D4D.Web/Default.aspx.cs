using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LTP.Accounts.Bus;
namespace D4D.Web
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User user = new User();
            user.SetPassword("admin", "1");
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
