<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server">
  <style type="text/css">
    .content{ height:380px; padding:20px 0;}
    .content dt{ font-size:14px; font-weight:bold; font-family:"微软雅黑","黑体"; height:20px; margin-bottom:10px;}
    .content dt.line{ border-bottom:1px solid #cbcbcb}
    .content dl{ padding:0; float:left;}
    .content dd{color:#939393; margin:0; padding:0; height:24px;}
    .content dd.dash{ background-image:url(/static/images/dd.gif); background-position:0 5px; background-repeat:no-repeat;}
    .content label{color:#939393; font-family:Arial; font-size:11px; padding:0 12px;}
    .content .show,.content .singer{width:200px;}
    .content .news,.content .music{ width:440px; margin-left:25px;}
    .content .video,.content .photo{ width:280px;margin-left:25px;}
    .content .news dd.dash{ padding-left:12px;}
    .content .news dd.title{ height:72px;}
    .content .news dd.title a{ font-weight:bold; }
    .content .news dd.title p.image{ float:left; border:1px solid #c5c5c5; background:#ebebeb; padding:2px; margin-right:10px;}
    .content .video dd.player{ width:157px; height:131px; float:right; padding-right:10px;}
    .content .video dd{ float:left; width:56px; height:45px; overflow:hidden}
    .content .video dd a{ border:2px solid white; display:block}
    .content .video dd a.on,.content .video dd a:hover{ border:2px solid red;}
    .content .singer dd{border:1px solid #c5c5c5; background:#ebebeb; padding:5px 0 5px 5px;_padding-left:2px; height:103px; }
    .content .singer dd a{ display:block; border:1px solid #c5c5c5; background:white; line-height:20px; width:80px; text-align:center;color:Red; float:left; margin:0 5px;}
    .content .singer dd a img{ display:block;}
    .content .music dd{ width:25%; text-align:center; float:left}
    .content .music dd a{ display:block; margin:0 auto;}
    .content .music dd a.cd img{ border:1px solid #c5c5c5; background:#ebebeb; padding:2px; }
    .content .music dd a.cd-title{ margin-top:10px;}
    .content .photo dd{ float:left; padding-right:7px; padding-bottom:8px; height:58px; width:85px;}
    .content .photo dd a img{ border:2px solid #c5c5c5; width:81px; height:54px;}
    .content .photo dd a:hover img{ border:2px solid red;}
	.svw { text-align:center; padding-top:100px;background: #fff; position:relative;} 
	.svw ul {position: relative; left: -999em;}  /*core classes*/
	.stripViewer {  position: relative; overflow: hidden;   margin: 0 0 1px 0; }
	.stripViewer ul { /* this is your UL of images */ margin: 0; padding: 0; position: relative; left: 0; top: 0; width: 1%; list-style-type: none; } 
	.stripViewer ul li {  float:left; } 
	.stripTransmitter { overflow: auto; width: 1%; position:absolute;margin-top:-30px;}
	.stripTransmitter ul { margin: 0; padding: 0; position: relative; list-style-type: none; float:right;} 
	.stripTransmitter ul li{ width: 20px; float:left; margin: 0 4px 2px 0; }
	.stripTransmitter a{ font: bold 14px "微软雅黑",Verdana, Arial; text-align: center; line-height: 22px; background: black; color: #666; text-decoration: none; display: block; }
	.stripTransmitter a:hover, a.current{ background: #e60012; color: #fff; }  /*tooltips formatting*/ 
	#tooltip { background: #fff; color: #000; opacity: 0.85; border: 5px solid #dedede; } 
	#tooltip h3 {  font: normal 10px Verdana;  margin: 0;  padding: 6px 2px;  border: 0; } 
  </style>
  <script type="text/javascript" src="/static/js/jquery.slideviewer.1.1.js"></script>
  <script type="text/javascript">
      $(window).bind("load", function() {
      $("div#slider").slideView({ easeFunc: "" });
      });
  </script> 
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server">
<div style=" height:290px;overflow:hidden;margin-top:5px;">
<div id="slider" class="svw">
    <ul>
       <%=D4DGateway.CorpInfoProvider.ReadProfileContent("ad") %>
        
    </ul>
</div>
</div>
<div class="content">
    <div class="clearfix" style="height:190px;">
    <dl class="show">
       <dt class="line">最近星程</dt>
        <% foreach (Show item in ShowList)
           { %>
            <dd class="dash"><label><%=item.ShowDate.ToString("MM/dd") %></label><a href="/calender/d<%=item.ShowDate.ToString("yyyyMMdd") %>.html"><%=GetSubString(item.Title,11) %></a></dd>
        <%} %>
    </dl>
    <dl class="news">
        <dt class="line">星闻动态</dt>
         <% for (int i = 0 ;i<NewsList.Count;i++)
           { News item  = NewsList[i]; %>
            
               <%if (i == 0)
                 { %><dd class="title">
                    <%if (!String.IsNullOrEmpty(item.SImage))
                      {%>
                    <p class="image"><img height="60" width="100" src="<%=item.SImage %>" /></p>
                    <%} %>
                    <p><a href="/news/d/<%=item.NewsId %>.html"><%=GetSubString(item.Title, 18)%></a><label><%=item.AddDate.ToString("yyyy-MM-dd") %></label></p>
                    <p style="line-height:20px; padding-top:10px;"><%=GetSubString(item.Body, 55)%></p>
               <%}
                 else
                 { %>
                <dd class="dash"><a href="/news/d/<%=item.NewsId %>.html"><%=GetSubString(item.Title, 18)%></a><label><%=item.AddDate.ToString("yyyy-MM-dd") %></label></dd>
               <%} %>
        <%} %>
    </dl>
    <dl class="video">
        <dt>视频推荐</dt>
        <dd class="player"></dd>
         <% for (int i = 0; i < VideoList.Count;i++ )
            {
                News item = VideoList[i];%>
            <dd><a href="/video/d/<%=item.NewsId %>.html" index="<%=i %>"><img width="52" height="41" src="<%=item.SImage %>" /></a></dd>
            
        <%} %>
        
        <script type="text/javascript">
            $(document).ready(function() {
            var movies = [];
                <% foreach (News item in VideoList){%>
                    movies.push('<%=item.Body%>');
                <%} %>
                $(".video a").click(function(){
                    $(".video a").removeClass("on");
                    $(".video .player").html(movies[$(this).addClass("on").attr("index")].replace(/width="\d+"/i,"width=\"157\"").replace(/height="\d+"/i,"height=\"131\""));
                    return false;
                }).eq(0).click();
            });
        </script>
    </dl>
    </div>
    <div>
    <dl class="singer">
        <dt>旗下艺人</dt>
         <dd class="clearfix">
         <% foreach (BandInfo item in D4D.Web.Helper.Helper.BandList)
           { %>
           <a href="/singer/<%=item.BandId %>.html"><img width="80" height="80" alt="" src="<%=item.Info3 %>" /><%=item.BandName %></a>
        <%} %></dd>
    </dl>
    <dl class="music">
    <dt>专辑推荐</dt>
         <% foreach (MusicTitle item in MusicList)
           { %>
            <dd>
                <a class="cd" href="/music/b0/song/<%=item.MusicId %>.html"><img width="80" height="80" src="<%=item.LImage %>" /></a>
                <a class="cd-title" href="/music/b0/song/<%=item.MusicId %>.html"><%=item.Title %></a>
            </dd>
        <%} %>
    </dl>
    <dl class="photo">
        <dt>图片推介</dt>
        <% foreach (Album item in AlbumList)
           { %>
            <dd><a href="/photo/album/<%=item.AlbumId %>.html"><img alt="" src="<%=item.SImage %>" /></a></dd>
        <%} %>
    </dl>
    </div>
</div>
</asp:Content>

<script runat="server">
    private List<Show> showList;
    private List<News> newsList;
    private List<News> videoList;
    private List<MusicTitle> musicList;
    private List<Album> albumList;
    protected List<Show> ShowList
    {
        get
        {
            if(showList == null){
                PagingContext pager = new PagingContext();
                pager.RecordsPerPage = 6;
                pager.CurrentPageNumber = 1;
                showList =  D4DGateway.ShowProvider.GetPagedShow(pager, PublishStatus.Publish);
            }
            return showList;
        }
    }
    protected List<News> VideoList
    {
        get
        {
            if(videoList == null){
                PagingContext pager = new PagingContext();
                pager.RecordsPerPage = 6;
                pager.CurrentPageNumber = 1;
                videoList = D4DGateway.NewsProvider.GetPagedNews(pager,PublishStatus.Publish,NewsRemarkType.Video);
            }
            return videoList;

        }
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
                newsList = D4DGateway.NewsProvider.GetPagedNews(pager, PublishStatus.Publish, NewsRemarkType.Normal);
            }
            return newsList;

        }
    }
    protected List<MusicTitle> MusicList
    {
        get
        {
            if (musicList == null)
            {
                PagingContext pager = new PagingContext();
                pager.RecordsPerPage = 4;
                pager.CurrentPageNumber = 1;
                musicList = D4DGateway.MusicProvider.GetPagedMusicTitles(pager, PublishStatus.Publish);
            }
            return musicList;

        }
    }
    protected List<Album> AlbumList
    {
        get
        {
            PagingContext pager = new PagingContext();
            pager.RecordsPerPage = 6;
            pager.CurrentPageNumber = 1;
            return D4DGateway.AlbumProvider.GetPagedAlbums(pager, PublishStatus.Publish);
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