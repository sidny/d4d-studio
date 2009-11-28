<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
<script src="/static/js/jquery.pagination.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server"><div class="cd_body journey_bg">
  <!--left-->
  <div class="left floatleft">
    <div class="spacer" style="height:43px;"></div>
	
    <div class="journey_month">
	  <ul class="journey_month_title">
	  </ul>
	  <ul class="journey_week_title">
	  	<li class="floatleft">日</li>
		<li class="floatleft">一</li>
		<li class="floatleft">二</li>
		<li class="floatleft">三</li>
		<li class="floatleft">四</li>
		<li class="floatleft">五</li>
		<li class="floatleft">六</li>
	  </ul>
	  <ul class="journey_month_date">
	  </ul>
	</div>
	
  </div>
  <!--left/-->
  <!--right-->
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  <div class="cd_title journey_title">
	  	<h1 class="font24 floatleft">- <%=sDate.ToString("yyyy年M月") %></h1> 
	  </div>
	  <div class="spacer" style="height:20px"></div>
	  
	  <asp:Repeater ID="repList" runat="server">
       <HeaderTemplate>
        <div class="journey_table">
	    <div class="journey_table_title">
	        <div class="wid_90">时间</div>
		    <div class="wid_93">地点</div>
		    <div class="wid_130">活动名称</div>
		    <div class="wid_210">活动说明</div>
	      </div>
	    <div id="calender">
      </HeaderTemplate>
      <ItemTemplate>
      <div class="journey_table_con date<%#((Show)Container.DataItem).ShowDate.ToString("yyyyMMdd")%>">
	        <div class="wid_90"><%#((Show)Container.DataItem).ShowDate.ToString("yyyy-MM-dd") %><%#GetExpireString(Container.DataItem)%></div>
	        <div class="wid_93"><%#((Show)Container.DataItem).ShowPlace%></div>
	        <div class="wid_130"><%#((Show)Container.DataItem).Title%></div>
	        <div class="wid_210"><%#((Show)Container.DataItem).Body%></div>
		  <div class="clear"></div>
	      </div>
    </ItemTemplate>
    <FooterTemplate>
        </div></div>
  </FooterTemplate>
  </asp:Repeater>
	  </div>
	  <div class="spacer" style="height:35px"></div>
	  
	  <div id="pager" class="pages_num margincenter">
			
		</div>
	  
	  
	  
	  <div class="spacer" style="height:50px"></div>
	  
      
	  <div class="clear"></div>
    </div>
	<div class="clear"></div>
	</div>
	<div class="clear"></div>
  </div>
  <!--right/-->
  <div class="clear"></div>
</div>
<script type="text/javascript">
     

    $(document).ready(function() {
        var cur = parseInt("<%=PageIndex %>");
        var total = parseInt("<%=PageTotalCount %>");
        var pageSize = 5;
		window.$rows = $("#calender").children();
		$rows.filter("div:gt("+(pageSize-1)+")").hide();
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
						for(var i = 0;i<pageSize ;i++){
							if((i+page*pageSize) == $rows.length) break;
							$rows.eq(i+page*pageSize).show();	
						}
					}
	});
	    function showlist(str,self){
            $rows.hide().filter("div.date"+str).show();
            $(self).parent().find(".white").attr("class","blue");
            self.className="white";
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
        var t = "<li class=\"blue\" onclick=\"showlist({1},this);return false;\">{0}</li>";
        var reg = /{(\d)}/gi;
        $(".journey_month_title").html('<li class="floatleft journey_month_up"><a href="/calender/d'+(getMonthString(lastMonth))+'.html">'+(lastMonth.getMonth()+1)+'月</a></li>'
                  +'<li class="floatleft journey_month_today">'+firstday.getFullYear() + '年'+ (firstday.getMonth() + 1)+ '月'+'</li>'
                  +'<li class="floatleft journey_month_next"><a href="/calender/d'+(getMonthString(nextMonth))+'.html">'+(nextMonth.getMonth()+1)+'月</a></li>');
                  
        var str = "";
        for (var i = 0; i < firstday.getDay(); i++) {
            str += '<li class="lightgreen">' + (new Date(year, month, i - firstday.getDay())).getDate() + "</li>";
        }
        for (var i = 1; i <= lastday.getDate(); i++) {
            var day = new Date(year, month - 1, i);
            if(param.date[i]){
                var o = [i,param.date[i]];
                a = t.replace(reg,function(){return o[arguments[1]]});
             }else{
                a = '<li>'+ i +'</li>';
             }
            str += a;
        }
        for (var i = 1; i <= 6 - lastday.getDay(); i++)
            str += '<li class="lightgreen">'+ i +'</li>';
        this.html(str);
        return this;
        function getMonthString(date){
	    var month = "0"+(date.getMonth()+1) + "";
		month = month.substring(month.length-2,month.length);
            return date.getFullYear() + month;
        }
    }
        $(".journey_month_date").drawCalender({year:<%=sDate.Year %>,
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
            return D4D.Web.Helper.Helper.BandId;
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
   
</script>
