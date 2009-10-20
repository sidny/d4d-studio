<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">

<div class="main">
  <asp:Repeater ID="repList" runat="server">
  <HeaderTemplate>
  <table width="690" border="0" cellspacing="0" cellpadding="0" class="calander">
    <tr>
      <th colspan="5"><img src="/static/images/calendar_nav.png" width="690" height="38" /></td>
      </tr>
      </HeaderTemplate>
      <ItemTemplate>
        <tr>
          <td width="56" align="center" valign="middle"><img src="/static/images/pic_s.png" width="56" height="56" /><br />
            张靓影</td>
          <td width="110" align="center" valign="middle"><%#((Show)Container.DataItem).ShowDate.ToLongDateString() %></td>
          <td width="110" align="center" valign="middle"><%#((Show)Container.DataItem).ShowPlace%></td>
          <td width="136" align="center" valign="middle"><%#((Show)Container.DataItem).Title%></td>
          <td width="278" valign="middle"><%#((Show)Container.DataItem).Body%></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
     </table>
  </FooterTemplate>
  </asp:Repeater>
  <div id="pager" class="pagestyle"></div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        var cur = parseInt("<%=PageIndex %>");
        var total = parseInt("<%=PageTotalCount %>");
        var pageSize = parseInt("<%=PageSize %>");
        var href = location.href;
        if (href.match(/page=\d+/gi)) href = href.replace(/page=\d+/ig, "page=__id__");
        else href += "?page=__id__";
        $("#pager").pagination(
          total,
                {
                    items_per_page: pageSize,
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
            BindList();
        }
    }

   
    private void BindList()
    {
        PagingContext pager = new PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = PageIndex;
        System.Collections.Generic.IList<Show> list = D4D.Platform.D4DGateway.ShowProvider.GetPagedShow(pager,PublishStatus.ALL);
        repList.DataSource = list;
        totalCount = pager.TotalRecordCount;
        repList.DataBind();

    }
</script>
