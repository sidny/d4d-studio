<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader"></asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<script type="text/javascript" src="/static/js/jquery.highlight.js"></script>
<style type="text/css">
    .highlight {  color:Red }
</style>
<%if (!string.IsNullOrEmpty(SearchText)) {%>
<script type="text/javascript">
    $(document).ready(function() {
    $(".search-list").highlight("<%=SearchText %>");
    });
</script>
<%} %>
<div class="sub-title">
  <p class="title">搜索结果</p>
  <p class="nav-link">您的位置：首页 > 搜索</p>
</div>

<div class="search">
    <div class="search-nav">
    <%=GetSearchTab() %>      
    </div>
    <div class="search-list">
    <asp:Literal ID="litInfo" runat="server"></asp:Literal>
    <asp:Repeater ID="repList" OnItemDataBound="repList_ItemDataBound" runat="server">
     <HeaderTemplate>
      <ul>
     </HeaderTemplate>
         <ItemTemplate>
          <li>
                <p>[<asp:Literal ID="litType" runat="server"></asp:Literal>] <asp:Literal ID="litTitle" runat="server"></asp:Literal></p>
                <p> <asp:Literal ID="litBody" runat="server"></asp:Literal></p>
            </li>          
         </ItemTemplate>
      <FooterTemplate>
      	</ul>
      </FooterTemplate>   
    </asp:Repeater>        
    </div>
    <% if (SearchType != "all")
       { %>
      <div id="pager" class="pagestyle"></div>
      <%} %>
</div>
 <% if (SearchType != "all")
       { %>
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
  <%} %>
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

    private int totalCount;
    protected int PageTotalCount
    {
        get
        {
            return totalCount;
        }
    }
    protected int PageSize = 15;

    /// <summary>
    /// 搜索文字 urlencode！
    /// </summary>
    protected string SearchText
    {
        get
        {
            return Request.QueryString["s"];
        }
    }

    protected string SearchType
    {
        get
        {
            string type = Request.QueryString["t"];
            if (string.IsNullOrEmpty(type)) return "all";
            else return type.ToLower();
        }
    }
    private const string SearchTabPFormat = "<p {0}>{1}</p>";
    private const string AFormat = "<a href=\"{0}\">{1}</a>";
    private const string tabSelectedForamt = "class=\"on\"";
    private const string baseSearchUrl = "/search.html";
    protected string GetSearchTab()
    {
        StringBuilder sb = new StringBuilder(1024);
        
        string searchUrl = 
            baseSearchUrl+"?s="+HttpUtility.UrlEncode(SearchText);
        
        sb.AppendFormat(SearchTabPFormat,
            (SearchType=="all"?tabSelectedForamt:string.Empty),
            string.Format(AFormat, searchUrl, "全部"));

        sb.AppendFormat(SearchTabPFormat,
           (SearchType == "news" ? tabSelectedForamt : string.Empty),
           string.Format(AFormat, searchUrl+"&t=news", "星闻"));

        sb.AppendFormat(SearchTabPFormat,
           (SearchType == "show" ? tabSelectedForamt : string.Empty),
           string.Format(AFormat, searchUrl + "&t=show", "星程"));

        sb.AppendFormat(SearchTabPFormat,
           (SearchType == "music" ? tabSelectedForamt : string.Empty),
           string.Format(AFormat, searchUrl + "&t=music", "音乐"));

        sb.AppendFormat(SearchTabPFormat,
           (SearchType == "video" ? tabSelectedForamt : string.Empty),
           string.Format(AFormat, searchUrl + "&t=video", "视频"));
        
        return sb.ToString();
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(SearchText))
            {
                BindSearch(PageIndex);
            }
            else
                litInfo.Text = "无搜索结果！"; 
        }

    }

    private void BindSearch(int pageIndex)
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;

        List<SearchResult> list = new List<SearchResult>();
        switch (SearchType)
        {
            case "news":
                list = D4DGateway.SearchProvider.GetPagedSearch(pager,
                    SearchText, ObjectTypeDefine.News);
                totalCount = pager.TotalRecordCount;            
                break;
            case "show":
                list = D4DGateway.SearchProvider.GetPagedSearch(pager,
                   SearchText, ObjectTypeDefine.Show);
                totalCount = pager.TotalRecordCount;            
                break;
            case "music":
                list = D4DGateway.SearchProvider.GetPagedSearch(pager,
                   SearchText, ObjectTypeDefine.MusicTitle);
                totalCount = pager.TotalRecordCount;            
                break;
            case "video":
                list = D4DGateway.SearchProvider.GetPagedSearch(pager,
                   SearchText, ObjectTypeDefine.Video);
                totalCount = pager.TotalRecordCount;            
                break;
            default:
                pager.RecordsPerPage = 5;

                List<SearchResult> listNews = D4DGateway.SearchProvider.GetPagedSearch(pager,
                    SearchText, ObjectTypeDefine.News);
                List<SearchResult> listMusic = D4DGateway.SearchProvider.GetPagedSearch(pager,
                   SearchText, ObjectTypeDefine.MusicTitle);
                List<SearchResult> listShow = D4DGateway.SearchProvider.GetPagedSearch(pager,
                   SearchText, ObjectTypeDefine.Show);
                List<SearchResult> listVideo = D4DGateway.SearchProvider.GetPagedSearch(pager,
                   SearchText, ObjectTypeDefine.Video);

                if (listNews != null && listNews.Count > 0)
                    list.AddRange(listNews);
                if (listShow != null && listShow.Count > 0)
                    list.AddRange(listShow);
                if (listMusic != null && listMusic.Count > 0)
                        list.AddRange(listMusic);
                if (listVideo != null && listVideo.Count > 0)
                    list.AddRange(listVideo);
                break;
        }
        if (list != null && list.Count > 0)
        {
            litInfo.Text = string.Empty;
            repList.DataSource = list;
            repList.DataBind();
        }
        else
            litInfo.Text = "无搜索结果！";
    }
    private const int MaxBodyCount = 200;
    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        SearchResult m = e.Item.DataItem as SearchResult;

        if (m != null)
        {
            Literal litType = e.Item.FindControl("litType") as Literal;
            Literal litTitle = e.Item.FindControl("litTitle") as Literal;
            Literal litBody = e.Item.FindControl("litBody") as Literal;

        
            switch (m.ObjectType)
            {
                case ObjectTypeDefine.News:
                    litType.Text = string.Format(AFormat, "/news.html", "星闻");
                    litTitle.Text = string.Format(AFormat, "/news/d/" + m.ObjectId.ToString()
                        + ".html",
                        m.Title);
                    litBody.Text = (m.Body.Length > MaxBodyCount) ? m.Body.Substring(0, MaxBodyCount)
            : m.Body;
                    break;
                case ObjectTypeDefine.MusicTitle:               
                    litType.Text = string.Format(AFormat, "/music.html", "音乐");
                    litTitle.Text = string.Format(AFormat, "/music/b"+m.BandId.ToString()+"/song/"+m.ObjectId.ToString()
                        + ".html",
                      m.Title);
                    litBody.Text = (m.Body.Length > MaxBodyCount) ? m.Body.Substring(0, MaxBodyCount)
            : m.Body;
                    break;
                case ObjectTypeDefine.Show:
                    litType.Text = string.Format(AFormat, "/calender.html", "星程");
                    litTitle.Text = string.Format(AFormat, "/calender/b" + m.BandId.ToString()+"/d"+
                        m.PublishDate.ToString("yyyyMM") + ".html",
                      m.Title);
                    litBody.Text = (m.Body.Length > MaxBodyCount) ? m.Body.Substring(0, MaxBodyCount)
            : m.Body;
                    break;                    
                case ObjectTypeDefine.Video:
                    litType.Text = string.Format(AFormat, "/video.html", "视频");
                    litTitle.Text = string.Format(AFormat, "/video/d/" + 
                        m.ObjectId.ToString() + ".html",
                      m.Title);
                    //litBody.Text = m.Body;
					litBody.Visible = false;
                    break;
            }
            litBody.Text+="...";
        }
    }
    
</script>