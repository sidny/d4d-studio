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
            <p class="pic"><a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>"><img src="<%#((MusicTitle)Container.DataItem).SImage %>" width="75" height="65" /></a></p>
            <p class="text"><a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>">
            <%#((MusicTitle)Container.DataItem).Title %></a> 
               <br />
               歌手：<%#((MusicTitle)Container.DataItem).BandId %>
               发行：<%#GetDate(((MusicTitle)Container.DataItem).PublishDate)%>
            </p>
            </li>
            <%#(Container.ItemIndex%2 == 1)?"<li class=\"line\"></li>":"" %>
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
        $("#pager").pagination(
          total,
                {
                    items_per_page: 1,
                    num_display_entries: 10,
                    current_page: cur - 1,
                    link_to: "/music/b<%=BandId %>/__id__.html",
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
            repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitlesByBandId(pager,
               BandId, D4D.Platform.Domain.PublishStatus.Publish);
        }
        else
        {
            repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitles(pager,
                           D4D.Platform.Domain.PublishStatus.Publish);
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
                if (IsRewrite) return string.Format("/music/b{0}/s{1}.html",BandId, id);
                else return string.Format("songs.aspx?id={0}&bandid={1}", id, BandId);
            default:
                return (IsRewrite)? "/music.html":"index.aspx";
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
</script>

