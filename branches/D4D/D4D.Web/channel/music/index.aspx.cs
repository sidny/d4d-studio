using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using D4D.Platform.Providers;
using D4D.Platform.Domain;
using D4D.Platform;

namespace D4D.Web.channel.music
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
         
        }

        protected int PageIndex
        {
            get
            {
                string queryPage = Request.QueryString["page"];
                if (string.IsNullOrEmpty(queryPage)) return 1;

                int page = 1;

                int.TryParse(queryPage, out page);

                if (page == 0) page = 1;

                return page;
            }
        }
        protected int BandId
        {
            get
            {
                string queryid = Request.QueryString["id"];
                if (string.IsNullOrEmpty(queryid)) return 0;

                int id = 0;

                int.TryParse(queryid, out id);
                return id;
            }
        }
        private int totalCount;
        protected int PageTotalCount
        {
            get
            {
                return totalCount;
            }
        }
        private void BindMusicTitleRep(int pageIndex)
        {
            PagingContext pager = new PagingContext();
            pager.RecordsPerPage = 10;
            pager.CurrentPageNumber = pageIndex;
            repMusicTitle.DataSource = D4DGateway.MusicProvider.GetPagedMusicTitlesByBandId(pager,
               BandId, PublishStatus.Publish);
            repMusicTitle.DataBind();
            totalCount = pager.TotalRecordCount;

        }
    }
}
