<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">

    <div class="main">
<div class="channel">
  <h1>全部照片 / <font color="red"><asp:Literal ID="litTitle" runat="server"></asp:Literal></font></h1>
</div>
<div class="album_list">
	
	<asp:Repeater runat="server" ID="repList">
	    <HeaderTemplate>
	    <table width="100%" cellspacing="20" border="0" cellpadding="0"><tr>
	    </HeaderTemplate>
	    <ItemTemplate>
	       <td width="33%" align="center" valign="bottom">
            <p><a href="/photo/album/<%#((D4D.Platform.Domain.Image)Container.DataItem).AlbumId%>/slider.html?id=<%#((D4D.Platform.Domain.Image)Container.DataItem).ImageId%>"><img src="<%#((D4D.Platform.Domain.Image)Container.DataItem).SImageFile %>" /></a></p> 
            <p><a href="/photo/album/<%#((D4D.Platform.Domain.Image)Container.DataItem).AlbumId%>/slider.html?id=<%#((D4D.Platform.Domain.Image)Container.DataItem).ImageId%>"><%#((D4D.Platform.Domain.Image)Container.DataItem).ImageName%></a></p>
           </td>
        </ItemTemplate>
       <SeparatorTemplate>
        <%#((Container.ItemIndex+1)%3 == 0)?"</tr><tr>":"" %>
       </SeparatorTemplate>
        <FooterTemplate></tr></table></FooterTemplate>
        </asp:Repeater>
        <div id="pager" class="pagestyle"></div>
</div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        var cur = parseInt("<%=PageIndex %>");
        var total = parseInt("<%=PageTotalCount %>");
        var pageSize = parseInt("<%=PageSize %>");
        var href = location.pathname;
        if (location.search) {
            if (!location.search.match(/page=\d+/ig)) {
                href += location.search + "&page=__id__";
            } else {
                href += location.search;
            }
        } else {
            href += "?page=__id__";
        }
        $("#pager").pagination(
          total,
                {
                    items_per_page: pageSize,
                    num_display_entries: 10,
                    current_page: cur - 1,
                    num_edge_entries: 0,
                    link_to: href.replace(/page=\d+/ig, "page=__id__"),
                    prev_text: "上一页",
                    next_text: "下一页",
                    callback: function(id) {
                        return true;
                    }
                });
    });
</script>
</asp:Content>

<script runat="server">
   
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
    protected int AlbumId
    {
        get
        {
            string queryid = Request.QueryString["albumid"];
            if (string.IsNullOrEmpty(queryid)) return 0;

            int id = 0;

            int.TryParse(queryid, out id);
            return id;
        }
    }

   
    
    protected int PageSize = 12;
    private int totalCount;
    protected int PageTotalCount
    {
        get
        {
            return totalCount;
        }
    }

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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindPhotoRep(PageIndex);
            SetTitle();
        }
    }
    private const string TitleFormat = "{0}图片";
    private void SetTitle()
    {
        //check bandName
        if (CurrentAlbum.AlbumId > 0)
        {
            litTitle.Text = CurrentAlbum.Title;
        }
        else
        {

            BandInfo info;
            if (BandColl.TryGetValue(BandId, out info))
            {
                litTitle.Text = string.Format(TitleFormat, info.BandName);
            }

            if (!string.IsNullOrEmpty(TagName))
            {
                litTitle.Text = TagName;
            }

            if (!string.IsNullOrEmpty(TagTime))
            {
                litTitle.Text = TagTime;
            }
        }

    }
            
    private void BindPhotoRep(int pageIndex)
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;
        List<D4D.Platform.Domain.Image> resultList = new List<D4D.Platform.Domain.Image>();

        if (TagId > 0)
        {
            if (AlbumId>0)
                resultList = D4DGateway.AlbumProvider.GetPagedImagesByTagAndBand(pager,
            PublishStatus.Publish, TagId,BandId);
            else
             resultList = D4DGateway.AlbumProvider.GetPagedImagesByTag(pager,
                PublishStatus.Publish, TagId);

        }
        else if (TagYear >= 1900 && TagMonth > 0 && TagMonth <= 12)
        {
            DateTime sTime = new DateTime(TagYear, TagMonth, 1);
            DateTime eTime = sTime.AddMonths(1).AddDays(-1);

            if (AlbumId > 0)                
             resultList = D4DGateway.AlbumProvider.GetPagedImagesByBandAndPublishYearMonth(pager,PublishStatus.Publish,
                BandId, sTime, eTime);
            else
                resultList = D4DGateway.AlbumProvider.GetPagedImagesByPublishYearMonth(pager, PublishStatus.Publish,
                 sTime, eTime); 

        }
        else
        {
            resultList = D4DGateway.AlbumProvider.GetPagedImagesByAlbumId(pager,
               AlbumId, PublishStatus.Publish);

        } 
        /*            
        if (AlbumId > 0)
        {
            repList.DataSource = D4D.Platform.D4DGateway.AlbumProvider.GetPagedImagesByAlbumId(pager,
               AlbumId,D4D.Platform.Domain.PublishStatus.Publish);
        }
         */
        if (resultList != null && resultList.Count > 0)
        {
            repList.DataSource = resultList;
            repList.DataBind();
            repList.DataBind();
            totalCount = pager.TotalRecordCount;
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
    private Album currentAlbum;
    protected Album CurrentAlbum
    {
        get
        {
            if (currentAlbum == null) currentAlbum = D4D.Platform.D4DGateway.AlbumProvider.GetAlbum(AlbumId);
            return currentAlbum;
        }
    }
    protected int BandId
    {
        get
        {
            if (String.IsNullOrEmpty(Request["id"]))
                return CurrentAlbum.BandId;
            else 
                return int.Parse(Request["id"]);
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
</script>