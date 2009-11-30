<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<div class="left floatleft">
<div class="spacer" style="height:56px;"></div>
<div class="slider">
<div class="aligncenter cd_pages prev"><img src="/static/images/ico_arrow_1.gif" /></div>
<div class="spacer"></div>
<div class="spacer"></div>
<div class="jCarouselLite">
<asp:Repeater ID="repMusicTitle" runat="server">
    <HeaderTemplate>
     <ul class="cd_list">
    </HeaderTemplate>
    <ItemTemplate>
    <li>
		<span><a href="<%#(((MusicTitle)Container.DataItem).MusicId) %>.html"><img src="<%#((MusicTitle)Container.DataItem).SImage %>" width="75" height="65" /></a></span>
		<a href="<%#(((MusicTitle)Container.DataItem).MusicId) %>.html">
        <%#((MusicTitle)Container.DataItem).Title %></a>
	</li>
    </ItemTemplate>
    <FooterTemplate>
    </ul>
    </FooterTemplate>
</asp:Repeater>
</div>
<div class="aligncenter cd_pages next"><img src="/static/images/ico_arrow.gif" /></div>
</div>
</div>
<script type="text/javascript">
    $(function() {
        $(".slider .jCarouselLite").jCarouselLite({
            btnNext: ".slider .next",
            btnPrev: ".slider .prev",
            speed: 500,
            vertical: true,
            circular: false,
            visible: 4
        });
    });

</script>
 
<script  runat="server">
    public string Channel;
    private static Hashtable channelList = new Hashtable();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = 10000;
        pager.CurrentPageNumber = 1;
		
        repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitlesByBandId(pager, D4D.Web.Helper.Helper.BandId,
        D4D.Platform.Domain.PublishStatus.Publish);
        repMusicTitle.DataBind();

    }
</script>
