using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace D4D.Web.Control
{
    public partial class comment : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public int CommentsCount
        {
            get;
            set;
        }
        public string CommentUrl
        {
            get;
            set;
        }
        public int ObjectId
        {
            get;
            set;
        }
        public int ObjectType
        {
            get;
            set;
        }
    }
}