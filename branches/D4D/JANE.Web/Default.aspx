<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace=" D4D.Platform" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="header">
<style type="text/css">
.main{ width:100%; position:relative;z-index:10}
.news-list{position: absolute; top: 100px; width: 342px; left: 523px;}
.show-list{position: absolute; top: 290px; width: 342px; left: 523px;}
.main li{ height:24px; color:#666}
.main li label{ float:right;}
.main .link{ position:absolute; top:440px; width:500px; text-align:center; left:440px;}
.main .link a{ margin:0 10px;}
.main .link a img{ filter:Gray Alpha(Opacity=15);opacity:0.15;}
.main .link a:hover img{ filter:none;opacity:1;}
#video{
	z-index:100;
    left:20px;
    position:absolute;
	margin-top:-85px;
}
/*.footer_link{ padding-left:200px; width:580px;}*/
</style>
    
<script type="text/javascript">
    function homeReady() {
        var flash = window["index"] || document["index"];
        flash.setContent({movie:"/static/images/photo.swf"})
    }
	/*
	$(function(){
	
		$("<div id=\"video\"></div>").insertAfter($("div.main"))
		.html( AC_FL_RunHTML(
		"src", "/static/images/video",
		"width", "191",
		"height", "133",
		"quality", "high",
		"wmode","transparent",
		"flashvars", "MtvLink=http://mp3.showcitytimes.net/flv/mtv.flv&MtvPic=/static/images/pic.png",
		"type", "application/x-shockwave-flash",
		"pluginspage", "http://www.adobe.com/go/getflashplayer"
		));
	});
	*/
</script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server" ID="Main">
<div>
<script type="text/javascript">
     AC_FL_RunContent(
		"src", "/static/images/index",
		"width", "100%",
		"height", "543",
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
<ul class="news-list">
    <%for(int i = 0 ; i<NewsList.Count;i++){
        News item = NewsList[i];
    %><li><label><%=item.PublishDate.ToString("yyyy-MM-dd") %></label>
    &bull; <a href="/news/d/<%=item.NewsId %>.html"><%=GetSubString(item.Title.Trim(),20) %></a>
       </li><%} %>
</ul>
<ul class="show-list">
    <%for(int i = 0 ; i<ShowList.Count;i++){
        Show item = ShowList[i];
    %>
    <li><label><%=item.ShowDate.ToString("yyyy-MM-dd") %></label>
    &bull; <a href="/calender/b<%=BandId %>/d<%=item.ShowDate.ToString("yyyyMM") %>.html"><%=GetSubString(item.Title.Trim(),20) %></a>
    </li>
    <%} %>
</ul>
<div class="link">
    <a href="http://www.kaixin001.com/zhangliangying" target="_blank"><img src="/static/images/intro/kaixin.gif" /></a>
    <a href="http://www.myspace.cn/zhangliangying " target="_blank"><img src="/static/images/intro/myspace.gif" /></a>
    <a href="http://music.youku.com/JaneZhang" target="_blank"><img src="/static/images/intro/youku.gif" /></a>
    <a href="http://blog.sina.com.cn/zhangliangying" target="_blank"><img src="/static/images/intro/sina.gif" /></a>
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
	protected string GetSubString(string s, int length)
    {
        string temp = s;
        if (s.Length > length)
        {
            temp = s.Substring(0, length) + "…";
        }
        return temp;
    }
</script>