<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<form runat="server">
<asp:Calendar ID="Calendar1" runat="server" BackColor="#FFFFCC" 
        BorderColor="#FFCC66" BorderWidth="1px" DayNameFormat="Shortest" 
        Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" Height="200px" 
        SelectedDate="2009-10-28" ShowGridLines="True" Width="220px" 
    EnableViewState="False">
        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
        <SelectorStyle BackColor="#FFCC66" />
        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
        <OtherMonthDayStyle ForeColor="#CC9966" />
        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
        <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" 
            ForeColor="#FFFFCC" />
    </asp:Calendar>
    </form>
    <asp:Repeater ID="repMusicTitle" runat="server">
        <HeaderTemplate>
            <ul>
                
        </HeaderTemplate>
        <ItemTemplate>
            <li>            
            <p class="pic"><a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>"><img src="<%#((MusicTitle)Container.DataItem).SImage %>" width="75" height="65" /></a></p>
            <p><a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>">
            <%#((MusicTitle)Container.DataItem).Title %></a></p>
            <p>


歌手：<%#((MusicTitle)Container.DataItem).BandId %>   发行：<%#GetDate(((MusicTitle)Container.DataItem).PublishDate)%>
            </p>
            </li>
            <%#(Container.ItemIndex%2 == 1)?"<li class=\"line\">------------</li>":"" %>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
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
                else return string.Format("songlist.aspx?id={0}&bandid={1}", id, BandId);
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

