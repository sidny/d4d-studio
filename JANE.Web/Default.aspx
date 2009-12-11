<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace=" D4D.Platform" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="header">
<style type="text/css">
.main{ width:100%; position:relative;}
</style>
<script type="text/javascript">
    var data = { movie:"/static/images/photo.swf"};
    data.newsList = [];
    <%for(int i = 0 ; i<NewsList.Count;i++){
        News item = NewsList[i];
    %>
       data.newsList.push({
          title:'<%=item.Title.Trim() %>',
          url:'/news/d/<%=item.NewsId %>.html',
          date:'<%=item.PublishDate.ToString("yyyy-MM-dd") %>'
       });
    <%} %>
    data.showList = [];
    <%for(int i = 0 ; i<ShowList.Count;i++){
        Show item = ShowList[i];
    %>
       data.showList.push({
          title:'<%=item.Title.Trim() %>',
          url:'/calender/b<%=BandId %>/d<%=item.ShowDate.ToString("yyyyMM") %>.html',
          date:'<%=item.ShowDate.ToString("yyyy-MM-dd") %>'
       });
    <%} %>
    function homeReady() {
        var flash = window["index"] || document["index"];
        flash.setContent({movie:"/static/images/photo.swf"})
    }
</script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server" ID="Main">
<div>
<script type="text/javascript">
     AC_FL_RunContent(
		"src", "/static/images/index",
		"width", "100%",
		"height", "630",
		"id", "index",
		"quality", "high",
		"name", "index",
		"allowScriptAccess", "always",
		"wmode","transparent",
		"flashvars", "ready=homeReady&wWidth=" + $(window).width(),
		"type", "application/x-shockwave-flash",
		"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
	</script>
</div>
</asp:Content>
<script runat="server">
    protected List<News> newsList;
    protected List<Show> showList;
    protected int BandId
    {
        get { return D4D.Web.Helper.Helper.BandId; }
    }
    protected List<News> NewsList
    {
        get
        {
            if (newsList == null)
            {
                PagingContext pager = new PagingContext();
                pager.RecordsPerPage = 4;
                pager.CurrentPageNumber = 1;
                newsList = D4DGateway.NewsProvider.GetPagedNewsByNewsType(pager,(BandType)BandId, PublishStatus.Publish, NewsRemarkType.Normal);
            }
            return newsList;

        }
    }
    protected List<Show> ShowList
    {
        get
        {
            if (showList == null)
            {
                PagingContext pager = new PagingContext();
                pager.RecordsPerPage = 4;
                pager.CurrentPageNumber = 1;
                showList = D4DGateway.ShowProvider.GetPagedShowByBandId(pager,BandId, PublishStatus.Publish);
            }
            return showList;
        }
    }
</script>