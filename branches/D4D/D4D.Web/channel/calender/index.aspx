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
			张靓颖	</td>
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
    protected int BandId{
        get
        {
            string queryId = Request.QueryString["id"];
            if (string.IsNullOrEmpty(queryId)) return 0;

            int id = 0;

            int.TryParse(queryId, out id);

            return id;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = "/calender";
        if(BandId > 0) url+= "/b"+BandId.ToString();
        if(string.IsNullOrEmpty(DateStr)){
            url += string.Format("/d{0}.html",DateTime.Now.ToString("yyyyMM"));
            Response.Redirect(url,false);
        }else if (!IsPostBack)
        {
            BindList();
        }
    }
    
    protected string DateStr {
        get
        {
            if(string.IsNullOrEmpty(Request["date"])){
                return string.Empty;
            }else{
                return Request["date"]; 
            }
        }
    }
    

    private void BindList()
    {
    	System.Globalization.CultureInfo zhCN = new System.Globalization.CultureInfo("zh-CN"); 
        DateTime sDate = DateTime.MinValue;
        DateTime eDate = DateTime.MinValue;
        if(DateStr.Length == 6){
            DateTime.TryParseExact(DateStr, "yyyyMM", zhCN, 
                           System.Globalization.DateTimeStyles.None, out sDate);
            eDate = sDate.AddMonths(1);
            eDate = eDate.AddDays(-1);
        }else if(DateStr.Length == 8){
            DateTime.TryParseExact(DateStr, "yyyyMMdd", zhCN, 
                           System.Globalization.DateTimeStyles.None, out sDate);
            eDate = sDate;
        }

        
        PagingContext pager = new PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = PageIndex;
        
        System.Collections.Generic.IList<Show> list = D4D.Platform.D4DGateway.ShowProvider.GetPagedShowByShowDate(pager,sDate,eDate,  PublishStatus.ALL);
        repList.DataSource = list;
        totalCount = pager.TotalRecordCount;
        repList.DataBind();

    }
    protected string GetBandInfo(int bandId){
        return string.Empty;
    }
</script>
