using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using D4D.Platform;
using D4D.Platform.Domain;
using LTP.Accounts.Bus;
namespace D4D.Web.admin.Music
{
    public partial class MusicTitle : System.Web.UI.Page
    {
        protected int PageIndex
        {
            get
            {
                string queryPage = Request.QueryString["page"];
                if (string.IsNullOrEmpty(queryPage)) return 1;

                int page=1;

                int.TryParse(queryPage, out page);

                if (page == 0) page = 1;

                return page;
            }
        }
        protected int PageSize = 10;
        private int totalCount;
        protected int PageTotalCount
        {
            get
            {
                return totalCount;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                addPanel.Visible = false;
                BindMusicTitleRep(PageIndex);
                BindBandList();
                labCurrentPage.Text = PageIndex.ToString();
            }
        }

        private void BindBandList()
        {
            List<BandInfo> list = D4DGateway.BandInfoProvider.GetBandInfoList();
          
            bandIdList.DataSource = list;
            bandIdList.DataValueField = "BandId";
            bandIdList.DataTextField = "BandName";
            bandIdList.DataBind();
        }

        private void BindMusicTitleRep(int pageIndex)
        {
            PagingContext pager = new PagingContext();
            pager.RecordsPerPage = PageSize;
            pager.CurrentPageNumber = pageIndex;
            repMusicTitle.DataSource = D4DGateway.MusicProvider.GetPagedMusicTitles(pager,
                PublishStatus.ALL);
            repMusicTitle.DataBind();
            totalCount = pager.TotalRecordCount;

        }

        protected void btnGoPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin/Music/MusicTitle.aspx?page=" + txtGoToPageNum.Text.Trim());
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button bt = sender as Button;

            RepeaterItem ri = bt.Parent as RepeaterItem;

            Literal litID = ri.FindControl("litID") as Literal;
            
            if (!object.Equals(litID, null))
            {
                int id = 0;
                if (int.TryParse(litID.Text, out id))
                {
                   D4D.Platform.Domain.MusicTitle musicTitle = D4DGateway.MusicProvider.GetMusicTitle(id);
                   txtMusicId.Value = musicTitle.MusicId.ToString();
                   txtLImage.Text = musicTitle.LImage;
                   txtSImage.Text = musicTitle.SImage;
                   txtStatus.Text = ((int)musicTitle.Status).ToString();
                   txtTitle.Text = musicTitle.Title;
                   txtBody.Text = musicTitle.Body;
                   bandIdList.SelectedValue = musicTitle.BandId.ToString();
                   addPanel.Visible = true;
                   listPanel.Visible = false;
                   btnAdd.Text = "更新";
                }
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button bt = sender as Button;

            RepeaterItem ri = bt.Parent as RepeaterItem;

            Literal litID = ri.FindControl("litID") as Literal;
            if (!object.Equals(litID, null))
            {
                int id = 0;
                if (int.TryParse(litID.Text, out id))
                {
                    D4DGateway.MusicProvider.DeleteMusicTitle(id);
                    BindMusicTitleRep(1);
                }
            }

        }
        

        protected void repMusicTitle_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            D4D.Platform.Domain.MusicTitle m = e.Item.DataItem as D4D.Platform.Domain.MusicTitle;

           if (m != null)
           {
               Literal litId = e.Item.FindControl("litID") as Literal ;
               Literal litId_1 = e.Item.FindControl("litID_1") as Literal;
               Literal litTitle = e.Item.FindControl("litTitle") as Literal;
               Literal litBandId = e.Item.FindControl("litBandId") as Literal;
               Literal litSImage = e.Item.FindControl("litSImage") as Literal;
               Literal litLImage = e.Item.FindControl("litLImage") as Literal;
               Literal litStutes = e.Item.FindControl("litStutes") as Literal;
               Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;

               litId_1.Text = litId.Text = m.MusicId.ToString();
               litTitle.Text = m.Title;
               litBandId.Text = m.BandId.ToString();
               litSImage.Text = m.SImage;
               litLImage.Text = m.LImage;
               litStutes.Text = m.Status.ToString();
               litAddDate.Text = m.AddDate.ToLongDateString();
           }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            D4D.Platform.Domain.MusicTitle m = new D4D.Platform.Domain.MusicTitle();
            m.Title = txtTitle.Text;
            m.Body = txtBody.Text;
            m.SImage = txtSImage.Text;
            m.LImage = txtLImage.Text;
            int musicId = 0;
            int.TryParse(txtMusicId.Value, out musicId);
            m.MusicId = musicId;
            int bandId = 1;
            int.TryParse(bandIdList.SelectedValue, out bandId);
            m.BandId = bandId;
            User currentUser = Session["UserInfo"] as User;
            m.AddUserID = currentUser.UserID;

             m.PublishDate = DateTime.Now;

              int status = 1;
             int.TryParse(txtStatus.Text, out status);
             m.Status = (PublishStatus)status;
            int result =  D4DGateway.MusicProvider.SetMusicTitle(m);
            addPanel.Visible = false;
            listPanel.Visible = true;
            BindMusicTitleRep(1);
        }

        protected void btnAdd_Show(object sender, EventArgs e)
        {
            addPanel.Visible = true;
            listPanel.Visible = false;
            btnAdd.Text = "添加";
        }
    }
}
