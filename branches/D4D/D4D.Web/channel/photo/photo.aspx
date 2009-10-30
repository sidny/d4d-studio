<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="sub-title">
        <p class="title">
            图片</p>
        <p class="nav-link">
            您的位置：首页 > 图片 > <%=CurrentAlbum.Title %></p>
    </div>
<div class="sub-nav">
  <ul>
    <%
	List<int> list = new List<int>(BandColl.Keys.ToArray());
	list.Sort();
	for (int n =0;n<list.Count;n++)
      {
		  var i = BandColl[list[n]];
          if (i.BandId == BandId)
          {
           %>
            <li>》<font color="red"><%=i.BandName%>相册</font></li>
            <li class="sub">
                
                
                
            </li>
    
    <%} else
          {%>
     <li>》<a href="/photo/<%=i.BandId %>.html"><%=i.BandName%>相册</a></li>
    <%}
      } %>
  </ul>
</div>
    <div class="main">
<div class="channel">
  <h1>全部照片 / <font color="red"><%=CurrentAlbum.Title %></font></h1>
</div>
<div class="album_list">
	
	<asp:Repeater runat="server" ID="repList">
	    <HeaderTemplate>
	    <table width="100%" cellspacing="20" border="0" cellpadding="0"><tr>
	    </HeaderTemplate>
	    <ItemTemplate>
	       <td width="33%" align="center" valign="bottom">
            <p><a href="/photo/album/<%=AlbumId%>/slider.html?id=<%#((D4D.Platform.Domain.Image)Container.DataItem).ImageId%>"><img src="<%#((D4D.Platform.Domain.Image)Container.DataItem).SImageFile %>" /></a></p> 
            <p><a href="/photo/album/<%=AlbumId%>/slider.html?id=<%#((D4D.Platform.Domain.Image)Container.DataItem).ImageId%>"><%#((D4D.Platform.Domain.Image)Container.DataItem).ImageName%></a></p>
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
    protected int AlbumId
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
    protected int PageSize = 12;
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
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;
        if (AlbumId > 0)
        {
            repList.DataSource = D4D.Platform.D4DGateway.AlbumProvider.GetPagedImagesByAlbumId(pager,
               AlbumId,D4D.Platform.Domain.PublishStatus.Publish);
        }
        repList.DataBind();
        totalCount = pager.TotalRecordCount;

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
           return CurrentAlbum.BandId;
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