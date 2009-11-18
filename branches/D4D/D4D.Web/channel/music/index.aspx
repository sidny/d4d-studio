<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
    <div class="music">
    <asp:Repeater ID="repMusicTitle" runat="server">
        <HeaderTemplate>
            <ul>
        </HeaderTemplate>
        <ItemTemplate>
            <li>            
            <p class="pic"><a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>"><img src="<%#((MusicTitle)Container.DataItem).LImage %>" width="60" height="60" /></a></p>
            <p class="text"><%#GetNewImage((MusicTitle)Container.DataItem)%><a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>">
            <%#((MusicTitle)Container.DataItem).Title %></a> 
               <br />
               歌手：<%#GetBandName(((MusicTitle)Container.DataItem).BandId)%>
               &nbsp;&nbsp;发行：<%#GetDate(((MusicTitle)Container.DataItem).PublishDate)%>
            </p>
            </li>
            <%#(Container.ItemIndex%2 == 1)?"<li class=\"line\">&nbsp;</li>":"" %>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
    <div class="pagestyle" id="pager"></div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
    var cur = parseInt("<%=PageIndex %>");
    var total = parseInt("<%=PageTotalCount %>");
        var href = location.href;
        if(href.match(/page=\d+/gi)) href = href.replace(/page=\d+/ig,"page=__id__");
        else href +="?page=__id__";
        $("#pager").pagination(
          total,
                {
                    items_per_page: 10,
                    num_display_entries: 10,
                    current_page: cur - 1,
                    link_to: href,
                    prev_text: "上一页",
                    next_text: "下一页",
                    callback: function() { return true; }
                });
    });
</script>
</asp:Content>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        BindMusicTitleRep(PageIndex);
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
    protected int DateYear
    {
        get
        {
            string dateid = Request.QueryString["date"];
            if (string.IsNullOrEmpty(dateid)) return 0;

            int id = 0;

            int.TryParse(dateid, out id);
            return id;
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
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = 10;
        pager.CurrentPageNumber = pageIndex;
        if (BandId > 0)
        {
            if (DateYear <= 1950)
                repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitlesByBandId(pager,
                   BandId, D4D.Platform.Domain.PublishStatus.Publish);
            else
            {
                repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitlesByBandIdANDPublishYear(pager,
                    BandId, DateYear, PublishStatus.Publish);
            }
        }
        else
        {
            if (DateYear <= 1950)
                repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitles(pager,
                               D4D.Platform.Domain.PublishStatus.Publish);
            else
            {
                repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitlesByPublishYear(pager,
                    DateYear, PublishStatus.Publish);
            }
        }
        repMusicTitle.DataBind();
        totalCount = pager.TotalRecordCount;

    }
    protected string GetUrl(int id, int type)
    {
        switch (type)
        {
            case 1:
                if (IsRewrite)  return string.Format("/music/b{0}.html", id);
                else return string.Format("index.aspx?id=" + id);

            case 2:
                if (IsRewrite) return string.Format("/music/b{0}/song/{1}.html",BandId, id);
                else return string.Format("songs.aspx?id={0}&bandid={1}", id, BandId);
            default:
                return (IsRewrite)? "/music.html":"index.aspx";
        }
        
    }
    protected string GetDate(DateTime date)
    {
		if(date.Year > 2000)
        return date.ToString("yyyy-MM-d");
		else
			return "未发行";
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
    protected string GetBandName(int id)
    {
        string s = string.Empty; 
            BandInfo band ;
            D4D.Web.Helper.Helper.BandColl.TryGetValue(id, out band);
            if(band!=null)
                 s = band.BandName;
            return s;
    }
    protected string GetNewImage(MusicTitle m)
    {
        if (DateTime.Now > m.PublishDate.AddDays(7))
            return "";
        else
            return "<img src=\"/static/images/new.gif\" align=\"absmiddle\"> ";
    }
</script>

