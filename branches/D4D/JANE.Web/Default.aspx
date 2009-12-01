<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace=" D4D.Platform" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="header">
<script type="text/javascript">
    var data = {};
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
        var argus = arguments;
        var flash = window[argus[0]] || document[argus[0]];
        flash.sendData(data);
    }
</script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server" ID="Main">
<div>
<script type="text/javascript">     
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