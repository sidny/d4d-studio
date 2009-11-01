<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader"></asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">

<div class="video">
<div class="channel">
  <h1><asp:Literal ID="litTitle" runat="server"></asp:Literal></h1>
</div>

<asp:Repeater ID="repList" OnItemDataBound="repList_ItemDataBound" runat="server">
     <HeaderTemplate>
     <ul class="video-list">
     </HeaderTemplate>
         <ItemTemplate>
            <li>
            <p class="image"><a href="/video/d/<%#((News)Container.DataItem).NewsId %>.html"><img src="<%#((News)Container.DataItem).SImage %>" height="96" width="120" alt="<%#HttpUtility.HtmlEncode(((News)Container.DataItem).Title) %>" /></a></p>
            <p><a href="/video/d/<%#((News)Container.DataItem).NewsId %>.html"><%#((News)Container.DataItem).Title %></a></p>
            <p><asp:Literal ID="litListTag" runat="server"></asp:Literal> | <%#((News)Container.DataItem).Hits %>次</p>
            <p><font color="red"> <%#((News)Container.DataItem).PublishDate.ToString("yyyy-MM-dd")%></font></p>
            </li>  
         </ItemTemplate>
      <FooterTemplate>
      	</ul>
      </FooterTemplate>   
</asp:Repeater>
    <div id="pager" class="pagestyle"></div>
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

    private int totalCount;
    protected int PageTotalCount
    {
        get
        {
            return totalCount;
        }
    }
    protected int PageSize = 12;
    /// <summary>
    /// 0 company news 
    /// </summary>
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

    public static IDictionary<int, BandInfo> BandColl
    {
        get
        {
            System.Collections.Generic.IDictionary<int, BandInfo> coll = D4D.Web.Helper.Helper.BandColl;

            BandInfo bandCompany = new BandInfo();
            bandCompany.BandId = 0;
            bandCompany.BandName = "全部";
            coll.Add(bandCompany.BandId, bandCompany);
            return coll;

        }
    } 
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetTitle();
            BindNews(PageIndex);
        }
        
    }
    
    private const string TitleFormat = "{0}视频";
    private const string TitleTagFormat = "/<font color=\"red\">{0}</font>";
    private void SetTitle()
    {
        //check bandName
        BandInfo info;
        if (BandColl.TryGetValue(BandId, out info))
        {
            litTitle.Text = string.Format(TitleFormat,info.BandName);
        }

        if (!string.IsNullOrEmpty(TagName))
        {
            litTitle.Text += string.Format(TitleTagFormat, TagName);            
        }

        if (!string.IsNullOrEmpty(TagTime))
        {
            litTitle.Text += string.Format(TitleTagFormat, TagTime); 
        }
        
    }
    private const int MaxTopCount = 3;
    private void BindNews(int pageIndex)
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;
        List<News> resultList=null;
        List<News> topResultList=null;
        if (BandId < 0)
        {
            resultList = D4DGateway.NewsProvider.GetPagedNews(pager, PublishStatus.Publish,NewsRemarkType.Video);
            if (pageIndex <= 1)
            {
                topResultList = D4DGateway.NewsProvider.GetTopImageNews(MaxTopCount,
                     NewsRemarkType.Video);
            }
        }
        else
        {
            if (TagId > 0)
            {
                resultList = D4DGateway.NewsProvider.GetPagedNewsByTagAndNewsType(pager,
                    PublishStatus.Publish, TagId, (BandType)BandId, NewsRemarkType.Video);
         
            }
            else if (TagYear >= 1900 && TagMonth > 0 && TagMonth <= 12)
            {
                DateTime sTime = new DateTime(TagYear, TagMonth, 1);
                DateTime eTime = sTime.AddMonths(1).AddDays(-1);

                resultList = D4DGateway.NewsProvider.GetPagedNewsByTypeANDPublishDate(pager, 
                    (BandType)BandId, sTime, eTime,
                   PublishStatus.Publish, NewsRemarkType.Video);
             
            }
            else
            {    
                resultList = D4DGateway.NewsProvider.GetPagedNewsByNewsType(pager, (BandType)BandId,
                    PublishStatus.Publish, NewsRemarkType.Video);
                 
            }              
        }
        //band
        if (resultList != null && resultList.Count > 0)
        {
            repList.DataSource = resultList;
            repList.DataBind();
            totalCount = pager.TotalRecordCount;            
          
        }
    }
    private const string SImageFormat = "<p class=\"pic\"><a href=\"{0}\"><img width=\"70\" height=\"60\" src=\"{1}\" /></a></p>";
    protected void repTop_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        News m = e.Item.DataItem as News;

        if (m != null)
        {
          Literal litTopLi = e.Item.FindControl("litTopLi") as Literal ;
         
          

          if (e.Item.ItemIndex == 0)
              litTopLi.Text = "<li class=\"big\">";
          else
          {
              litTopLi.Text = "<li>";
              if (!string.IsNullOrEmpty(m.SImage))
              {
                  Literal litTopImage = e.Item.FindControl("litTopImage") as Literal;
                  litTopImage.Text = string.Format(SImageFormat,
                      "/video/d/" + m.NewsId.ToString() + ".html", m.SImage);                  
              }
              
          }

          Literal litTopTag = e.Item.FindControl("litTopTag") as Literal;
          litTopTag.Text = GetTagHtml(m.NewsId);  
            
        }
    }

    private string GetTagHtml(int newsId)
    {
        string result = string.Empty;
        //get tag
        List<TagRelation> relationList =
        D4DGateway.TagsProvider.GetTagRelationByObject(newsId, ObjectTypeDefine.News);

        if (relationList != null && relationList.Count > 0)
        {
            int maxCount = relationList.Count;
            if (maxCount > 20) maxCount = 20;
            List<int> tagids = new List<int>(maxCount);
            for (int i = 0; i < maxCount; i++)
            {
                tagids.Add(relationList[i].TagId);
            }
            Dictionary<int, Tag> tagDic = D4DGateway.TagsProvider.GetTags20(tagids);

            if (tagDic != null && tagDic.Count > 0)
            {
                StringBuilder sb = new StringBuilder(1024);
                foreach (KeyValuePair<int, Tag> kvp in tagDic)
                {
                    sb.Append(" ");
                    sb.AppendFormat(AFormat,
                     string.Format(TagLinkFormat, BandId, kvp.Key, HttpUtility.UrlEncode(kvp.Value.TagName)),
                     kvp.Value.TagName);
                }


                result = string.Format(TagEmFormat, sb.ToString());
            }

        }
        return result;
    }
    
    private const string TagEmFormat = "<em>标签：{0}</em>";
    private const string AFormat = "<a href=\"{0}\">{1}</a>";
    private const string TagLinkFormat = "/video.html?id={0}&tagid={1}&tag={2}";
    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        News m = e.Item.DataItem as News;

        if (m != null)
        {

            Literal litListTag = e.Item.FindControl("litListTag") as Literal;
            litListTag.Text = GetTagHtml(m.NewsId);
        }
    }
</script>