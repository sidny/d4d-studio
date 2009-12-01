<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Register src="~/Control/pager.ascx" tagname="pager" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
 <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	   <div class="cd_title pic_title">
       <h1 class="font24 floatleft blue">图片<span><asp:Literal ID="litTitle" runat="server"></asp:Literal></span></h1> 
</div>	 
	  <div class="spacer" style="height:40px"></div>
               
            <asp:Repeater ID="repList" runat="server">
                <HeaderTemplate>
                <ul class="pic_list">
                </HeaderTemplate>
                <ItemTemplate>
                <li>
                <div><a href="/photo/album/<%#((Album)Container.DataItem).AlbumId %>.html"><img width="150" height="100" src="<%#((Album)Container.DataItem).SImage%>" alt="" /></a></div>
			<p>
				<%#GetNewImage((Album)Container.DataItem) %><a href="/photo/album/<%#((Album)Container.DataItem).AlbumId %>.html"><%#((Album)Container.DataItem).Title %></a><br />
				<span class="blue"><%#((Album)Container.DataItem).TotalCount %>张</span> <span class="gray">| <%#((Album)Container.DataItem).PublishDate.ToString("yyyy-MM-dd")%></span>
			</p>
                 </li>
                </ItemTemplate>
                <FooterTemplate>
               </ul>
                </FooterTemplate>
            </asp:Repeater>
      <div class="spacer"></div>
	  <div class="spacer"></div>    
      <uc1:pager ID="pager1" runat="server"  />
	  <div class="clear"></div>

	  <div class="spacer"></div>  
	  <div class="spacer"></div>  
    </div>
    </div>
</div>
</asp:Content>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        BindMusicTitleRep(PageIndex);
        SetTitle();
        pager1.PageIndex = PageIndex;
        pager1.PageSize = PageSize;
        pager1.PageTotalCount = PageTotalCount;
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
            return D4D.Web.Helper.Helper.BandId;
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
    protected int PageSize = 12;

    protected int TagId
    {
        get
        {
            string tid = Request.QueryString["tagid"];
            if (string.IsNullOrEmpty(tid)) return 0;

            int id = 0;

            int.TryParse(tid, out id);
            return id;
        }
    }


    public string TagName
    {
        get
        {
            string tagName = Request.QueryString["tag"];
            if (string.IsNullOrEmpty(tagName))
                return string.Empty;
            else
                return tagName;
        }
    }

    public int TagYear
    {
        get
        {
            string yid = Request.QueryString["year"];
            if (string.IsNullOrEmpty(yid)) return 0;

            int id = 0;

            int.TryParse(yid, out id);
            return id;
        }
    }

    public int TagMonth
    {
        get
        {
            string mid = Request.QueryString["month"];
            if (string.IsNullOrEmpty(mid)) return 0;

            int id = 0;

            int.TryParse(mid, out id);
            return id;
        }
    }

    public string TagTime
    {
        get
        {
            if (TagYear <= 1900) return string.Empty;
            if (TagMonth > 12 && TagMonth <= 0) return string.Empty;

            return string.Format("{0}年{1}月", TagYear, TagMonth);
        }
    }
    
    private void BindMusicTitleRep(int pageIndex)
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;
        List<Album> resultList = new List<Album>();

        if (TagId > 0)
        {
            if (BandId > 0)
            {
                resultList = D4DGateway.AlbumProvider.GetPagedAlbumsByTagAndBand(pager,
                     PublishStatus.Publish, TagId, BandId);
            }
            else
            {
                resultList = D4DGateway.AlbumProvider.GetPagedAlbumsByTag(pager, PublishStatus.Publish,
                    TagId);
            }
        }
        else if (TagYear >= 1900 && TagMonth > 0 && TagMonth <= 12)
        {
            //DateTime sTime = new DateTime(TagYear, TagMonth, 1);
            //DateTime eTime = sTime.AddMonths(1).AddDays(-1);
            if (BandId > 0)
            {
                resultList = D4DGateway.AlbumProvider.GetPagedAlbumsByBandAndPublishYearMonth(pager,
                     PublishStatus.Publish, BandId, TagYear, TagMonth);
            }
            else
            {
                resultList = D4DGateway.AlbumProvider.GetPagedAlbumsByPublishYearMonth(pager,
                     PublishStatus.Publish, TagYear, TagMonth);
            }
        }
        else
        {
            if (BandId > 0)
            {
                resultList = D4DGateway.AlbumProvider.GetPagedAlbumsByBandId(pager,
                   PublishStatus.Publish, BandId);
            }
            else
            {
                resultList = D4DGateway.AlbumProvider.GetPagedAlbums(pager,
                               PublishStatus.Publish);
            }
        }
        /*
        if (BandId > 0)
        {
            resultList = D4D.Platform.D4DGateway.AlbumProvider.GetPagedAlbumsByBandId(pager,
               D4D.Platform.Domain.PublishStatus.Publish, BandId);
        }
        else
        {
            resultList = D4D.Platform.D4DGateway.AlbumProvider.GetPagedAlbums(pager,
                           D4D.Platform.Domain.PublishStatus.Publish);
        }
         */
        repList.DataSource = resultList;
        repList.DataBind();
        totalCount = pager.TotalRecordCount;

    }
    protected string GetUrl(int id, int type)
    {
        switch (type)
        {
            case 1:
                if (IsRewrite) return string.Format("/music/b{0}.html", id);
                else return string.Format("index.aspx?id=" + id);

            case 2:
                if (IsRewrite) return string.Format("/music/b{0}/song/{1}.html", BandId, id);
                else return string.Format("songs.aspx?id={0}&bandid={1}", id, BandId);
            default:
                return (IsRewrite) ? "/music.html" : "index.aspx";
        }

    }
    private const string TitleFormat = "- {0}";
    private const string OnlyTitleFormat = "- {0}照片";
    private void SetTitle()
    {
        //check bandName
        string HeadTitle = string.Empty;
        BandInfo info;
        if (BandColl.TryGetValue(BandId, out info))
            HeadTitle = info.BandName;

        if (String.IsNullOrEmpty(HeadTitle)) HeadTitle = "全部";


        if (TagId > 0)
        {
            litTitle.Text = string.Format(TitleFormat,TagName);
        }
        else if (TagYear >= 1900 && TagMonth > 0 && TagMonth <= 12)
        {
            litTitle.Text = string.Format(TitleFormat,TagYear.ToString() + "年" + TagMonth + "月");
        }
        
        

    }
    protected string GetDate(DateTime date)
    {
        return date.ToString("yyyy年M月d日");
    }
    private static bool IsRewrite
    {
        get
        {
            string key = ConfigurationManager.AppSettings["RewriteUrl"];
            bool result = false;
            bool.TryParse(key, out result);
            return result;
        }
    }
    public static IDictionary<int, BandInfo> BandColl
    {
        get
        {
            System.Collections.Generic.IDictionary<int, BandInfo> coll = D4D.Web.Helper.Helper.BandColl;

            BandInfo band = new BandInfo();
            band.BandId = 0;
            band.BandName = "全部";
            coll.Add(band.BandId, band);
            return coll;

        }
    }
    protected string GetNewImage(Album n)
    {
        if (DateTime.Now > n.PublishDate.AddDays(7))
            return "";
        else
            return "<img src=\"/static/images/new.gif\"> ";
    }
</script>

