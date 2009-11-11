<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="sub-title">
  <p class="title">星程</p>
  <p class="nav-link">您的位置：首页 > 星程 > <%=BandInfo(BandId).BandName %>星程</p>
</div>
<style title="text/css"> 
.sub-nav li.sub {
    background:none; height:auto; line-height:28px; text-align:center; font-weight:normal; padding-top:10px; padding-bottom:10px;
}
.sub-nav li.sub a {
    display:block; 
}
.sub-nav li.sub td{
    color:#676767; background:#e2e2e2; width:28px; height:28px;font-size:12px;
}
.sub-nav li.sub td.disabled{
    color:#969696; background:#f4f4f4;
}

.sub-nav li.sub th{
    background:#b7b7b7; color:White;font-size:12px;
}
.sub-nav li.sub td a{
    display:block;width:26px; height:26px; border:1px solid red; background:red; color:white; text-decoration:none;
}
.sub-nav li.sub td a:hover{
    color:Red; background:white;
}
.calander td{ line-height:18px;}
</style>
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
            <li>》<font color="red"><%=i.BandName%>星程</font></li>
            <li class="sub" id="calender">
                
                
                
            </li>
    
    <%} else
          {%>
     <li>》<a href="/calender/b<%=i.BandId %>/d<%=DateStr%>.html"><%=i.BandName%>星程</a></li>
    <%}
      } %>
  </ul>
</div>

<div class="main">
  <asp:Repeater ID="repList" runat="server">
  <HeaderTemplate>
  <table width="690" border="0" cellspacing="6" cellpadding="0" class="calander">
    <tr>
      <th colspan="5"><img src="/static/images/calendar_nav.png" width="690" height="38" /></th>
      </tr>
      </HeaderTemplate>
      <ItemTemplate>
        <tr class="date<%#((Show)Container.DataItem).ShowDate.ToString("yyyyMMdd")%>">
          <td width="56" align="center" valign="middle"><img src="<%#BandInfo(((Show)Container.DataItem).BandId).Info1%>" width="56" height="56" /><br />
			<%#BandInfo(((Show)Container.DataItem).BandId).BandName%>	</td>
          <td width="110" align="center" valign="middle"><%#((Show)Container.DataItem).ShowDate.ToString("yyyy-MM-dd") %><%#GetExpireString(Container.DataItem)%></td>
          <td width="110" align="center" valign="middle"><%#((Show)Container.DataItem).ShowPlace%></td>
          <td width="136" align="center" valign="middle"><%#((Show)Container.DataItem).Title%></td>
          <td width="278" valign="middle"><%#((Show)Container.DataItem).Body%></td>
        </tr>
        <tr><td colspan="5" class="line"></td></tr>
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
        var pageSize = 5;
		window.$rows = $(".calander").find("tr:gt(0)");
		$rows.filter("tr:gt(9)").hide();
        $("#pager").pagination(
          total,
                {
                    items_per_page: pageSize,
                    num_display_entries: 10,
                    current_page: cur - 1,
                    prev_text: "上一页",
                    next_text: "下一页",
                    callback: function(page) { 
						$rows.hide();
						for(var i = 0;i<10 ;i++){
							if((i+page*10) == $rows.length) break;
							$rows.eq(i+page*10).show();	
						}
					}
	});
	    function showlist(str){
            $rows.hide().filter("tr.date"+str).show();
            $("#pager").hide();
            return false;
        }
        window.showlist = showlist;
        jQuery.fn.drawCalender = function(param) {
        var param = param || {};
        var today = new Date();
        var month = param.month || today.getMonth() + 1;
        var year = param.year || today.getFullYear();
        var lastMonth = new Date(year, month -1, 0);
        var nextMonth = new Date(year, month , 1);
        var lastday = new Date(year, month, 0);
        var firstday = new Date(year, month - 1, 1);
        month = firstday.getMonth() + 1;
        var t = "<td><a href=\"#\" onclick=\"showlist({1});return false;\">{0}</a></td>";
        var reg = /{(\d)}/gi;
        var str = "<table border=\"0\" cellspacing=\"1\" cellpadding=\"0\"><tr>"
                  +"<th colspan=\"2\"><a href=\"/calender/d"+(getMonthString(lastMonth))+".html\">"+(lastMonth.getMonth()+1)+"月</a></th>"
                  +"<th colspan=\"3\">" + firstday.getFullYear() + "年" + (firstday.getMonth() + 1) + "月</td>"
                  +"<th colspan=\"2\"><a href=\"/calender/d"+(getMonthString(nextMonth))+".html\">"+(nextMonth.getMonth()+1)+"月</a></th>"
                  +"</tr><tr>";
        
            str += "<th>日</th><th>一</th><th>二</th><th>三</th><th>四</th><th>五</th><th>六</th>";
       
        str += "<tr>";
        for (var i = 0; i < firstday.getDay(); i++) {
            str += "<td class=\"disabled\">" + (new Date(year, month, i - firstday.getDay())).getDate() + "</td>";
        }
        for (var i = 1; i <= lastday.getDate(); i++) {
            var day = new Date(year, month - 1, i);
            if(param.date[i]){
                var o = [i,param.date[i]];
                a = t.replace(reg,function(){return o[arguments[1]]});
             }else{
                a = "<td>"+ i +"</td>";
             }
            str += a;
            if (day.getDay() == 6)
                str += "</tr><tr>";

        }
        for (var i = 1; i <= 6 - lastday.getDay(); i++)
            str += "<td class=\"disabled\">" + i + "</td>";
        str += "</tr></table>";
        this.html(str);
        return this;
        function getMonthString(date){
	    var month = "0"+(date.getMonth()+1) + "";
		month = month.substring(month.length-2,month.length);
            return date.getFullYear() + month;
        }
    }
        $("#calender").drawCalender({year:<%=sDate.Year %>,
                                     month:<%=sDate.Month %>,
                                     date:{<%=DateCollJson %>}});
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
    protected int PageSize = 1000;
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
	public static IDictionary<int,BandInfo> BandColl
        {
            get
            {
                IDictionary<int, BandInfo> coll = D4D.Web.Helper.Helper.BandColl;
					
				BandInfo band = new BandInfo();
				band.BandId = 0;
				band.BandName = "公司";
				coll.Add(band.BandId,band);
                return coll;

            }
        }
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = "/calender";
        if(BandId > 0) url+= "/b"+BandId.ToString();
        if(string.IsNullOrEmpty(DateStr)){
            url += string.Format("/d{0}.html",DateTime.Now.ToString("yyyyMM"));
            Response.Redirect(url,false);
        }else 
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

    protected string DateCollJson
    {
        get
        {
                List<string> dlist = new List<string>();
                foreach (var i in DateList)
                {
                    dlist.Add(string.Format("{0}:\"{1}\"",i.Day.ToString(),i.ToString("yyyyMMdd")));
                }
                return String.Join(",",dlist.ToArray());
        }
    }
    private List<DateTime> DateList = new List<DateTime>();
    protected DateTime sDate = DateTime.MinValue;
    protected DateTime eDate = DateTime.MinValue;
    private void BindList()
    {
    	System.Globalization.CultureInfo zhCN = new System.Globalization.CultureInfo("zh-CN"); 
        
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
        System.Collections.Generic.IList<Show> list;
        if (BandId > 0)
        {
            list = D4D.Platform.D4DGateway.ShowProvider.GetPagedShowByBandANDShowDate(pager, BandId, sDate, eDate, PublishStatus.Publish);
        }
        else
        {
            list = D4D.Platform.D4DGateway.ShowProvider.GetPagedShowByShowDate(pager, sDate, eDate, PublishStatus.Publish);
        }
        repList.DataSource = list;
        totalCount = pager.TotalRecordCount;
        repList.DataBind();

        IDictionary<string, DateTime> dict = new Dictionary<string, DateTime>();
        for (int i = 0; i < list.Count; i++)
        {
            Show item = list[i] as Show;
            dict[item.ShowDate.ToString("yyyyMMdd")] = item.ShowDate;
            
       }
        DateList = new List<DateTime>(dict.Values);

    }
	protected string GetExpireString(Object o)
    {
        if (DateTime.Now > ((Show)o).EndDate.AddDays(1))
        {
            return "<br/><font style=\"color:#bbb\">已过期</font>";
        }
        else
        {
            return string.Empty;
        }
    }
    protected BandInfo BandInfo(int Id)
    {
        BandInfo band = new BandInfo();
        BandColl.TryGetValue(Id, out band);
        return band;
    }
</script>
